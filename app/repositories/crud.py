from app.db import get_db
import markdown
def crea(dato1:str):
    db = get_db()
    db.execute(
        """INSERT INTO tabella (dato1) VALUES (?)""",(dato1,)
    )
    db.commit()

def cancella(id:int):
    db = get_db()
    db.execute(
        """DELETE FROM tabella WHERE id = ?""",(id,)
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

def get_notes_by_subject(id):
    db = get_db()
    query = """SELECT * FROM notes
                JOIN subjects ON notes.subject_id = subjects.id 
                JOIN students ON notes.student_id = students.id WHERE subject_id = ?;"""
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


def converti_e_prendi_text_data(id):
    db = get_db()
    query = """SELECT * FROM notes
                WHERE notes.id = ?;"""
    note_query = db.execute(query, (id,)).fetchone()
    note = dict(note_query)
    pagina = note["title"]
    pagina_html = markdown.markdown(pagina, extensions=['fenced_code', 'tables'])
    note["text_data"] = pagina_html
    return note

from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash

def crea_account(username, email, password):
    db = get_db()

    password_cifrato = generate_password_hash(password)

    print(f"USERNAME{username}, EMAIL{email}, PASSWORD{password_cifrato}")

    db.execute(
        "INSERT INTO students (username, email, password_hash) VALUES (?,?,?)",
        (username, email, password_cifrato)
    )
    db.commit()


def controlla_accesso(username,password_hashed):
    #STEP 1 controlla se l'account esiste
    #STEP 2 controlla password guardando se l'account con quel id o nome ha quella password
    pass