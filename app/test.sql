-- 1. Tabella materie (creata per prima così possiamo usarla come Foreign Key)
CREATE TABLE subjects (
    id SERIAL PRIMARY KEY,
    nome_materia VARCHAR(30) NOT NULL UNIQUE
);

-- 2. Tabella studenti (creata per seconda così possiamo usarla come Foreign Key)
-- Nota sulla password: il campo 'password_hash' a 162 caratteri va benissimo 
-- per algoritmi sicuri come Argon2id o bcrypt.
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(30) NOT NULL UNIQUE,
    password_hash VARCHAR(162) NOT NULL,
    data_iscrizione TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Tabella appunti (creata per ultima perché dipende dalle altre due)
CREATE TABLE notes (
    id SERIAL PRIMARY KEY,
    text_data TEXT,
    title VARCHAR(255), -- In Postgres è meglio specificare un tipo per i titoli
    data_upload TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Aggiunto il default per comodità
    student_id INT,
    subject_id INT,
    CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    CONSTRAINT fk_subject FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE SET NULL
);

-- 4. Inserimento materie (usando i singoli apici come richiesto dallo standard SQL)
INSERT INTO subjects (nome_materia)
VALUES
    ('GPOI'),
    ('INGLESE'),
    ('SISTEMI E RETI'),
    ('INFORMATICA');