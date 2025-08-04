!(import! &self PLN)

(= (kbstatic)
   (;Considered instance
    (sentence ((Concept X) (stv 0.1 0.99)) (0))
    ;Materials
    (sentence ((Concept madeOfPlastic) (stv 0.1 0.99)) (0))
    ;Object properties
    (sentence ((Concept heated) (stv 0.1 0.99)) (0))
    (sentence ((Concept melted) (stv 0.1 0.99)) (0))
    (sentence ((Concept pliable) (stv 0.1 0.99)) (0))
    (sentence ((Concept screwlike) (stv 0.1 0.99)) (0))
    (sentence ((Concept hardened) (stv 0.1 0.99)) (0))
    (sentence ((Concept removed) (stv 0.1 0.99)) (0))
    ;Ops
    (sentence ((Concept opLighter) (stv 0.1 0.99)) (0))
    (sentence ((Concept opReshape) (stv 0.1 0.99)) (0))
    (sentence ((Concept opWait) (stv 0.1 0.99)) (0))
    (sentence ((Concept opUnscrew) (stv 0.1 0.99)) (0))
    ;Implications
    ; If something is made of plastic, applying the lighter on it will make it heatedIf something is made of plastic, applying the lighter on it will make it heated
    (sentence ((Implication (Inheritance (Concept $X)
                                         (Concept madeOfPlastic))
                            (Implication (Operation   (Concept $X)
                                                      (Concept opLighter))
                                         (Inheritance (Concept $X)
                                                      (Concept heated)))) (stv 0.99 0.99)) (2))

    ; If it's heated it will be melted
    (sentence ((Implication (Inheritance (Concept $X)
                                         (Concept heated))
                            (Inheritance (Concept $X)
                                         (Concept melted))) (stv 0.99 0.99)) (3))

    ; If it's melted it will be pliable
    (sentence ((Implication (Inheritance (Concept $X)
                                         (Concept melted))
                            (Inheritance (Concept $X)
                                         (Concept pliable))) (stv 0.99 0.99)) (4))

    ; If it's pliable and reshape is applied, it will be screwlike
    (sentence ((Implication (Inheritance (Concept $X)
                                         (Concept pliable))
                            (Implication (Operation   (Concept $X)
                                                      (Concept opReshape))
                                         (Inheritance (Concept $X)
                                                      (Concept screwlike)))) (stv 0.99 0.99)) (5))

    ; If it's screwlike and we opWait, it will be hardened
    (sentence ((Implication (Inheritance (Concept $X)
                                         (Concept screwlike))
                            (Implication (Operation   (Concept $X)
                                                      (Concept opWait))
                                         (Inheritance (Concept $X)
                                                      (Concept hardened)))) (stv 0.99 0.99)) (6))

     ; If it's hardened, we can use it for opUnscrewing to remove the screw
    (sentence ((Implication (Inheritance (Concept $X)
                                         (Concept hardened))
                            (Implication (Operation   (Concept $X)
                                                      (Concept opUnscrew))
                                         (Inheritance (Concept $X)
                                                      (Concept removed)))) (stv 0.99 0.99)) (7))))

;takes 30 sec to compile (no reasoning happening here just preparing a fast PLN reasoner with the concepts and implications engraved)
!(PLN.Init (kbstatic))

(= (kbdynamic)
   (; X is made of plastic
    (sentence ((Inheritance (Concept X)
                            (Concept madeOfPlastic)) (stv 0.99 0.99)) (10))
    ; We apply the lighter to it
    (sentence ((Operation (Concept X)
                          (Concept opLighter)) (stv 0.99 0.99)) (11))
    (sentence ((Operation (Concept X)
                          (Concept opReshape)) (stv 0.99 0.99)) (12))
    (sentence ((Operation (Concept X)
                          (Concept opWait)) (stv 0.99 0.99)) (13))    
    (sentence ((Operation (Concept X)
                          (Concept opUnscrew)) (stv 0.99 0.99)) (14))))

!(Test (PLN.Query (kbdynamic)
                  (Inheritance (Concept X) 
                               (Concept removed))
                  ) ;10 2 12) ;uncomment for example-specific minimal resource usage
       ((stv 0.905100467696027 0.895338254258716) (10 11 12 13 14)))
