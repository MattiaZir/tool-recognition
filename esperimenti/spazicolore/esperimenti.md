# ESPERIMENTO 1

*Ipotesi*: Essendo lo spazio colori L\*a\*b* progettato per approssimare la visione umana, ignorando la componente L (luminosita) e lavorando solo sui picchi globali in **a** e **b** potrei riuscire a segmentare lo sfondo in modo decente nelle immagini singole, poiche i picchi dovrebbero corrispondere ai colori di sfondo, poiche hanno una maggioranza dei pixel.

*Procedimento*:
A grandi linee il procedimento sara quello di convertire l'immagine nello spazio colori CIELAB, ignorare la componente di luminosita e trovare i picchi dell'istogramma in **a** e **b**, crearne una maschera binaria, e moltiplicarla per l'immagine e visualizzare il tutto.

## PARAMETRI
**Intervallo di confidenza**: 95% (entrambi i lati).

## OSSERVAZIONI

Promette  bene, nell'immagine 46 ha praticamente isolato quasi perfettamente lo sfondo, e anche nell'immagine 28 sembra prendere buona parte dello sfondo, il problema nasce quando un'oggetto ha un colore simile allo sfondo, forse l'operazione di *or* non è quella adatta.

---

# ESPERIMENTO 2

*Ipotesi*: Sarebbe interessante vedere sul canale Saturazione dell'HSV, dato che H è la tinta e V è quanto è la brillantezza, la saturazione sembra il canale migliore su cui lavorare.

## PARAMETRI
**Intervallo di confidenza**: 95% (entrambi i lati).

## OSSERVAZIONI

Ottimi risultati, con della morfologia matematica si può arrivare ad un miglioramento, inoltre sarebbe interessante modificare l'intervallo di confidenza e controllare quale sia meglio.