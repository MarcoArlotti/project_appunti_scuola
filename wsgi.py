import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

# Render fornisce l'URL del database. Python si aspetta 'postgresql://' 
# ma a volte Render usa 'postgres://'. Questo trick corregge l'URL automaticamente.
db_url = os.environ.get('postgresql://test_wcsb_user:7eAV929bNJX50dROa7TlXU7PN6RChFIP@dpg-d8cj5oreo5us73ev43cg-a/test_wcsb')
if db_url and db_url.startswith("postgres://"):
    db_url = db_url.replace("postgres://", "postgresql://", 1)

app.config['SQLALCHEMY_DATABASE_URI'] = db_url
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# Da qui in poi definisci i tuoi modelli o gestisci l'app...