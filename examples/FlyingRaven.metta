!(import! &self PLN)

(= (kbstatic)
   ((sentence ((Concept Sam) (stv 0.2 0.9)) (0))
    (sentence ((Concept Pingu) (stv 0.2 0.9)) (0))
    (sentence ((Concept Penguin) (stv 0.2 0.9)) (0))
    (sentence ((Concept Raven) (stv 0.2 0.9)) (0))
    (sentence ((Concept Bird) (stv 0.2 0.9)) (0))))

;takes 30 sec to compile (no reasoning happening here just preparing a fast PLN reasoner with the concepts and implications engraved)
!(PLN.Init (kbstatic))

(= (kbdynamic)
   ((sentence ((Inheritance (Concept Sam)
                            (Concept Raven))
               (stv 0.99 0.9)) (1))
    
    (sentence ((Inheritance (Concept Pingu)
                            (Concept Penguin))
               (stv 0.99 0.9)) (2))
    
    (sentence ((Evaluation (Predicate flies)
                           (List (Concept Penguin)))
               (stv 0.01 0.9)) (3))

    (sentence ((Inheritance (Concept Raven)
                            (Concept Bird))
               (stv 0.99 0.9)) (4))
    
    (sentence ((Inheritance (Concept Penguin)
                            (Concept Bird))
               (stv 0.99 0.9)) (5))

    (sentence ((Evaluation (Predicate flies)
                           (List (Concept Bird)))
               (stv 0.99 0.9)) (6))))

!(Test (PLN.Query (kbdynamic)
                  (Evaluation (Predicate flies)
                              (List (Concept Sam)))
                  ) ;2 6 9) ;uncomment for example-specific minimal resource usage
       ((stv 0.97052375 0.81) (1 4 6)))

!(Test (PLN.Query (kbdynamic)
                  (Evaluation (Predicate flies)
                              (List (Concept Pingu)))
                  ) ;6 5 9) ;uncomment for example-specific minimal resource usage
       ((stv 0.332225678571428 0.83690036900369) (2 3 5 6)))

!(let* (($extendedkb (PLN.Derive ((sentence ((Inheritance (Concept Pingu)          ;what can be derived from this sentence
                                                          (Concept Penguin))       ;considering the knowledge base
                                             (stv 0.99 0.9)) (2))) (kbdynamic) 1)) ;and only PLN 1 inference step
        ($originalkb (kbdynamic)))
       (subtraction-atom $extendedkb                                               ;not considering what we already knew
                         $originalkb))                                             ;in the original kb
