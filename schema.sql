-- Creazione tabella utenti
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(200) NOT NULL,
    data_iscrizione DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabella materie
CREATE TABLE subjects (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_materia VARCHAR(100) NOT NULL UNIQUE
);

-- Sistema rating
CREATE TABLE ratings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    voto INTEGER CHECK(voto >= 1 AND voto <= 5),
    user_id INTEGER,
    note_id INTEGER,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (note_id) REFERENCES notes(id),

    UNIQUE(user_id, note_id) -- un utente vota una sola volta
);