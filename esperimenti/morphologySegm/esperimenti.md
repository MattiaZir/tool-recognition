# ESPERIMENTO 1

## PARAMETRI
**tipo**: Binarizzazione con otsu del bottomhat
**forma StructEl**: disk
**grandezza StructEl**: 30

## OSSERVAZIONI
Come ci si aspetta, il bottomhat riesce a prendere le zone più "scure" dell'immagine, e ha alcuni problemi nel caso di texture con variazioni di chiaro-scuro pronunciate.

# ESPERIMENTO 2

Visto l'esperimento 1, vorrei provare il tophat con gli stessi parametri del primo esperimento, e vedere se effettivamente prende le parti più luminose dell'immagine.
Chiaramente invece che una chiusura, bisogna fare un'apertura.

## PARAMETRI
**tipo**: Binarizzazione con otsu del tophat
**forma StructEl**: disk
**grandezza StructEl**: 30

## OSSERVAZIONI
Come previsto, le parti più "luminose" dell'immagini vengono binarizzate.

# ESPERIMENTO 3
Tenendo gli stessi parametri, vorrei provare ad applicare un filtro gaussiano sull'immagine prima di farne il tophat/bottomhat.
Inizio con un gaussiano con parametro sigma 2 (abbastanza pesante), l'elemento strutturale rimane uguale e ne prendo il tophat

## PARAMETRI
**tipo**: Binarizzazione con otsu di tophat
**forma StructEl**: disk
**grandezza StructEl**: 30
**filtro**: Gaussiano
**sigma**: 2

## OSSERVAZIONI
La "grana" delle texture è molto più uniforme, in conclusione non credo che bottomhat e tophat possano essere particolarmente utili per fare una segmentazione completa, ma possono essere utili per un pre-processing.


# ESPERIMENTO 4
Voglio provare ad utilizzare della morfologia matematica per generare degli edge relativamente precisi, per poi riempirli.

Queste saranno le operazioni:
- Smoothing morfologico
- binarizzazione con Otsu

## PARAMETRI
**tipo**: Binarizzazione con otsu dello smoothing morfologico
**forma StructEl**: disk
**grandezza StructEl**: 3

## OSSERVAZIONI

Gli edge delle immagini con sfondo uniforme escono quasi perfettamente, l'unico problema si crea con le immagini con uno sfondo texture.


# ESPERIMENTO 5

Voglio provare ad aprire l'immagine gia binarizzata, per togliere le parti di texture.

## PARAMETRI
**tipo**: Binarizzazione con otsu dello smoothing morfologico, con opening della binarizzazione
**forma StructEl**: disk
**grandezza StructEl smoothing**: 3

## OSSERVAZIONI

Sembra ci sia poco cambiamento, forse serve una grandezza maggiore

# ESPERIMENTO 6

Cambio Structuring element, tenendo sempre il disco ma aumentandolo a 9

## PARAMETRI
**tipo**: Binarizzazione con otsu dello smoothing morfologico, con opening della binarizzazione
**forma StructEl**: disk
**grandezza StructEl smoothing**: 3
**grandezza StructEl opening**: 9

## OSSERVAZIONI

Elimina praticamente tutto, bocciato direttamente.