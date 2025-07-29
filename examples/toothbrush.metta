!(import! &self PLN)

(= (kbstatic)
   ((sentence ((Concept X) (stv 0.1 0.99)) (0))
    (sentence ((Concept heated) (stv 0.1 0.99)) (0))
    (sentence ((Concept melted) (stv 0.1 0.99)) (0))
    (sentence ((Concept pliable) (stv 0.1 0.99)) (0))
    (sentence ((Concept madeOfPlastic) (stv 0.1 0.99)) (0))
    (sentence ((Concept hardened) (stv 0.1 0.99)) (0))

    (sentence ((Concept applyLighter) (stv 0.1 0.99)) (0))
    (sentence ((Concept wait) (stv 0.1 0.99)) (0))

    (sentence ((Concept screwlike) (stv 0.1 0.99)) (0))

    (sentence ((Implication (Inheritance (Concept $X)
                                         (Concept heated))
                            (Inheritance (Concept $X)
                                         (Concept melted))) (stv 0.99 0.99)) (2))

    (sentence ((Implication (Inheritance (Concept $X)
                                         (Concept madeOfPlastic))
                            (Implication (Inheritance (Concept $X)
                                                      (Concept applyLighter))
                                         (Inheritance (Concept $X)
                                                      (Concept heated)))) (stv 0.99 0.99)) (3))


    ; If it's melted it will be pliable
    (sentence ((Implication (Inheritance (Concept $X)
                                         (Concept melted))
                            (Inheritance (Concept $X)
                                         (Concept pliable))) (stv 0.99 0.99)) (4))

    ; If it's pliable and reshape is applied, it will be screwlike
    (sentence ((Implication (Inheritance (Concept $X)
                                         (Concept pliable))
                            (Implication (Inheritance (Concept $X)
                                                      (Concept reshape))
                                         (Inheritance (Concept $X)
                                                      (Concept screwlike)))) (stv 0.99 0.99)) (5))

    ; If it's screwlike and we wait, it will be hardened
    ;(sentence ((Implication (Inheritance (Concept $X)
    ;                                     (Concept screwlike))
    ;                        (Implication (Inheritance (Concept $X)
    ;                                                  (Concept wait))
    ;                                                  (Concept hardened)))) (stv 0.99 0.99)) (6))
   )
)

;takes 30 sec to compile (no reasoning happening here just preparing a fast PLN reasoner with the concepts and implications engraved)
!(PLN.Init (kbstatic))

(= (kbdynamic)
 (  ; X is made of plastic
    (sentence ( (Inheritance (Concept X)
                             (Concept madeOfPlastic)) (stv 0.99 0.99)) (10))
    ; We apply the lighter to it
    (sentence ( (Inheritance (Concept X)
                             (Concept applyLighter)) (stv 0.99 0.99)) (11))

    ; 
    (sentence ( (Inheritance (Concept X)
                             (Concept reshape)) (stv 0.99 0.99)) (12))
    
    ;
    ;(sentence ( (Inheritance (Concept X)
    ;                         (Concept wait)) (stv 0.99 0.99)) (13))
 )
)

;!(Question (kbdynamic) (Inheritance (Concept X) (Concept melted)) 2)
!(Question (kbdynamic) (Inheritance (Concept X) (Concept screwlike))  5)
;!(Question (kbdynamic) (Inheritance (Concept X) (Concept hardened)) 8)