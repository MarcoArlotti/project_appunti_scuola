import markdown

from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash

from app.db import db
from app.models import *

#def cancella_post(notes,session):
#    if session and session["id"] == notes["student_id"]:
#        id = notes["id"]
#        db = get_db()
#        db.execute(
#            """DELETE FROM notes WHERE notes.id = ?""",(id,)
#        )
#        db.commit()
# ==========================================
# DELETE NOTE
# ==========================================

def cancella_post(note, session):
    if session and session["id"] == note.student_id:
        db.session.delete(note)
        db.session.commit()

#def get_all_students():
#    db = get_db()
#    query = """SELECT * FROM students"""
#    dati = db.execute(query).fetchall()
#    return [dict(dato) for dato in dati]

# ==========================================
# STUDENTS
# ==========================================

def get_all_students():
    students = Student.query.all()

    return [
        {
            "id": student.id,
            "username": student.username,
            "email": student.email,
            "password_hash": student.password_hash,
            "data_iscrizione": student.data_iscrizione
        }
        for student in students
    ]


#def get_subjects():
#    db = get_db()
#    query = "SELECT * FROM subjects"
#    subjects = db.execute(query).fetchall()
#    return [dict(subject) for subject in subjects]

# ==========================================
# SUBJECTS
# ==========================================

def get_subjects():
    subjects = Subject.query.all()

    return [
        {
            "id": subject.id,
            "nome_materia": subject.nome_materia
        }
        for subject in subjects
    ]

#def aggiungi_subject(materia):
#    materia = materia.upper()
#    materia = materia.strip()
#    try:
#        db = get_db()
#        db.execute(
#            "INSERT INTO subjects (nome_materia) VALUES (?)",
#            (materia,)
#        )
#        db.commit()
#        ris = True
#    except:
#        db.rollback()
#        ris = False
#    
#    return materia,ris
#

def aggiungi_subject(materia):
    materia = materia.upper().strip()

    try:
        subject = Subject(nome_materia=materia)

        db.session.add(subject)
        db.session.commit()

        return materia, True

    except Exception as e:
        db.session.rollback()
        print(e)

        return materia, False


#def get_all_notes():
#    db = get_db()
#    query = """SELECT * FROM notes
#                JOIN students ON notes.student_id = students.id
#                ORDER BY notes.data_upload ASC;"""
#    notes = db.execute(query,).fetchall()
#    return [dict(note) for note in notes]
# ==========================================
# NOTES
# ==========================================

def get_all_notes():
    notes = Note.query.order_by(Note.data_upload.asc()).all()

    return [
        {
            "id": note.id,
            "student_id": note.student_id,
            "subject_id": note.subject_id,
            "title": note.title,
            "text_data": note.text_data,
            "data_upload": note.data_upload,
            "username": note.student.username if note.student else None,
            "nome_materia": note.subject.nome_materia if note.subject else None
        }
        for note in notes
    ]

#def get_notes_by_subject(id):
#    db = get_db()
#    query = """SELECT * FROM notes
#                JOIN subjects ON notes.subject_id = subjects.id 
#                JOIN students ON notes.student_id = students.id WHERE subject_id = ?;"""
#    notes = db.execute(query, (id,)).fetchall()
#    return [dict(note) for note in notes]

def get_notes_by_subject(id):
    notes = Note.query.filter_by(subject_id=id).all()

    return [
        {
            "id": note.id,
            "student_id": note.student_id,
            "subject_id": note.subject_id,
            "title": note.title,
            "text_data": note.text_data,
            "data_upload": note.data_upload,
            "username": note.student.username if note.student else None,
            "nome_materia": note.subject.nome_materia if note.subject else None
        }
        for note in notes
    ]

#def get_notes_by_user(id):
#    db = get_db()
#    query = """SELECT * FROM notes
#                JOIN subjects ON notes.subject_id = subjects.id
#                JOIN students ON notes.student_id = students.id 
#                WHERE student_id = ?
#                ORDER BY notes.subject_id;"""
#    notes = db.execute(query, (id,)).fetchall()
#    return [dict(note) for note in notes]

def get_notes_by_user(id):
    notes = Note.query.filter_by(student_id=id).order_by(Note.subject_id).all()

    return [
        {
            "id": note.id,
            "student_id": note.student_id,
            "subject_id": note.subject_id,
            "title": note.title,
            "text_data": note.text_data,
            "data_upload": note.data_upload,
            "username": note.student.username if note.student else None,
            "nome_materia": note.subject.nome_materia if note.subject else None
        }
        for note in notes
    ]


#def user_by_id(id):
#    db = get_db()
#    query = """SELECT * FROM students WHERE id = ?"""
#    dati = db.execute(query, (id,)).fetchone()
#    return dati

def user_by_id(id):
    return Student.query.get(id)

