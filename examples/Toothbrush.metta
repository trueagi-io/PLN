!(import! &self (library lib_pln))

(= (STV X) (stv 0.1 0.99))
(= (STV madeOfPlastic) (stv 0.1 0.99))
(= (STV heated) (stv 0.1 0.99))
(= (STV melted) (stv 0.1 0.99))
(= (STV pliable) (stv 0.1 0.99))
(= (STV screwlike) (stv 0.1 0.99))
(= (STV hardened) (stv 0.1 0.99))
(= (STV removed) (stv 0.1 0.99))
(= (STV opLighter) (stv 0.1 0.99))
(= (STV opReshape) (stv 0.1 0.99))
(= (STV opWait) (stv 0.1 0.99))
(= (STV opUnscrew) (stv 0.1 0.99))

(= (kb)
   (;Implications
    ; If something is made of plastic, applying the lighter on it will make it heatedIf something is made of plastic, applying the lighter on it will make it heated
    (Sentence ((Implication (Inheritance $X
                                         madeOfPlastic)
                            (Implication (Operation   $X
                                                      opLighter)
                                         (Inheritance $X
                                                      heated))) (stv 0.99 0.99)) (2))

    ; If it's heated it will be melted
    (Sentence ((Implication (Inheritance $X
                                         heated)
                            (Inheritance $X
                                         melted)) (stv 0.99 0.99)) (3))

    ; If it's melted it will be pliable
    (Sentence ((Implication (Inheritance $X
                                         melted)
                            (Inheritance $X
                                         pliable)) (stv 0.99 0.99)) (4))

    ; If it's pliable and reshape is applied, it will be screwlike
    (Sentence ((Implication (Inheritance $X
                                         pliable)
                            (Implication (Operation   $X
                                                      opReshape)
                                         (Inheritance $X
                                                      screwlike))) (stv 0.99 0.99)) (5))

    ; If it's screwlike and we opWait, it will be hardened
    (Sentence ((Implication (Inheritance $X
                                         screwlike)
                            (Implication (Operation   $X
                                                      opWait)
                                         (Inheritance $X
                                                      hardened))) (stv 0.99 0.99)) (6))

     ; If it's hardened, we can use it for opUnscrewing to remove the screw
    (Sentence ((Implication (Inheritance $X
                                         hardened)
                            (Implication (Operation   $X
                                                      opUnscrew)
                                         (Inheritance $X
                                                      removed))) (stv 0.99 0.99)) (7))
    (Sentence ((Inheritance X
                            madeOfPlastic) (stv 0.99 0.99)) (10))
    ; We apply the lighter to it
    (Sentence ((Operation X
                          opLighter) (stv 0.99 0.99)) (11))
    (Sentence ((Operation X
                          opReshape) (stv 0.99 0.99)) (12))
    (Sentence ((Operation X
                          opWait) (stv 0.99 0.99)) (13))    
    (Sentence ((Operation X
                          opUnscrew) (stv 0.99 0.99)) (14))))

!(test (PLN.Query (kb)
                  (Inheritance X
                               removed)
                  ) ;10 2 12) ;uncomment for example-specific minimal resource usage
       ((stv 0.9013534742103302 0.8953382542587163) (2 3 4 5 6 7 10 11 12 13 14)))
