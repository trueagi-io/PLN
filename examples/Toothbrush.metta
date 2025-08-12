!(import! &self PLN)

(= (kbstatic)
   (;Implications
    ; If something is made of plastic, applying the lighter on it will make it heatedIf something is made of plastic, applying the lighter on it will make it heated
    (sentence ((Implication (Inheritance $X
                                         (IntSet madeOfPlastic))
                            (Implication (Inheritance (Product SELF $X)
                                                      opLighter)
                                         (Inheritance $X
                                                      (IntSet heated)))) (stv 0.99 0.99)) (2))

    ; If it's heated it will be melted
    (sentence ((Implication (Inheritance $X
                                         (IntSet heated))
                            (Inheritance $X
                                         (IntSet melted))) (stv 0.99 0.99)) (3))

    ; If it's melted it will be pliable
    (sentence ((Implication (Inheritance $X
                                         (IntSet melted))
                            (Inheritance $X
                                         (IntSet pliable))) (stv 0.99 0.99)) (4))

    ; If it's pliable and reshape is applied, it will be screwlike
    (sentence ((Implication (Inheritance $X
                                         (IntSet pliable))
                            (Implication (Inheritance (Product SELF $X)
                                                      opReshape)
                                         (Inheritance $X
                                                      (IntSet screwlike)))) (stv 0.99 0.99)) (5))

    ; If it's screwlike and we opWait, it will be hardened
    (sentence ((Implication (Inheritance $X
                                         (IntSet screwlike))
                            (Implication (Inheritance (Product SELF $X)
                                                      opWait)
                                         (Inheritance $X
                                                      (IntSet hardened)))) (stv 0.99 0.99)) (6))

     ; If it's hardened, we can use it for opUnscrewing to remove the screw
    (sentence ((Implication (Inheritance $X
                                         (IntSet hardened))
                            (Implication (Inheritance (Product SELF $X)
                                                      opUnscrew)
                                         (Inheritance $X
                                                      (IntSet removed)))) (stv 0.99 0.99)) (7))))

;takes 30 sec to compile (no reasoning happening here just preparing a fast PLN reasoner with the concepts and implications engraved)
!(PLN.Init (kbstatic))

(= (kbdynamic)
   (; X is made of plastic
    (sentence ((Inheritance X
                            (IntSet madeOfPlastic)) (stv 0.99 0.99)) (10))
    ; We apply the lighter to it
    (sentence ((Inheritance (Product SELF X)
                            opLighter) (stv 0.99 0.99)) (11))
    (sentence ((Inheritance (Product SELF X)
                            opReshape) (stv 0.99 0.99)) (12))
    (sentence ((Inheritance (Product SELF X)
                            opWait) (stv 0.99 0.99)) (13))
    (sentence ((Inheritance (Product SELF X)
                            opUnscrew) (stv 0.99 0.99)) (14))))

!(Test (PLN.Query (kbdynamic)
                  (Inheritance X
                               (IntSet removed))
                  ) ;10 2 12) ;uncomment for example-specific minimal resource usage
       ((stv 0.895338254258716 0.465880775169793) (10 11 12 13 14)))
