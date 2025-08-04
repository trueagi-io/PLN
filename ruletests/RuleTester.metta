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

(= (kb) (;Sam is a raven
         (Sentence ((Inheritance (Concept Sam)
                                 (Concept Raven)) (stv 0.99 0.9)) (1))
         ;Thunder and Donner are equivalent
         (Sentence ((Equivalence Thunder
                                 Donner) (stv 0.99 0.9)) (2))
         ;A implies C
         (Sentence ((Implication A
                                 C) (stv 0.3 0.9)) (3))
         ;B implies C
         (Sentence ((Implication B
                                 C) (stv 0.6 0.9)) (4))
         ;Penguins are not cars
         (Sentence ((Not (Inheritance (Concept Penguin)
                                      (Concept Car))) (stv 0.99 0.9)) (5))))

;negation
!(PLN.Query (kb) ;Is Sam not a raven
            (Not (Inheritance (Concept Sam)
                              (Concept Raven))) 1)

!(PLN.Query (kb) ;Are penguins not cars
            (Inheritance (Concept Penguin)
                         (Concept Car)) 1)

;Inversion
!(PLN.Query (kb) ;Is Raven a Sam
             (Inheritance (Concept Raven)
                          (Concept Sam)) 1)


;Equivalence to implication
!(PLN.Query (kb) ;Does Thunder imply Donner
            (Implication Thunder
                         Donner) 1)

;And intro
!(Question (kb) ;Does A and B together lead to C?
           (Implication (And A B)
                        C) 1)

;Or intro
!(PLN.Query (kb) ;Does A or B lead to C?
            (Implication (Or A B)
                         C) 1)

;inheritance to member link
!(PLN.Query (kb) ;Is Sam a member of Ravens?
            (Member (Concept Sam)
                    (Concept Raven)) 1)
