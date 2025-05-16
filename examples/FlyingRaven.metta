(= (STV (Concept Sam))
   (stv 0.333 1))

(= (STV (Concept Raven))
   (stv 0.333 1))

(= (STV (Concept Bird))
   (stv 0.333 1))

(= (kb)
   (
    (Sentence ((Inheritance (Concept Sam)
                            (Concept Raven))
              (stv 0.99 0.9)) (1))
    
    (Sentence ((Inheritance (Concept Pingu)
                            (Concept Penguin))
              (stv 0.99 0.9)) (2))
    
    (Sentence ((Evaluation (Predicate flies) 
                           (List (Concept Penguin)))
              (stv 0.01 0.9)) (3))

    (Sentence ((Inheritance (Concept Raven)
                            (Concept Bird))
              (stv 0.99 0.9)) (4))
    
    (Sentence ((Inheritance (Concept Penguin)
                            (Concept Bird))
              (stv 0.99 0.9)) (5))

    (Sentence ((Evaluation (Predicate flies) 
                           (List (Concept Bird)))
              (stv 0.99 0.9)) (6))
   ))

!(Question (kb)
           (Evaluation (Predicate flies)
                       (List (Concept Pingu)))
          2)

!(Question (kb)
           (Evaluation (Predicate flies)
                       (List (Concept Sam)))
          2)
