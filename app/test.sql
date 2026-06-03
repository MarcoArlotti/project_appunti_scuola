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
("""# WPA
Le reti wireless sono ormai il cuore pulsante della nostra connettività quotidiana. Capire come funzionano non è solo affascinante dal punto di vista tecnico, ma è il primo passo fondamentale per proteggere i propri dati.

Ecco un'analisi di come operano e di come il protocollo WPA agisca da "guardiano" del segnale.

---

## 1. Come funzionano le reti Wireless (Wi-Fi)

A differenza delle reti cablate, che trasmettono dati sotto forma di impulsi elettrici o luminosi attraverso i cavi, le reti wireless utilizzano **onde radio**. Il processo segue generalmente questa logica:

* **Conversione dei dati:** Quando invii un'informazione, il tuo dispositivo (PC, smartphone) traduce i dati digitali (0 e 1) in segnali radio.
* **Trasmissione:** Questi segnali vengono emessi tramite un'antenna su frequenze specifiche, solitamente **2.4 GHz** o **5 GHz**.
* **Ricezione e instradamento:** Il router wireless riceve queste onde, le decodifica nuovamente in dati digitali e le invia a internet tramite la connessione fisica (fibra o ADSL).

Il limite intrinseco? Poiché le onde radio si propagano in tutte le direzioni, **chiunque si trovi nel raggio d'azione può "ascoltare" il segnale**. È qui che entra in gioco la sicurezza.

---

## 2. Il ruolo del WPA (Wi-Fi Protected Access)

Senza crittografia, una rete Wi-Fi è come una conversazione urlata in una piazza affollata. Il protocollo **WPA** serve a "chiudere la porta", trasformando i dati leggibili in un codice cifrato che solo il mittente e il destinatario autorizzato possono comprendere.

### Evoluzione del WPA
Esistono tre versioni principali, ognuna più sicura della precedente:

1.  **WPA (2003):** Introdotto per risolvere le gravi falle del vecchio WEP. Utilizzava il protocollo TKIP per cambiare dinamicamente le chiavi di crittografia.
2.  **WPA2 (2004):** Lo standard attuale più diffuso. Utilizza l'algoritmo **AES** (Advanced Encryption Standard), lo stesso livello di sicurezza usato da governi e banche.
3.  **WPA3 (2018):** L'ultima frontiera. Protegge contro gli attacchi a "forza bruta" (tentativi ripetuti di indovinare la password) e rende più sicure le reti pubbliche.

---

## 3. Come rendere sicura la rete con WPA

Per implementare correttamente la sicurezza WPA nella tua rete, non basta "attivarla", ma occorre seguire alcune buone pratiche configurando il router:

### Scegliere la modalità corretta
Nella pagina di configurazione del router (solitamente accessibile via browser all'indirizzo `192.168.1.1`), troverai diverse opzioni. La gerarchia di sicurezza è la seguente:

| Protocollo | Livello di Sicurezza | Consiglio |
| :--- | :--- | :--- |
| **WEP** | Nullo | Da evitare assolutamente (si viola in pochi secondi). |
| **WPA-TKIP** | Basso | Superato, può rallentare la connessione. |
| **WPA2-AES (CCMP)** | **Ottimo** | Lo standard consigliato per compatibilità e forza. |
| **WPA3** | **Massimo** | Da usare se tutti i tuoi dispositivi sono recenti. |

### Configurazione della Password (PSK)
WPA utilizza spesso una "Pre-Shared Key" (PSK). Per renderla efficace:
* **Lunghezza:** Almeno 12-16 caratteri.
* **Complessità:** Mix di maiuscole, minuscole, numeri e simboli.
* **Unicità:** Non usare parole del dizionario o date di nascita.

### Disabilitare il WPS (Wi-Fi Protected Setup)
Il WPS è quel tastino che permette di connettersi senza password. Sebbene comodo, rappresenta un punto debole critico perché il suo PIN a 8 cifre può essere forzato facilmente. **Disabilitarlo è un passo fondamentale per una rete davvero sicura.**

---

### Conclusione
Il Wi-Fi trasmette i nostri segreti nell'aria; il WPA si assicura che nessuno possa leggerli. Passare a WPA2 o WPA3 e scegliere una password robusta sono le difese più efficaci contro le intrusioni.

**Ti piacerebbe che ti guidassi passo dopo passo nella configurazione dei parametri di sicurezza nel pannello di controllo del tuo specifico modello di router?**
""",'sicurezza reti wireles', 2026-04-10, 1, 1),
("""# tipi di WIFI
Quando si parla di progettare una rete Wi-Fi, la scelta dello standard e della configurazione non riguarda solo la "velocità", ma anche come il segnale interagisce con l'ambiente e il numero di dispositivi connessi.

Ecco un’analisi dei principali standard e delle tipologie di architettura di rete.

---

## 1. Gli Standard Wi-Fi (Generazioni)

Oggi ci muoviamo principalmente tra tre generazioni. La differenza fondamentale risiede nelle frequenze utilizzate: **2.4 GHz** (più lenta ma a lungo raggio) e **5 GHz/6 GHz** (più veloci ma a corto raggio).

### Wi-Fi 5 (802.11ac)
È ancora lo standard più diffuso nelle case. Opera quasi esclusivamente sulla banda a 5 GHz.
* **Vantaggi:** Molto economico, compatibile con quasi tutti i dispositivi prodotti nell'ultimo decennio.
* **Svantaggi:** Gestisce male molti dispositivi contemporaneamente; le prestazioni calano drasticamente se ci sono ostacoli o molti vicini con lo stesso Wi-Fi.

### Wi-Fi 6 (802.11ax)
Progettato per l'efficienza in ambienti affollati (uffici, case domotiche).
* **Vantaggi:** Gestisce meglio la batteria dei dispositivi connessi e permette a più dispositivi di "parlare" col router nello stesso istante senza code.
* **Svantaggi:** Richiede che anche i dispositivi (smartphone, PC) siano compatibili per sfruttare i vantaggi reali.

### Wi-Fi 6E e Wi-Fi 7
L'ultima frontiera che introduce la banda a **6 GHz**.
* **Vantaggi:** Una "corsia preferenziale" completamente libera da interferenze (niente forni a microonde o vecchi router dei vicini). Latenza bassissima, ideale per il gaming o lo streaming 8K.
* **Svantaggi:** Costo elevato; il segnale a 6 GHz fatica molto a superare i muri spessi.

---

## 2. Architetture di Rete: Come distribuire il segnale

Oltre allo standard, conta *come* i dispositivi sono collegati tra loro.

### Rete con Router Singolo (Punto-Punto)
La classica configurazione con un solo modem/router al centro della casa.
* **Pro:** Semplicità estrema e costo minimo.
* **Contro:** "Zone morte" nelle stanze lontane. Tutto il carico grava su un solo processore.

### Rete Mesh (A Maglia)
Un sistema composto da un modulo principale e diversi "nodi" sparsi per casa che comunicano tra loro creando un'unica rete.
* **Pro:** Copertura uniforme ovunque; i dispositivi passano da un nodo all'altro senza disconnettersi (roaming fluido).
* **Contro:** I sistemi di alta qualità sono costosi. Se i nodi comunicano tra loro via Wi-Fi (e non via cavo), si perde parte della velocità totale.

### Access Point Cablati (Soluzione Business/Professionale)
Si portano cavi Ethernet in varie stanze e si collegano degli Access Point (AP).
* **Pro:** È la soluzione definitiva per prestazioni e stabilità. Ogni AP ha il massimo della banda disponibile.
* **Contro:** Richiede un impianto elettrico predisposto (passaggio cavi nei muri) e una configurazione più tecnica.

---

## Tabella Comparativa di Sintesi

| Tipo di Rete | Ideale per... | Punto di Forza | Punto di Debolezza |
| :--- | :--- | :--- | :--- |
| **Wi-Fi 5** | Piccoli appartamenti, budget basso | Compatibilità universale | Saturazione con molti device |
| **Wi-Fi 6/7** | Gaming, Smart Home, Streaming | Velocità e gestione code | Costo e raggio d'azione ridotto |
| **Sistemi Mesh** | Case grandi o su più piani | Copertura totale e facilità d'uso | Costo e possibile latenza tra nodi |
| **Access Point** | Uffici o ville con cablaggio | Massima stabilità | Complessità di installazione |

---

### Un consiglio pratico
Se stai cercando di eliminare i problemi di connessione in una casa moderna, un sistema **Wi-Fi 6 Mesh** è attualmente il miglior compromesso tra facilità di installazione e prestazioni a prova di futuro.

Vuoi che ti aiuti a capire quale di queste soluzioni si adatta meglio alla metratura e alla struttura della tua casa?""",'tipi di wifi', 2026-04-12, 1, 1),
("""Ecco un file Markdown (`.md`) completo, progettato appositamente per testare il rendering e le funzionalità di qualsiasi parser o visualizzatore Markdown.

Contiene tutti gli elementi standard (intestazioni, formattazione del testo, liste, tabelle, blocchi di codice, citazioni e altro). Puoi copiarlo e incollarlo direttamente nel tuo file di test.

# Intestazione H1 (Titolo Principale)
## Intestazione H2 (Sottotitolo)
### Intestazione H3
#### Intestazione H4
##### Intestazione H5
###### Intestazione H6

---

## 1. Formattazione del Testo

Questo è un normale paragrafo di testo per testare il font, l'interlinea e la leggibilità generale.

* **Testo in grassetto** (con doppi asterischi)
* __Testo in grassetto__ (con doppi trattini bassi)
* *Testo in corsivo* (con singolo asterisco)
* _Testo in corsivo_ (con singolo trattino basso)
* ***Testo in grassetto e corsivo***
* ~~Testo sbarrato~~
* Testo con evidenziazione ==gialla== *(Nota: supportato solo da alcuni parser come Obsidian o GitHub Flavored)*

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

### Blocco di Codice (Senza evidenziazione)


Questo è un blocco di codice generico.
Non ha colorazione specifica per la sintassi.



### Blocco di Codice con Sintassi (JavaScript)
```javascript
// Funzione di test in JavaScript
function salutaUtente(nome) {
    const messaggio = `Ciao, ${nome}!`;
    console.log(messaggio);
    return messaggio;
}

salutaUtente("Mondo");



### Blocco di Codice con Sintassi (HTML)

```html
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Test Markdown</title>
</head>
<body>
    <h1>Benvenuto</h1>
</body>
</html>

```

---

## 4. Citazioni (Blockquotes)

> Questa è una citazione standard su una sola riga.
> > Questo è un blocco di citazione annidato (secondo livello).
> 
> 
> Torna al primo livello della citazione. Puoi inserire anche del **testo formattato** o del `codice` qui dentro.

---

## 5. Link e Immagini

* [Questo è un link testuale a Google](https://www.google.com)
* [Questo è un link con titolo (passaci sopra il mouse)](https://www.wikipedia.org)

### Immagine

Ecco un test per il rendering delle immagini (usa un'immagine segnaposto):

---

## 6. Tabelle

| ID | Nome Prodotto | Categoria | Prezzo (Allineato a Dx) | Stato (Centrato) |
| --- | --- | --- | --- | --- |
| 001 | Tastiera Meccanica | Elettronica | €89,99 | Disponibile |
| 002 | Mouse Wireless | Elettronica | €45,00 | In Arrivo |
| 003 | Scrivania Legno | Arredamento | €120,50 | Esaurito |

---

## 7. Linee Orizzontali (Divisori)

Tre asterischi:

---

## Tre trattini:

Tre trattini bassi:

---

---

## 8. Elementi Avanzati (Opzionali / Estensioni)

### Note a piè di pagina (Footnotes)

Ecco un testo con una nota a piè di pagina[^1]. E qui ce n'è un'altra[^2].

### Formule Matematiche (LaTeX)

*Formula inline:* $E = mc^2$

*Formula in blocco:*


$$a^2 + b^2 = c^2$$

[^1]: Questa è la prima nota a piè di pagina che apparirà in fondo al documento.
[^2]: Questa è la seconda nota a piè di pagina.

```

```""",'gasa3', 2026-04-13, 2, 1);