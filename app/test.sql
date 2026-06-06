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

### Blocco di Codice (Senza evidenziazione)
## gantt del progetto

```mermaid
gantt
    title schedule dei tempi stimati per lo sviluppo del progetto - Maggio/Giugno 2026
    dateFormat  YYYY-MM-DD
    axisFormat  %y-%m-%d
    
    section Analisi Applicazioni (Backend)
    Salvataggio Classe Computer (Sanchi)       :a2, 2026-05-01, 3d
    Ottimizzazione & Bug Fix (Monticelli, Rossi) :a3, after a1, 2d

    section Gestione Installazioni (Backend)
    scansione delle app presenti sul pc (Ponte, Kamil, Sanchi) :b1, 2026-05-04, 9d
    Ottimizzazione & Bug Fix (Monticelli, Rossi) :b2, after b1, 2d
    Esecuzione Setup Applicazioni (Ponte, Kamil, Sanchi) :b3, 2026-05-13, 8d
    Ottimizzazione & Bug Fix (Monticelli, Rossi) :b4, after b3, 2d

    section Interfaccia Grafica (Frontend)
    Design Struttura UI (Tomasetti, Ivagnes, Uva, Di Luca) :c1, 2026-05-04, 9d
    Sviluppo UI & Integrazione Backend (Team UI) :c2, 2026-05-13, 8d

    section Revisione e Feedback
    Report Stato Progetto (Arlotti Marco)      :d1, 2026-05-20, 12d
    Revisione & Modiche (Mario)     :d2, after d1, 2d
```
','TEST DEL MARKDOWN E MERMAID', 2026-04-12, 1, 1),

