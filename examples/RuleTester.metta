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

;negation

!(Question (kb)
           (Not (Inheritance (Concept Sam)
                             (Concept Raven)))
          1)

!(Question (kb)
           (Inheritance (Concept Penguin)
                        (Concept Car))
          1)

;Inversion
!(Question (kb)
           (Inheritance (Concept Raven)
                        (Concept Sam))
          1)


;Equivalence to implication
!(Question (kb)
           (Implication Thunder
                        Donner)
          1)

;And intro
!(Question (kb)
           (Implication (And A B)
                        C)
          1)

;Or intro
!(Question (kb)
           (Implication (Or A B)
                        C)
          1)

;inheritance to member link
!(Question (kb)
           (Member (Concept Sam)
                   (Concept Raven))
          1)
