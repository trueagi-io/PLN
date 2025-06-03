(= (STV (Concept Sam))
   (stv 0.2 0.9))

(= (STV (Concept Pingu))
   (stv 0.2 0.9))

(= (STV (Concept Penguin))
   (stv 0.2 0.9))

(= (STV (Concept Raven))
   (stv 0.2 0.9))

(= (STV (Concept Bird))
   (stv 0.2 0.9))

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

!(setup)

!(runInferenceAndStoreConclusions (kb) 2)


!(Question
           (Evaluation (Predicate flies)
                       (List (Concept Pingu))))

!(Question
           (Evaluation (Predicate flies)
                       (List (Concept Sam))))