('# LE VPN
Le VPN nascono per collegare piu'' aziende o singoli dipendenti alla rete privata di una sede principale di una azienda proprio come se fossero collegati fisicamente alla rete.

>aprendo le porte allo SMART WORKING, cioe'' un dipendente che lavore da remoto.

La parte piu'' importante di una VPN e'' la sicurezza,
per collegare insieme le sedi al posto che piazzare un cavo fisico, molto costoso e che rischia danneggiamenti, si crea un collegamento logico tramite la rete pubblica come mezzo, ma introducono problemi come la ridotta lentezza e costi della banda usata.

Nel fare passare i pacchetti nella rete pubblica, e'' fondamentale:
- applicare una cifratura,
- controllo degli accessi (autenticazione),
- tunneling dei pacchetti.

---

## Le varie classificazioni
Esistono 2 tipi principali di VPN:

## 1. REMOTE-ACCESS VPN
>Ha la funzione principale di desktop remoto per collegarsi alla LAN della sede principale,
>E'' soprattutto usata per collegare piccole sedi o pochi dipendenti alla LAN principale.

I singoli utenti si collegano ad un server di accesso detto NAS
> NAS (NETWORK ACCESS SERVER) che puo'' essere dell''HARWARE dedicato o una semplice applicazione eseguita in un server condiviso.
>
>Il NAS chiede le credenziali all''utente, che se valide, gli permettera'' di usare la VPN.

Il *NAS* per verificare la autenticazione puo'' appoggiarsi ad un `RADIUS AAA SERVER` che lo fa al posto suo.

> il RADIUS server oltre all''autenticazione, il RADIUS è fondamentale per l''Accounting. Nelle VPN aziendali, serve a generare log legali: chi si è connesso, da quale IP pubblico, a che ora e per quanto tempo. Questo è vitale per la sicurezza post-incidente.

***AAA*** sta per:
- `Authentication` (verifica gli accessi),
- `Authorization` (verifica cio'' che e'' permesso),
- `Accounting` (tiene tracci adi chi fa che cosa {non ripiudabilita''}).

In piu'' per funzionare, il client dovra'' munirsi di un software VPN client.

>l''affitto di un NAS e'' detto ESP,
>L''ESP configura il NAS e lo mantiene funzionante a chi lo affittera''.

## 2. SITE-TO-SITE VPN
>Si usa principalmente per collegare 2 sedi grosse insieme permettendogli di condividere le risorse (stampanti, pc, archivio).

nelle Site-to-Site, i singoli PC non sanno di essere in una VPN. Il tunnel è "trasparente" e viene gestito interamente dai gateway (Router/Firewall).

La SITE-TO-SITE VPN si divide principalmente in:
- INTRANET BASED:
    >Una rete intranet collega 2 sedi in una unica.
- EXTRANET BASED:
    >Se l''azienda ha un rapporto stretto con un altra azienda esterna, EXTRANET permette di lavorare insieme in modo sicuro condividendo le risorse, senza dando l''accesso  preventivo e completo a tutto.

---

## La sicurezza delle VPN
Come mezzo le VPN usano la rete pubblica e'' neccessario che il traffico venga crittografato.

Passando per una rete pubblica, i pacchetti devono mantenere la propria integrita'' e autenticita''.

Il passi che una VPN deve seguire sono:

### 1. Autenticazione degli utenti (autenticazione)
Le VPN possono essere usati solo da determinati utenti,
quindi bisogna verificarnr la corretta identita'' per l''accesso ad essa con un autenticazione.

Cio lo si fa tramite server NAS con un processo di autenticazione, o uno dedicato come l''AAA.

L''autenticazione ad una VPN sfrutta una MFA (Multy Factor Authentication),
che aggiunge un livello in piu'' di sicurezza,

>In passato si usava che l''utente scriva un codice generato tramite una chiave elettronica (KEY FOB) che cambiava ogni volta.
>
>Ma ora si utilizzano applicazioni da smartphone che generano un OTP (One Time Password) che genera una sequenza di caratteri casuali da inserire, o direttamente l''impronta di un dito (Fingerprint), o un QR code.

Solo dopo aver eseguito l''autenticazione, all''utente viene concessa l''autorizzazzione per usare i servizi della rete.

Grazie all''autenticazione si possono apportare misure di accounting per salvarsi i vari accessi e la quantita'' di dati in entrata e uscita,
tempi di utilizzo dei vari utenti (durata di sessione per tariffare l''utilizzo della rete) e quali risorse si hanno usato attraverso dei file di log.

---

## 2. Cifratura dei dati (CRITTOGRAFIA)

Le VPN utilizzano il protocollo IKE (Internet Key Exchange), che ha lo scopo di automatizzare lo scambio delle chiavi.

I principali protocolli che applicano la crittografia sono:
- IPsec (IP security),
- SSL/TLS (Secure Socket layer / Trasport Layer Security),
- BGP/MPLS (Border Gateway Protocol / Multiprotocol Lable Switching).

## 3. TUNNEL o MODALITA'' TRASPORTO
### Trasporto
In modalita'' trasporto, e'' compito del software a collegarsi alla VPN e soprattutto questo approccio rende compatibile la VPN con qualunque ISP della rete,
in quanto cifratura e decifratura verra'' gestita dal software,
Lasciando in chiaro solamente le informazioni per instradare il pacchetto.

### Tunnel
Invece con il TUNNELING si utilizzano gli apparati di rete, in particolare i FIREWALL e ROUTER, questo approccio nasconde all''utente la presenza di una VPN, in questa modalita'' gli apparati di rete apposta modificano il traffico della VPN incapsulandolo in un pacchetto, proteggiendo cosi'' il pacchetto originale proteggendolo completamente, mostrando cosi'' solo quello esterno.

- Passenger Protocol: È il pacchetto originale (es. il pacchetto del dipendente che vuole stampare).
- Encapsulating Protocol: È il protocollo che protegge (es. IPsec).
- Carrier Protocol: È il protocollo che trasporta il tutto sulla rete pubblica (es. IPv4).

I due router in entrata delle LAN deve essere di tipo DUAL STACK in modo da poter comprendere sia IPV6 che IPV4 e soprattutto il tunneling serve proprio a far passare protocolli che altrimenti non viaggerebbero su Internet (come il multicast o protocolli non instradabili).

## - IPsec
IPsec non e'' solo un protocollo ma e'' una vera e propria architettura di sicurezza del livello NETWORK,
i 3 principali protocolli che la compongono sono:

- AH (Authentication Header):
    che garantisce solo la AUTENTICAZIONE e la INTEGRITA'' ma ***NON*** cifra il transito.
    
    > AH è quasi in disuso. Il motivo è che AH fallisce se attraversa un router che fa NAT (Network Address Translation), perché AH valida anche l''header IP esterno. Se il NAT cambia l''indirizzo IP, il controllo di integrità di AH fallisce.

- ESP (Encapsulating Security Payload):
    > che comprende anche la CIFRATURA dei messaggi.

- IKE (Internet Key Exchange):
    > si occupa di gestire e scambiare le chiavi per la crittografia della comunicazione, e lavora al livello APPLICATION.

Sia AH che ESP possono essere usati o in modalita'' TRASPORTO o in TUNNEL, di cui per essere usati hanno bisogno di creare una connessione LOGICA detta SA (Security association) lavora al livello NETWORK e viene fatta grazie all''IKE.

IKE usa UDP per comunicare pero'' usa un servizio affidabile, in caso la richiesta di connessione non arriva IKE ritrasmettera'' la richiesta.

Una connessione con SA dura poco e fa trasmettere pochi dati, in caso che serva inviare piu'' dati,
si instaura una nuova SA.

IPsec usa due SECURITY GATEWAY alle entrate delle LAN per incapsulare o leggere il pacchetto, che sara'' in arrivo o in uscita.

In questo modo il pacchetto da inviare usera'' il suo routing, mentre il pacchetto che lo INCAPSULA usa il routing per spedirlo alla LAN.

Le SA sono UNIDIREZIONALI, quindi si dovranno creare 2 SA in caso si voglia comunicare da entrambi i lati.

Tutte le SA sono salvate all''interno di un SAD (Security Association Database), mentre le politiche di sicurezza (quali ip scartare) vengono salvate nel SPD (Security Policy Database).

### 1. Traffico in Uscita (Outbound)
*Outbound segue le fasi:*
1. ***Il Controllo SPD***:
Quando un pacchetto deve uscire, il sistema consulta l''SPD, che puo'' causare tre esiti possibili:

    1. Il pacchetto viene scartato (firewall).

    2. Il pacchetto passa senza IPsec (traffico in chiaro).

    3. Il pacchetto deve essere protetto da IPsec.

2. ***Associazione al SAD***:
Se l''esito è il (3), si cerca nel SAD (Security Association Database) se esiste già una SA (una "connessione sicura") attiva per quel tipo di traffico.

    1. Se esiste: Si usa la chiave e l''algoritmo già pronti.

    2. Se NON esiste: Si avvia il protocollo IKE (Internet Key Exchange) per negoziare le chiavi in tempo reale, creare la SA e registrarla nel SAD.

3. ***Fase di Trasformazione***:
Solo a questo punto il pacchetto viene processato (Cifratura/Autenticazione) e incapsulato.

### Traffico in ingresso (inbound)

In ingresso il processo è "inverso", ma con un controllo di sicurezza fondamentale alla fine:

1. ***Riassemblaggio***:
Corretto. Se il pacchetto è frammentato, va ricomposto prima di poter leggere gli header IPsec.

2. ***Identificazione***:
Il ricevente vede che il protocollo nell''header IP non è TCP o UDP, ma ESP (50) o AH (51).

3. ***Lookup tramite SPI***:
Qui c''è un dettaglio importante. Per trovare la SA giusta nel SAD, il ricevente usa una "tripletta" di valori:

    1. SPI (Security Parameters Index) – che si trova nell''header ESP/AH.
        > la SPI (Security Parameter Index) è come un "ID della sessione" che permette al ricevente di capire istantaneamente quale chiave usare per decifrare quel pacchetto specifico.

    2. Indirizzo IP Destinazione.

    3. Protocollo di sicurezza (AH o ESP).

4. ***Decapsulamento***:
Una volta trovata la SA, il pacchetto viene decifrato e autenticato.

5. ***Il controllo finale dell''SPD (Fondamentale)***:
Questo è il punto che spesso sfugge. Dopo aver "estratto" il pacchetto originale, il sistema ricontrolla l''SPD. Perché? Per verificare che quel pacchetto sia effettivamente arrivato con la protezione corretta.

## - AH, ESP, IKE nel dettaglio

### 1. AH (Authentication Header)
AH fornisce:
- autenticazione,
- integrita''

>contro gli attacchi di tipo replay, in cui un malintenzionato mette in rete un pacchetto clonato precedentemente intercettandolo.

AH autentica l''intero pacchetto IP ad eccezzione dei campi variabili dell''header IP originale.

AH aggiunge il campo SPI (Security Parameters Index) che contiene un valore numerico che insieme con l''IP di destinazione e il protocollo AH identifica la SA usata.

In modalita'' tunnel l''intero pacchetto e'' incapsulato in un nuovo pacchetto autenticandolo tutto nel processo.

### 2. ESP (Encapsulating Security Payload)

ESP aggiunge la crittografia che manca ad AH.

A contrario di AH, ESP non authentica tutto il pacchetto, non coprendo l''header IP:
> 1. in trasporto l''header ip originale e'' in chiaro.

> 2. in tunnel l''header originale viene cifrato ma quello esterno no.

ESP all''interno del pacchetto aggiunge:
- HEADER ESP (per incapsulare)
- TRAILER ESP (per incapsulare)
- AUTHENTICATION ESP (per autenticare)

Simile ad AH, nell''header ESP  e'' presente il campo SPI che identifica la SA usata per quel pacchetto.

### 3. IKE (Internet Key Exchange)
Le SA possono essere fatte manualmente, ma non e'' fisicamente fattible, come soluzione si usa IKE.
IKE si occupa di creare delle nuove SA ogni volta che serva.

IKE realizza un collegamento peer-to-peer in due fasi:
    1. fase 1:
        I 2 host creano una nuova SA per IKE stesso (IKE SA), che verra'' usata per creare nuove SA in modo sicuro.
    2. fase 2:
        Si usa la IKE SA creata per negoziare le altre SA da usare per gli altri protocolli.

## SSL/TLS VPN
Una valida alternativa a IPsec e'' SSL/TLS (Secure Sockets Layer/Trasport Layer Security).

>Le differenze sono marginali tra SSL/TLS e IPsec:
ma uno dei grandi vantaggi di SSL/TLS è che può funzionare senza software installato, usando solo il browser (Portal VPN).
>
>IPsec invece richiede quasi sempre un software dedicato.

SSL/TLS opera tecnicamente sopra il livello Transport (TCP).

SSL/TLS e'' composto da due livelli:
- Record Protocol:
    Opera sopra un protocollo di livello Trasport ed incapsula i protocolli di livello superiore.
- Handshake Protocol:
    Si occupa di negoziare:
    si autentica con L''interlocutore e si stabilisce una crittografia comune.
    Al posto che IKE si usa il protocollo di SSL/TLS per creare le chavi per il Tunneling.

SSL/TLS lavora tramite client/server e autentica il server da parte del client da parte del client pero''
e'' opzionale che il client si autentichi al server.

L''Autenticazione si basa su i certificai digitali,
il server invia il certificato tramite firma digitale.

I passi della connessìone sono:
1. Client -> Server:
    Il client invia al server la richiesta per la connessione e la lista  di algoritmi di crittografia supportati,
    poi si crea un valore random detto PRE-MASTER KEY.

    Che a sua volta servira'' a generare la chiave privata comune ad entrambi.

2. SERVER -> CLIENT:
    Il server invia al client il proprio certificato digitale e la scelta degli algoritmi di crittografia,
    e infine invia il suo valore casuale per generare la PRE-MASTER KEY,
    e richiede il certificato del client.

3. CLIENT -> SERVER:
    Il client verifica il certificato del server, se fallisce stacca la connessione, altrienti invia al server il certificato e la pre-master key cifrata con lachiave pubblica del server.
    Poi inizia la comunicazione.

4. SERVER -> CLIENT:
    il server accetta il certificato e inizia la comunicazione cifrata.

dopo il 3° punto il server e il client sono a posto per comunicare.

### Confronto tra IPsec e SSL/TLS.
Benche IPsec sia il piu'' diffuso, rimane critica la fare dello scambio di chiavi durante l''IKE.
In piu'' IPsec deve richiedere un supporto lato sistema operativo, e SSL/TLS e'' meno complicato di IPsec,
IPsec offre diversi meccanismi di autenticazione, mentre ssl/tls offre certificati digitali.

Pero'' SSL/TLS offre una autenticazione Assimmentrica (senza aspettare il client).
IPsec essendo PEER to PEER richiede autenticazione reciproca.
IPsec e SSL lavorano a livelli differenti dello stack, permettendo a IPsec di proteggere sopra all''IP.

## BGP/MPLS
In una rete Multiprotocol Lable Switching, la parte della VPN viene gestita dai Service Provider,
di cui usano:
- CE (Customer Edge Router):
    Quando si parla di CE si parla del Router in entrata/uscita delle varie sedi sparse,
    che tramite il BGP (Border Gateway protocol) comunicano con il PE.

- PE (provider Edge Router):
    Il PE e'' il router in ingresso/uscita del Provider della VPN.

- P (Provider Core Router):
    Fanno l''azione di instradare i pacchetti verso un PE (scelgono che strada dovranno seguire).

Le reti BGP/MPLS sono PEER to PEER.
Per trasferire i pacchetti tra 2 siti di una VPN, il PE incapsulera'' (TUNNELING)
i pacchetti in transito dal CE.

> VRF (VPN Routing and Forwarding): il router del provider (PE) viene diviso in tanti "router virtuali" indipendenti.
Ogni azienda ha la sua tabella di routing privata (VRF) dentro il router del provider.
>
>Questo evita che il traffico di una azienda si mischi con un altra.
>il PE quindi dovra'' gestire tot tabelle in base a quanti utilizzatori diversi si hanno.

Un PE possiede anche la GFT (Global Forwarding Table) che gli permette di indirizzare i pacchetti verso un altro PE usando un sistema di Lable.
La lable di BGP/MPLS e'' composta da:
- parte esterna:
    Indirizza il pacchetto verso il next hop per la rete BGP/MPLS di cui conterra'' l''identificativo del prossimo PE che dovra'' attraversare.
- parte interna:
    Viene indicato il nodo di uscita dalla rete BGP/MPLS.

## VPN di fiducia e SECURE VPN

Le VPN son divise in:
- Trusted VPN:
    La Trusted si affida al ISP per occuparsi di tutto per gestire la VPN.
    Non usa tunneling o altro, ma garantisce tunnel dedicati, garantendone la sicurezza.

    Al layer 2 si usano ATM e tecnologia BGP/MPLS.
    Al layer 3 si usa BGP/MPLS con limitate informazioni.

- Secured VPN:
    Le Secured utilizzano il TUNNELING e la CIFRATURA.
    La Secured pu'' usare i protocolli:
    - IPsec
    - SSL/TLS
    - PPTP
    - SOCKS
    - L2TP
    - L2TPv3
    - BGP/MPLS

- Hybrid VPN:
    Le hybrid uniscono i protocolli della Secured e la applicano alla Trusted:
    - La secured assicura la protezione, ma non i percorsi.
    - La Trusted assicura i percorsi, ma non la sicurezza.
','LE VPN', 2026-04-13, 2, 1);