-- database: :memory:
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS subjects;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS notes;

-- tabella appunti
CREATE TABLE notes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    text_data VARCHAR(255),
    title VARCHAR(255),
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

INSERT INTO students (username, email, password_hash)
VALUES 
    ('mario_rossi', 'mario.rossi@example.com', 'hashed_password_1'),
    ('giulia_bianchi', 'giulia.bianchi@example.com', 'hashed_password_2'),
    ('lucas_verde', 'lucas.verde@example.com', 'hashed_password_3'),
    ('anna_gialli', 'anna.gialli@example.com', 'hashed_password_4');

INSERT INTO subjects (nome_materia)
VALUES
    ("GPOI"),
    ("INGLESE"),
    ("SISTEMI E RETI"),
    ("INFORMATICA");

INSERT INTO notes (text_data, title, data_upload, student_id, subject_id)
VALUES 
('Appunti di matematica1','gasa1', 2026-04-10, 1, 1),
('Appunti di matematica2','gasa2', 2026-04-12, 1, 1),
('Appunti di matematica3','gasa3', 2026-04-13, 2, 1);