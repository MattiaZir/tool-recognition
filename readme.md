TODO:
fare foto sfondi non uniformi e foto con + obj E LABELLARLE
stabilire mapping per labels_meaning e mantenerlo nel labelling foto con + obj


struttura progetto:

    top-directory/
    script main

        esperimenti/
            gli esperimenti fatti finora, quel che decidiamo di usare lo si sperimenta qui e poi lo si usa nel programma finale.

        support/
            per file temporanei/ausiliari + script che main usa, per fare questo trick: "addpath(genpath('aux/'))"

        data/
            solo dati training e test. i png degli esperimenti vanno sotto esperimenti, ecc...
