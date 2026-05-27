from flask import Blueprint, flash, redirect, render_template, request, url_for, session
from app.repositories.crud import *
from datetime import datetime
bp = Blueprint("main",__name__)

@bp.route("/", methods=["GET","POST"])
def index():
    if 'username' in session:
        username = session["username"]
    else:
        username = None

    subjects = get_subjects()

    if request.method == "GET":
        notes = get_all_notes()

    if request.method == "POST":
        title = request.form.get('title')
        author = request.form.get('author')
        data_from = request.form.get('data_from')
        data_to = request.form.get('data_to')
        subject_id = request.form.get('subject_id')
        
        notes = filtra(title,author,data_from,data_to,subject_id)
    return render_template("home.html", subjects=subjects,username=username, notes=notes)

@bp.route("/about")
def flexare():
    return render_template("flexare.html")
@bp.route("/students")
def all_students():
    students = get_all_students()
    return render_template("students.html", students=students)

@bp.route("/students/<int:id>")
def specific_student(id):
    student = user_by_id(id)
    files_created = get_notes_by_user(id)
    return render_template("student_page.html", student=student, files_created=files_created)

@bp.route("/subjects/<int:id>")
def notes_by_subject(id):
    notes = get_notes_by_subject(id)
    return render_template("notes.html", notes=notes)

@bp.route("/notes/<int:id>")
def specific_note(id):
    pagina_html = converti_e_prendi_text_data(id,convert=True)
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


@bp.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form.get('username')
        password = request.form.get('password')
    
        utente = controlla_accesso(username, password)
        if utente:
            if check_password_hash(utente[2], password):
                session['id'] = utente["id"]
                session['username'] = utente["username"]
                return redirect(url_for("main.index"))
            else:
                flash("Password non valida")
        else:
            flash("Utente non esiste")
    
    return render_template("login.html")

@bp.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("main.index"))

@bp.route("/errore") #momentaneo
def errore():
    return render_template("errore.html")

@bp.route("/create_notes", methods=["GET", "POST"])
def c_note():
    if request.method == "GET":
        if session:
            subjects = get_subjects()
            return render_template("c_note.html", subjects=subjects)
        else:
            return redirect(url_for("main.login"))
        
    if request.method == "POST":
        
        materia = request.form.get('aggiugi_subject')
        if materia:
            materia,ris = aggiungi_subject(materia)
            return redirect(url_for("main.c_note"))


        title = request.form.get('title')
        file_grezzo = request.files.get('file')
        if file_grezzo:
            text_data = file_grezzo.read().decode('utf-8')
        else:
            return redirect(url_for("main.errore"))

        data_upload = datetime.now()
        student_id = session["id"]
        subject_id = request.form.get('subject')
        
        id_post_creato = crea_note(text_data, title, data_upload, student_id, subject_id) #tails
        return redirect(url_for("main.specific_note", id=id_post_creato))
    
@bp.route("/cancella")
def delete():
    if session:
        id = session["id"]
        notes = get_notes_by_user(id)
        return render_template("cancella_post.html", notes=notes)
    else:
        return redirect(url_for("main.login"))


@bp.route("/cancella/<int:id>")
def delete_post(id):
    if session:
        notes_scelta = converti_e_prendi_text_data(id,convert=False)
        cancella_post(notes_scelta,session)

        return redirect(url_for("main.delete"))
    else:
        return redirect(url_for("main.login"))