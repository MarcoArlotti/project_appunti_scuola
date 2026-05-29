import os
from flask import Flask


def create_app():
    app = Flask(__name__, instance_relative_config=True)

    # 1. Recuperiamo l'URL di Render o usiamo SQLite come fallback locale
    db_url = os.environ.get("DATABASE_URL")

    if db_url:
        # Correzione del prefisso richiesto da SQLAlchemy per Render/PostgreSQL
        if db_url.startswith("postgres://"):
            db_url = db_url.replace("postgres://", "postgresql://", 1)
    else:
        # Se non c'è DATABASE_URL (es. in locale), usa il file SQLite
        db_url = "sqlite:///" + os.path.join(app.instance_path, "test.sqlite")

    # 2. Configurazione di base
    app.config.from_mapping(
        SECRET_KEY=os.environ.get("SECRET_KEY", "dev"),
        SQLALCHEMY_DATABASE_URI=db_url,
        SQLALCHEMY_TRACK_MODIFICATIONS=False,
    )

    # 3. Inizializzazione dei componenti
    from . import db

    db.init_app(app)

    # --- CREAZIONE DELLE TABELLE AUTOMATICA ---
    # Questo sostituisce la "Fase 2" manuale nel contesto della factory
    with app.app_context():
        # Importiamo i modelli qui per assicurarci che Flask li veda prima di creare le tabelle
        from . import models

        db.db.create_all()
    # ------------------------------------------

    # 4. Registrazione Blueprints
    from . import main

    app.register_blueprint(main.bp)

    return app