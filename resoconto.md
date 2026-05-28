# Resoconto finale del progetto finale
## runnare il progetto
l'app usa usa gunicorn come wsgi quindi:
1. installare i requirements
2. runnare gunicorn
``` python
gunicorn -w 4 -b 127.0.0.1:8000 wsgi:app
curl http://127.0.0.1:8000
```


Questo progetto mi ha istruito su come gestire le tempistiche durante i tempi stretti,

non avendo creato una semplice analisi dei requisiti, mi sono ritrovato a creare funzioni non presenti in essa,

questo a portato allo sforamento delle tempistiche del progetto, le funzioni principali del progetto sono state svolte con successo, molte delle funzioni che volevo implementare ho deciso di scartarle per riuscire a completare in tempo il progetto,

La web app permette dopo aver effettuato un accesso al sito, di fare un upload di file .md e html, essi poi verranno convertiti in testo, e messi nel database, successivamente per mostrarli la web app tramite la libreria re (per usare REGEX) e markdown per convertire il testo in codice html,

Ho preso la liberta' di aggiungere una funzione che permetta di filtrare i vari post (detti notes) in base a vari campi.

La parte che mi ha fatto perdere piu' tempo era la pagina relativa alle mie informazioni, che scegliere l'aspetto grafico di essa mi ha mangiato molto tempo,

Comunque grazie a cio' ho imparato come funziona il linguaggio di CSS per abbellire le pagine visto che molto spesso nei nostri programmi la parte di CSS dello style viene molto trascurata per la necessita' di non voler perdere tempo.

Anche se il progetto e' finito in ritardo sono soddisfatto di come e' venuto, perche' grazie a esso ho imparato il perche' e' fondamentale prima organizzare un analisi dei requisiti e poi il codice.

IL progetto e' stato sviluppato senza l'uso pesante di AI, ma proprio grazie ad essa sono riuscito a capire immediatamnte dove il programma aveva degli errori.

Senza l'uso delle varie AI il progetto sarebbe durato molto piu' tempo.

Per vedere il sito web aprire la pagina: [SITO WEB](https://project-appunti-scuola.onrender.com/)