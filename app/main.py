from flask import Blueprint, flash, redirect, render_template, request, url_for, session
from app.repositories.crud import *

bp = Blueprint("main",__name__)

@bp.route("/")
def index():
    if 'id' in session:
        flash(f"BENVENUTO {session["username"]}")
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


@bp.route("/sign",methods=["GET", "POST"])
def sign():
    if request.method == "POST":
        username = request.form.get('username')
        email = request.form.get('email')
        password_hash = request.form.get('password_hash')

        crea_account(username,email,password_hash)
        return redirect(url_for("main.login"))
    return render_template("sign.html")


@bp.route("/login")
def login():
    #FIXARE
    username = request.form.get('username')
    password = request.form.get('password_hash')

    utente = controlla_accesso(username,password)
    if utente:
        if check_password_hash(utente["password_hashed"], utente["password"]):
            session['id'] = utente["id"]
            session['username'] = utente["username"]
        else:
            flash("password non valida")
    else:
        flash("utente non esiste")

    return render_template("login.html")