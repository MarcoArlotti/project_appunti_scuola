from flask import Flask, render_template, redirect, url_for, request, flash
from models import db, User, Note, Subject
from flask_login import LoginManager, login_user, login_required, logout_user, current_user
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.config['SECRET_KEY'] = 'supersecretkey'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'

db.init_app(app)

login_manager = LoginManager()
login_manager.login_view = 'login'
login_manager.init_app(app)

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

# Home
@app.route('/')
def index():
    notes = Note.query.all()
    return render_template('index.html', notes=notes)

# Register
@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        password = generate_password_hash(request.form['password'])

        user = User(username=username, email=email, password=password)
        db.session.add(user)
        db.session.commit()

        flash('Registrazione completata!')
        return redirect(url_for('login'))

    return render_template('register.html')

# Login
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        user = User.query.filter_by(email=request.form['email']).first()

        if user and check_password_hash(user.password, request.form['password']):
            login_user(user)
            return redirect(url_for('dashboard'))

        flash('Credenziali non valide')

    return render_template('login.html')

# Dashboard
@app.route('/dashboard')
@login_required
def dashboard():
    notes = Note.query.filter_by(user_id=current_user.id).all()
    return render_template('dashboard.html', notes=notes)

# Logout
@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('index'))

# Create note
@app.route('/create', methods=['GET', 'POST'])
@login_required
def create_note():
    subjects = Subject.query.all()

    if request.method == 'POST':
        title = request.form['title']
        content = request.form['content']
        subject_id = request.form['subject']

        note = Note(
            title=title,
            content=content,
            subject_id=subject_id,
            user_id=current_user.id
        )

        db.session.add(note)
        db.session.commit()

        return redirect(url_for('dashboard'))

    return render_template('create_note.html', subjects=subjects)

if __name__ == '__main__':
    with app.app_context():
        db.create_all()

        # crea materie base se non esistono
        if not Subject.query.first():
            db.session.add_all([
                Subject(name="Informatica"),
                Subject(name="Matematica"),
                Subject(name="Storia")
            ])
            db.session.commit()

    app.run(debug=True)