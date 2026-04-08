# appunti per scuola
Questo porgetto mira a creare una web app che contiene delle pagine fatte html da utenti,
che contengono appunti per ogni materia.
con un accesso gli utenti pubblicano le pagine.
usare un database per gli utenti.
---

## 1. Analisi dei Requisiti Funzionali

Questi descrivono le azioni che gli utenti possono compiere sulla piattaforma.

### Gestione Utenti
* **Registrazione e Login:** Gli utenti devono poter creare un account (Username, Email, Password).
* **Profilo Utente:** Ogni utente ha una bacheca dove vede i propri appunti caricati.
* **Permessi:** Solo gli utenti loggati possono "pubblicare", mentre tutti (anche gli ospiti) potrebbero "leggere" (da decidere in base al design).

### Gestione Appunti (Core)
**Creazione/Upload:** L'utente carica un file HTML o scrive il contenuto in un editor che genera HTML.
**Categorizzazione:** Ogni appunto deve essere associato a una **Materia** (es. Informatica, Storia, Matematica) e possibilmente a un **Anno di corso**.
**Ricerca e Filtri:** Gli utenti devono poter cercare appunti per parola chiave o filtrarli per materia.
**Visualizzazione:** L'app deve "renderizzare" (mostrare) il codice HTML caricato dall'utente in modo sicuro.

---

## 2. Architettura dei Dati (Database)

Per gestire gli utenti e i riferimenti agli appunti, serve un database relazionale (come MySQL o SQLite).



### Tabelle Principali:
1.  **Users:** `id`, `username`, `email`, `password_hash`, `data_iscrizione`.
2.  **Subjects:** `id`, `nome_materia` (es. "Sistemi e Reti").
---

## 3. Requisiti Tecnici e Stack Consigliato

Per uno studente, lo stack più bilanciato è solitamente il **LAMP/WAMP** (PHP) o **Node.js**:

* **Frontend:** HTML5, CSS3 (magari con Bootstrap per fare presto) e JavaScript.
* **Backend:** * *Opzione A (Classica):* **PHP** per gestire le sessioni e le query al database.
    * *Opzione B (Moderna):* **Node.js** con Express.
* **Database:** **MySQL** o **PostgreSQL**.
* **Sicurezza (Fondamentale):** * **Password Hashing:** Mai salvare password in chiaro (usa `password_hash()` in PHP o `bcrypt` in Node).
    * **Sanitizzazione HTML:** Poiché gli utenti caricano HTML, devi stare attento agli attacchi **XSS** (Cross-Site Scripting). Devi "pulire" l'HTML per impedire che qualcuno carichi script malevoli.

---

## 4. Possibile sistema di rating

Se vuoi rendere il progetto più professionale, potresti aggiungere:
- **Sistema di Valutazione:** Gli utenti possono dare da 1 a 5 stelle agli appunti.
---

### Suggerimento per lo sviluppo:
Inizia creando un database semplice e una pagina di login. Una volta che l'utente è autenticato, lavora sul modulo di "Upload" dell'appunto. Vuoi procedere con la definizione della struttura delle tabelle del database (SQL) o preferisci vedere una bozza dell'interfaccia?
