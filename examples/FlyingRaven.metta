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
               (stv 0.99 0.9)) (6))
               
    
    (sentence ((Inheritance (Concept Sam1)
                            (Concept Raven1))
               (stv 0.99 0.9)) (7))
    
    (sentence ((Inheritance (Concept Pingu1)
                            (Concept Penguin1))
               (stv 0.99 0.9)) (8))
    
    (sentence ((Evaluation (Predicate flies)
                           (List (Concept Penguin1)))
               (stv 0.01 0.9)) (9))

    (sentence ((Inheritance (Concept Raven1)
                            (Concept Bird1))
               (stv 0.99 0.9)) (10))
    
    (sentence ((Inheritance (Concept Penguin1)
                            (Concept Bird1))
               (stv 0.99 0.9)) (11))

    (sentence ((Evaluation (Predicate flies)
                           (List (Concept Bird1)))
               (stv 0.99 0.9)) (12))
    
    
    (sentence ((Inheritance (Concept Sam1)
                            (Concept Raven1))
               (stv 0.99 0.9)) (13))
    
    (sentence ((Inheritance (Concept Pingu1)
                            (Concept Penguin1))
               (stv 0.99 0.9)) (14))
    
    (sentence ((Evaluation (Predicate flies)
                           (List (Concept Penguin1)))
               (stv 0.01 0.9)) (15))

    (sentence ((Inheritance (Concept Raven1)
                            (Concept Bird1))
               (stv 0.99 0.9)) (16))
    
    (sentence ((Inheritance (Concept Penguin1)
                            (Concept Bird1))
               (stv 0.99 0.9)) (17))

    (sentence ((Evaluation (Predicate flies)
                           (List (Concept Bird1)))
               (stv 0.99 0.9)) (18))
    
    
     (sentence ((Inheritance (Concept Sam2)
                            (Concept Raven2))
               (stv 0.99 0.9)) (19))
    
    (sentence ((Inheritance (Concept Pingu2)
                            (Concept Penguin2))
               (stv 0.99 0.9)) (20))
    
    (sentence ((Evaluation (Predicate flies)
                           (List (Concept Penguin2)))
               (stv 0.01 0.9)) (21))

    (sentence ((Inheritance (Concept Raven2)
                            (Concept Bird))
               (stv 0.99 0.9)) (22))
    
    (sentence ((Inheritance (Concept Penguin2)
                            (Concept Bird))
               (stv 0.99 0.9)) (23))

    (sentence ((Evaluation (Predicate flies)
                           (List (Concept Bird2)))
               (stv 0.99 0.9)) (24))
    
    
               
               
    ))

(= (numthreads)
   4)

!(Test (PLN.Query (kbdynamic)
                  (Evaluation (Predicate flies)
                              (List (Concept Sam)))
                  40 200 200 (numthreads)) ;2 6 9) ;uncomment for example-specific minimal resource usage
       ((stv 0.97052375 0.81) (1 4 6)))

!(Test (PLN.Query (kbdynamic)
                  (Evaluation (Predicate flies)
                              (List (Concept Pingu)))
                  40 200 200 (numthreads)) ;6 5 9) ;uncomment for example-specific minimal resource usage
       ((stv 0.332225678571428 0.83690036900369) (2 3 5 6)))

!(let* ((($Tasks $extendedkb) (PLN.Derive ((sentence ((Inheritance (Concept Pingu)          ;what can be derived from this sentence
                                                                   (Concept Penguin))       ;considering the knowledge base
                                                      (stv 0.99 0.9)) (2))) (kbdynamic) 40 200 200 (numthreads))) ;and only PLN 1 inference step
        ($originalkb (kbdynamic)))
       (subtraction-atom $extendedkb                                               ;not considering what we already knew
                         $originalkb))                                             ;in the original kb
