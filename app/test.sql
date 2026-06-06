-- database: :memory:
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS subjects;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS notes;

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
(
'# Intestazione H1 (Titolo Principale)
## Intestazione H2 (Sottotitolo)
### Intestazione H3
#### Intestazione H4
##### Intestazione H5
###### Intestazione H6

---

## 1. Formattazione del Testo

Questo è un normale paragrafo di testo per testare il font, l''interlinea e la leggibilità generale.

* **Testo in grassetto** (con doppi asterischi)
* __Testo in grassetto__ (con doppi trattini bassi)
* *Testo in corsivo* (con singolo asterisco)
* _Testo in corsivo_ (con singolo trattino basso)
* ***Testo in grassetto e corsivo***
* ~~Testo sbarrato~~
* Testo con evidenziazione ==gialla==

---

## 2. Liste

### Lista Non Ordinata
* Primo elemento
* Secondo elemento
  * Sotto-elemento indentato con due o quattro spazi
  * Un altro sotto-elemento
* Terzo elemento

### Lista Ordinata
1. Primo elemento numerato
2. Secondo elemento numerato
   1. Sotto-elemento numerato
   2. Un altro sotto-elemento
3. Terzo elemento numerato

### Lista di Controllo (Task List)
- [x] Compito completato
- [ ] Compito da fare
- [ ] Un altro compito in sospeso

---

## 3. Blocchi di Codice e Sintassi

### Codice Inline
Per installare la libreria, usa il comando `npm install markdown-test`.

### Blocco di Codice (Senza evidenziazione)','tipi di wifi', 2026-04-12, 1, 1),
('# test testo grande','gasa3', 2026-04-13, 2, 1);