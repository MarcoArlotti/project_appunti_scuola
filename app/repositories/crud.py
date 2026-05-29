from app.db import get_db
import markdown

from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash


def cancella_post(notes,session):
    if session and session["id"] == notes["student_id"]:
        id = notes["id"]
        db = get_db()
        db.execute(
            """DELETE FROM notes WHERE notes.id = ?""",(id,)
        )
        db.commit()

def ottieni_dati():
    db = get_db()
    query = """SELECT * FROM tabella"""
    dati = db.execute(query).fetchall()
    return [dict(dato) for dato in dati]


def get_all_students():
    db = get_db()
    query = """SELECT * FROM students"""
    dati = db.execute(query).fetchall()
    return [dict(dato) for dato in dati]

def get_subjects():
    db = get_db()
    query = "SELECT * FROM subjects"
    subjects = db.execute(query).fetchall()
    return [dict(subject) for subject in subjects]

def aggiungi_subject(materia):
    materia = materia.upper()
    materia = materia.strip()
    try:
        db = get_db()
        db.execute(
            "INSERT INTO subjects (nome_materia) VALUES (?)",
            (materia,)
        )
        db.commit()
        ris = True
    except:
        #TODO
        db.rollback()
        ris = False
    
    return materia,ris


def get_all_notes():
    db = get_db()
    query = """SELECT * FROM notes
                JOIN students ON notes.student_id = students.id
                ORDER BY notes.data_upload ASC;"""
    notes = db.execute(query,).fetchall()
    return [dict(note) for note in notes]

def get_notes_by_subject(id):
    db = get_db()
    query = """SELECT * FROM notes
                JOIN subjects ON notes.subject_id = subjects.id 
                JOIN students ON notes.student_id = students.id WHERE subject_id = ?;"""
    notes = db.execute(query, (id,)).fetchall()
    return [dict(note) for note in notes]

def get_notes_by_user(id):
    db = get_db()
    query = """SELECT * FROM notes
                JOIN subjects ON notes.subject_id = subjects.id
                JOIN students ON notes.student_id = students.id 
                WHERE student_id = ?
                ORDER BY notes.subject_id;"""
    notes = db.execute(query, (id,)).fetchall()
    return [dict(note) for note in notes]

def user_by_id(id):
    db = get_db()
    query = """SELECT * FROM students WHERE id = ?"""
    dati = db.execute(query, (id,)).fetchone()
    return dati

def aggiorna(id,nuovo_valore):
    db = get_db()
    query = """
        UPDATE tabella
        SET dato1 = ?
        WHERE id = ?
        """
    
    db.execute(query, (nuovo_valore, id))
    db.commit()

def filtra(title,author,data_from,data_to,subject_id):

    query = """
        SELECT 
            notes.id,
            notes.student_id,
            notes.title,
            notes.text_data,
            notes.data_upload,
            students.username,
            subjects.nome_materia
        FROM notes
        JOIN students ON notes.student_id = students.id
        JOIN subjects ON notes.subject_id = subjects.id
        """
    conditions = []
    values = []

    if title:
        conditions.append("notes.title LIKE ?")
        values.append(f"%{title}%")

    if author:
        conditions.append("students.username LIKE ?")
        values.append(f"%{author}%")

    if data_from:
        conditions.append("notes.data_upload >= ?")
        values.append(data_from)

    if data_to:
        conditions.append("notes.data_upload <= ?")
        values.append(data_to)

    if not subject_id == "":
        conditions.append("notes.subject_id = ?")
        values.append(subject_id)

    if conditions:
        query += " WHERE " + " AND ".join(conditions)
    
    db = get_db() 

    results = db.execute(query, values).fetchall()
    return results

import re
import markdown

def converti_e_prendi_text_data(id,convert):
    db = get_db()
    if convert:
        query = """SELECT * FROM notes JOIN students ON notes.student_id = students.id WHERE notes.id = ?;"""
    elif not convert:
        query = """SELECT * FROM notes WHERE notes.id = ?;"""
    note_query = db.execute(query, (id,)).fetchone()
    
    note = dict(note_query)

    #per evitare di convertire in ogni caso
    if convert:
        pagina = note["text_data"]
        pagina_html = markdown.markdown(pagina, extensions=['fenced_code', 'tables'])

        pagina_html = re.sub(
            r'<pre><code class="language-mermaid">(.*?)</code></pre>', 
            r'<div class="mermaid">\1</div>', 
            pagina_html, 
            flags=re.DOTALL
        )

        note["text_data"] = pagina_html
    return note

def crea_account(username, email, password):
    db = get_db()

    password_cifrato = generate_password_hash(password)

    print(f"USERNAME{username}, EMAIL{email}, PASSWORD{password_cifrato}")

    db.execute(
        "INSERT INTO students (username, email, password_hash) VALUES (?,?,?)",
        (username, email, password_cifrato)
    )
    db.commit()

def controlla_accesso(username,password):
    db = get_db()
    query = """
        SELECT id, username, password_hash
        FROM students
        WHERE username = ?
        """
    utente = db.execute(query,(username,)).fetchone()
    return (utente)


def crea_note(text_data, title, data_upload, student_id, subject_id):
    db = get_db()

    cursor = db.execute(
        """INSERT INTO notes 
        (text_data, title, data_upload, student_id, subject_id) 
        VALUES (?,?,?,?,?)""",
        (text_data, title, data_upload, student_id, subject_id)
    )

    db.commit()

    note_id = cursor.lastrowid
    return note_id

    