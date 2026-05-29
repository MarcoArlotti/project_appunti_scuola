from datetime import datetime
from .db import db

# ==========================================
# 1. TABELLA MATERIE (Subjects)
# ==========================================
class Subject(db.Model):
    __tablename__ = "subjects"

    id = db.Column(db.Integer, primary_key=True)
    nome_materia = db.Column(db.String(30), unique=True, nullable=False)

    # Relazione (opzionale, ma utile per fare ad esempio: subject.notes)
    notes = db.relationship('Note', backref='subject', lazy=True)


# ==========================================
# 2. TABELLA STUDENTI (Students)
# ==========================================
class Student(db.Model):
    __tablename__ = "students"

    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(100), unique=True, nullable=False)
    email = db.Column(db.String(30), unique=True, nullable=False)
    password_hash = db.Column(db.String(162), nullable=False)
    
    # In SQLAlchemy, per il TIMESTAMP DEFAULT passiamo la funzione datetime.utcnow senza parentesi
    data_iscrizione = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)

    # Relazione (opzionale, permette di fare: student.notes)
    notes = db.relationship('Note', backref='student', lazy=True)


# ==========================================
# 3. TABELLA APPUNTI (Notes)
# ==========================================
class Note(db.Model):
    __tablename__ = "notes"

    id = db.Column(db.Integer, primary_key=True)
    text_data = db.Column(db.Text, nullable=True)
    title = db.Column(db.String(255), nullable=True)
    data_upload = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)

    # Chiavi Esterne (Foreign Keys) con i comportamenti di ON DELETE
    student_id = db.Column(
        db.Integer, 
        db.ForeignKey('students.id', ondelete='CASCADE'), 
        nullable=True
    )
    subject_id = db.Column(
        db.Integer, 
        db.ForeignKey('subjects.id', ondelete='SET NULL'), 
        nullable=True
    )