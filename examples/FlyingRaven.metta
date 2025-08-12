!(import! &self PLN)

;takes 30 sec to compile (no reasoning happening here just preparing a fast PLN reasoner with the concepts and implications engraved)
!(PLN.Init ((sentence ((Implication (Inheritance $1
                                                 Penguin)
                                    (Not (Inheritance $1
                                                      (IntSet flies))))
                       (stv 0.99 0.9)) (0))))

(= (kbdynamic)
   ((sentence ((Inheritance Sam
                            Raven)
               (stv 0.99 0.9)) (1))
    
    (sentence ((Inheritance Pingu
                            Penguin)
               (stv 0.99 0.9)) (2))

    (sentence ((Inheritance Raven
                            Bird)
               (stv 0.99 0.9)) (4))
    
    (sentence ((Inheritance Penguin
                            Bird)
               (stv 0.99 0.9)) (5))

    (sentence ((Inheritance Bird
                            (IntSet flies))
               (stv 0.99 0.9)) (6))))

!(Test (PLN.Query (kbdynamic)
                  (Inheritance Sam
                               (IntSet flies))
                  ) ;2 6 9) ;uncomment for example-specific minimal resource usage
       ((stv 0.970299 0.6932717463771) (1 4 6)))

!(Test (PLN.Query (kbdynamic)
                  (Inheritance Pingu
                               (IntSet flies))
                  ) ;6 5 9) ;uncomment for example-specific minimal resource usage
       ((stv 0.0199 0.793881) (2)))

!(let* ((($Tasks $extendedkb) (PLN.Derive ((sentence ((Inheritance Pingu          ;what can be derived from this sentence
                                                                   Penguin)       ;considering the knowledge base
                                                      (stv 0.99 0.9)) (2))) (kbdynamic) 1)) ;and only PLN 1 inference step
        ($originalkb (kbdynamic)))
       (subtraction-atom $extendedkb                                               ;not considering what we already knew
                         $originalkb))                                             ;in the original kb
