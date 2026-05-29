import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

# 1. Recupera l'URL dalla variabile d'ambiente di Render (senza esporre la password nel codice!)
db_url = os.environ.get('DATABASE_URL')

# Correzione del prefisso per Render/SQLAlchemy
if db_url and db_url.startswith("postgres://"):
    db_url = db_url.replace("postgres://", "postgresql://", 1)

app.config['SQLALCHEMY_DATABASE_URI'] = db_url
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# 2. Inizializza l'estensione del database
db = SQLAlchemy(app)

# ==========================================
# 3. I TUOI MODELLI VANNO QUI (o vanno importati)
# Esempio:
# class User(db.Model):
#     id = db.Column(db.Integer, primary_key=True)
#     username = db.Column(db.String(80), unique=True, nullable=False)
# ==========================================

# 4. Crea le tabelle nel contesto dell'app (SOLO DOPO che db e modelli sono definiti)
with app.app_context():
    db.create_all()  # Crea automaticamente le tabelle su Render se non esistono

@app.route('/')
def home():
    return "Applicazione e Database configurati con successo!"

if __name__ == '__main__':
    app.run(debug=True)