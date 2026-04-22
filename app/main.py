from flask import Blueprint, flash, redirect, render_template, request, url_for
from app.repositories.crud import *
bp = Blueprint("main",__name__)

@bp.route("/")
def index():
    subjects = get_subjects()
    return render_template("home.html", subjects=subjects)

@bp.route("/students")
def all_students():
    students = get_all_students()
    return render_template("students.html", students=students)

@bp.route("/students/<int:id>")
def specific_student(id):
    student = user_by_id(id)
    return render_template("student_page.html", student=student)

@bp.route("/subjects/<int:id>")
def notes_by_subject(id):
    notes = get_notes_by_subject(id)
    return render_template("notes.html", notes=notes)

@bp.route("/notes/<int:id>")
def specific_note(id):
    pagina_html = converti_e_prendi_text_data(id)
    return render_template("specific_note.html", pagina_html=pagina_html)