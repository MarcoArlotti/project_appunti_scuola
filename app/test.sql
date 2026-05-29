-- database: :memory:

-- tabella appunti
CREATE TABLE notes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    text_data TEXT,
    title TEXT,
    data_upload DATETIME,
    student_id INT,
    subject_id INT,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (subject_id) REFERENCES subjects(id)
);

-- Creazione tabella utenti
-- cambiare come funziona la password
CREATE TABLE students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(30) NOT NULL UNIQUE,
    password_hash VARCHAR(162) NOT NULL,
    data_iscrizione DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabella materie
CREATE TABLE subjects (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_materia VARCHAR(30) NOT NULL UNIQUE
);

INSERT INTO subjects (nome_materia)
VALUES
    ("GPOI"),
    ("INGLESE"),
    ("SISTEMI E RETI"),
    ("INFORMATICA");

