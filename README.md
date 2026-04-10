# appunti per scuola
Il progetto project_appunti_scuola nasce dal risolvere il problema di avere unn problema di sincronizzazzione tra i miei vari dispositivi.

### Il problema
Quando mi ritrovo a scuola, prendo degli appunti via file .md e li carico nel mio repository in modo tale che quando torno a casa,

io possa modificarli velocemenete usando il mio PC fisso.

Creando una web app che si salvi automaticamente i vari appunti anche di altre persone, si evita di dover andare a prendere manualmene dalla piattaforma Discord,

dove noi compagni ci scambiamo informazioni e appunti,

---

## struttura del progetto
### HOME PAGE
Di funzioni base si vuole creare una web app che contenga una home page con una lista di materie.


### PAGINA DI UNA SPECIFICA MATERIA
Una volta premuto sulla materia, si spostera' l'utente in un altra pagina che faccia vedere gli appunti di quella materia ordinati per la data di pubblicazione (_sperimentale_: tramite il numero della unita' del libro).

Nella pagina degli appunti ci sara' mostrato solo il titolo e chi lo ha postato e la data (_sperimentale_: gli appunti hanno un rating da 1 a 5, quindi mostrare la media e quante recensioni si hanno fatto).

### PAGINA DI UN APPUNTO
Una volta che si ha premuto sull'appunto, verra' mostrato il contenuto (_sperimentale_: convertire gli .md in html automaticamente dopo la pubblicazione).
---
## OBBIETTIVI GENERALI
- Permettere a un utente di registrarsi e autenticarsi,
- Consentire la creazione, modifica, eliminazione e visualizzazione degli appunti,
- Consentire la ricerca e il filtro delle materie (in caso anche nella pagina di tutti gli appunti),
- Fornire una pagina di profilo dove l'utente vede i propri appunti,
- Permettere a chiunque di scaricare gli appunti o stamparli.

---

## Percorsi del sito
`/` la home,

`/subjects` pagina delle materie,

`/subjects/<int:id>` pagina di tutti gli appunti di una materia specifica,

`/note/<int:id>` pagina di un appunto specifico,

`/students` pagina con tutti gli user,

`/students/<int:id>` pagina di uno studente specifico.

---

## schema ER delle relazioni

```mermaid
erDiagram
      student {
        int id PK
        string nome
        string email
        string password_hash
        datetime data_creazione
      }

      note {
         int id PK
         string value
         datetime data_upload
         int student_id FK
         int subject_id FK
      }

      subject {
         int id PK
         string name
      }

      rating {
         int id PK
         int value
         datetime data_upload
         int student_id FK
         int subject_id FK
      }
      
      student ||--o{ notes : crea
      note ||--|| subject : catalogato_tramite
      note ||--o{ rating : ha
```

## Glossario dei termini
`student`: sono gli studenti che hanno fatto l'accesso,

`note`: e' le informazioni sul file che e' stato creato dallo `student` e contiene anche il file dentro a value,

`subject`: e' la materia e funge da filtro nella ricerca e ordinamento degli appunti,

`rating`: e' una valutazione da 1 a 5 di quanto e' affidabile e robusto un appunto.

---

## Schedule del lavoro sul progetto
```mermaid
gantt
    dateFormat  MM-DD
    title schedule del lavoro sul progetto

    section BACKEND + HTML
    home page :a1, 04-22, 2d
    pagina delle materie :a2, after a1, 2d
    pagina di un appunto specifico :b1, after a2, 2d
    pagina di un utente specifico :c1, after b1, 2d

    section gestione DB
    CRUD :b2, after c1, 3d
    Filtri/ricerca :b3, after b2, 4d
    autenticazione + account admin :b4, after b3, 7d
    creazione di un appunto :b5, after b4, 7d

    section POLISHING
    del CSS :c2, after b5, 7d
    Test e controlli di errori :c3, after c2, 3d
    Consegna su GitHub :c4, after c3, 1d
```
