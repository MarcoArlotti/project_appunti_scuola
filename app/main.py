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

@bp.route("/subjects/<int:id>")
def notes_by_subject(id):
    notes = get_notes_by_subject(id)
    return render_template("notes.html", notes=notes)
