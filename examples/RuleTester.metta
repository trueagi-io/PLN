(= (STV Thunder)
   (stv 0.2 0.9))

(= (STV Donner)
   (stv 0.2 0.9))

(= (STV A)
   (stv 0.2 0.9))

(= (STV B)
   (stv 0.2 0.9))

(= (STV C)
   (stv 0.2 0.9))

(= (kb)
   (
    (Sentence ((Inheritance (Concept Sam)
                            (Concept Raven))
               (stv 0.99 0.9)) (1))

    (Sentence ((Equivalence Thunder
                            Donner)
               (stv 0.99 0.9)) (2))
    
    (Sentence ((Implication A
                            C)
               (stv 0.3 0.9)) (3))
    
    (Sentence ((Implication B
                            C)
               (stv 0.6 0.9)) (4))
    
    (Sentence ((Not (Inheritance (Concept Penguin)
                                 (Concept Car)))
               (stv 0.99 0.9)) (5))
   ))


!(setup)

!(runInferenceAndStoreConclusions (kb) 1)



;negation

!(Question
           (Not (Inheritance (Concept Sam)
                             (Concept Raven)))
          )

!(Question
           (Inheritance (Concept Penguin)
                        (Concept Car))
          )

;Inversion
!(Question
           (Inheritance (Concept Raven)
                        (Concept Sam))
          )


;Equivalence to implication
!(Question
           (Implication Thunder
                        Donner)
          )

;And intro
!(Question
           (Implication (And A B)
                        C)
          )

;Or intro
!(Question
           (Implication (Or A B)
                        C)
          )

;inheritance to member link
!(Question
           (Member (Concept Sam)
                   (Concept Raven))
          )
