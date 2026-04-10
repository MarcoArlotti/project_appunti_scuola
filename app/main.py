from flask import Blueprint, flash, redirect, render_template, request, url_for
from app.repositories.crud import *
bp = Blueprint("main",__name__)

@bp.route("/")
def index():
    subjects = get_subjects()
    return render_template("home.html", subjects=subjects)

@bp.route("/subjects/<int:id>")
def notes_by_subject(id):
    notes = get_notes_by_subject(id)
    return render_template("notes.html", notes=notes)

@bp.route("/utente/<int:id>")
def user(id):
    user = user_by_id(id)
    print(user)
    return render_template("utente.html", user=user)