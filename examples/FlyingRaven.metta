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

!(Question (kbdynamic)
           (Evaluation (Predicate flies)
                       (List (Concept Sam)))
           2)

!(Question (kbdynamic)
           (Evaluation (Predicate flies)
                       (List (Concept Pingu)))
           2)