#def filtra(title,author,data_from,data_to,subject_id):
#
#    query = """
#        SELECT 
#            notes.id,
#            notes.student_id,
#            notes.title,
#            notes.text_data,
#            notes.data_upload,
#            students.username,
#            subjects.nome_materia
#        FROM notes
#        JOIN students ON notes.student_id = students.id
#        JOIN subjects ON notes.subject_id = subjects.id
#        """
#    conditions = []
#    values = []
#
#    if title:
#        conditions.append("notes.title LIKE ?")
#        values.append(f"%{title}%")
#
#    if author:
#        conditions.append("students.username LIKE ?")
#        values.append(f"%{author}%")
#
#    if data_from:
#        conditions.append("notes.data_upload >= ?")
#        values.append(data_from)
#
#    if data_to:
#        conditions.append("notes.data_upload <= ?")
#        values.append(data_to)
#
#    if not subject_id == "":
#        conditions.append("notes.subject_id = ?")
#        values.append(subject_id)
#
#    if conditions:
#        query += " WHERE " + " AND ".join(conditions)
#    
#    db = get_db() 
#
#    results = db.execute(query, values).fetchall()
#    return results


# ==========================================
# FILTER NOTES
# ==========================================

def filtra(title, author, data_from, data_to, subject_id):

    query = Note.query.join(Student).join(Subject)

    if title:
        query = query.filter(Note.title.ilike(f"%{title}%"))

    if author:
        query = query.filter(Student.username.ilike(f"%{author}%"))

    if data_from:
        query = query.filter(Note.data_upload >= data_from)

    if data_to:
        query = query.filter(Note.data_upload <= data_to)

    if subject_id != "":
        query = query.filter(Note.subject_id == subject_id)

    results = query.all()

    return [
        {
            "id": note.id,
            "student_id": note.student_id,
            "subject_id": note.subject_id,
            "title": note.title,
            "text_data": note.text_data,
            "data_upload": note.data_upload,
            "username": note.student.username if note.student else None,
            "nome_materia": note.subject.nome_materia if note.subject else None
        }
        for note in results
    ]


import re
import markdown

#def converti_e_prendi_text_data(id,convert):
#    db = get_db()
#    if convert:
#        query = """SELECT * FROM notes JOIN students ON notes.student_id = students.id WHERE notes.id = ?;"""
#    elif not convert:
#        query = """SELECT * FROM notes WHERE notes.id = ?;"""
#    note_query = db.execute(query, (id,)).fetchone()
#    
#    note = dict(note_query)
#
#    #per evitare di convertire in ogni caso
#    if convert:
#        pagina = note["text_data"]
#        pagina_html = markdown.markdown(pagina, extensions=['fenced_code', 'tables'])
#
#        pagina_html = re.sub(
#            r'<pre><code class="language-mermaid">(.*?)</code></pre>', 
#            r'<div class="mermaid">\1</div>', 
#            pagina_html, 
#            flags=re.DOTALL
#        )
#
#        note["text_data"] = pagina_html
#    return note

# ==========================================
# MARKDOWN
# ==========================================

def converti_e_prendi_text_data(id, convert):

    note = Note.query.get(id)

    if not note:
        return None

    note_dict = {
        "id": note.id,
        "student_id": note.student_id,
        "subject_id": note.subject_id,
        "title": note.title,
        "text_data": note.text_data,
        "data_upload": note.data_upload,
        "username": note.student.username if note.student else None
    }

    if convert:

        pagina = note.text_data

        pagina_html = markdown.markdown(
            pagina,
            extensions=['fenced_code', 'tables']
        )

        pagina_html = re.sub(
            r'<pre><code class="language-mermaid">(.*?)</code></pre>',
            r'<div class="mermaid">\1</div>',
            pagina_html,
            flags=re.DOTALL
        )

        note_dict["text_data"] = pagina_html

    return note_dict


#def crea_account(username, email, password):
#    db = get_db()
#
#    password_cifrato = generate_password_hash(password)
#
#    print(f"USERNAME{username}, EMAIL{email}, PASSWORD{password_cifrato}")
#
#    db.execute(
#        "INSERT INTO students (username, email, password_hash) VALUES (?,?,?)",
#        (username, email, password_cifrato)
#    )
#    db.commit()

def crea_account(username, email, password):
    password_cifrato = generate_password_hash(password)

    student = Student(
        username=username,
        email=email,
        password_hash=password_cifrato
    )

    db.session.add(student)
    db.session.commit()

#def controlla_accesso(username,password):
#    db = get_db()
#    query = """
#        SELECT id, username, password_hash
#        FROM students
#        WHERE username = ?
#        """
#    utente = db.execute(query,(username,)).fetchone()
#    return (utente)

def controlla_accesso(username, password):
    utente = Student.query.filter_by(username=username).first()

    if utente and check_password_hash(utente.password_hash, password):
        return utente

    return None

#def crea_note(text_data, title, data_upload, student_id, subject_id):
#    db = get_db()
#
#    cursor = db.execute(
#        """INSERT INTO notes 
#        (text_data, title, data_upload, student_id, subject_id) 
#        VALUES (?,?,?,?,?)""",
#        (text_data, title, data_upload, student_id, subject_id)
#    )
#
#    db.commit()
#
#    note_id = cursor.lastrowid
#    return note_id

def crea_note(text_data, title, data_upload, student_id, subject_id):

    note = Note(
        text_data=text_data,
        title=title,
        data_upload=data_upload,
        student_id=student_id,
        subject_id=subject_id
    )

    db.session.add(note)
    db.session.commit()

    return note.id