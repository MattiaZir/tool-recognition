# ESPERIMENTO 1

*Ipotesi*: essendo la maggioranza dell'immagine lo sfondo, che può essere più o meno uniforme, teoricamente i "picchi" nell'istogramma saranno a livello dello sfondo, per esempio prendendo l'immagine  #0073.jpg, si può notare che la maggioranza dei pixel, essendo di sfondo, è "scura"

Dato che la binarizzazione adattiva ha bisogno della polarità del foreground ed un livello di sensibilità, potrebbe essere possibile ricavare questi valori tramite l'istogramma.

La polarità sarà di default "dark", ma diventerà bright nel caso la funzione graythresh risultasse in un valore uguale o sopra lo 0.5

La sensibilità sarà uguale a thresh.

## PARAMETRI
polarità: dark (default) | bright (se graythresh >= 0.5)

## OSSERVAZIONI
Risultati ottimi nello sfondo uniforme, pessimi progressivamente negli altri sfondi.

Come ci si aspettava, il problema nasce quando l'intensità è troppo vicina a quella dello sfondo.

Una ricostruzione morfologica potrebbe essere una buona idea per omogeneizzare gli sfondi.


# ESPERIMENTO 2

*Ipotesi*: con questo metodo ottengo immagini più o meno decenti, adesso potrei fare un labeling delle componenti connesse, ordinarle per "grandezza" (area), e rimuovere tutte le label che sono sotto la 10° più grande in "classifica", così da pulire un po' l'immagine binarizzata.

prima di questo labeling, potrei applicare un'operazione di apertura morfologica per rimuovere quelle minori, magari utilizzando uno strel piccolo.

## PARAMETRI
polarità: dark (default) | bright (se graythresh >= 0.5)


## OSSERVAZIONI
Risultati non ottimi, non so bene cosa fare ora che ho queste aree, il problema delle texture rimane.