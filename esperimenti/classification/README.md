# README
Questo e' un breve README per spiegare cosa contiene la cartella e come utilizzare i suoi contenuti.

### classifier.mat
Il classificatore e' stato trovato tramite il classification learner, al suo interno ci sono tutte le informazioni del caso, non e' stato modificato per ora e tutti gli iperparametri sono stati scelti direttamente dal classification learner sulla base dell'80% dei dati caricati nella tabella.

Alcune delle immagini, dato che toccavano i bordi, sono state rimosse dal classificatore.

Le immagini di training erano SOLO quelle singole.

### creaTabellaDaRegionProps.m
Questa funzione e' autodescrittiva, sarebbe da migliorare perche' ora come ora e' tutto hardcoded.

### extractor.m
Estrae le feature che abbiamo scelto, sono solo features di regione.

### hu_moments.m
Questa funzione calcola i momenti di Hu delle regioni.

#### ALTRO
Gli altri elementi presenti nella cartella sono relativi agli esperimenti effettuati e potrebbero essere eliminati in futuro.