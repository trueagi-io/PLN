;1. Set up PLN reasoning context
!(import! &self PLN)

;2. Init PLN reasoner
!(PLN.Init ((sentence (Thunder (stv 0.142 1.0)) (0))
            (sentence (Donner (stv 0.142 1.0)) (0))
            (sentence (A (stv 0.142 1.0)) (0))
            (sentence (B (stv 0.142 1.0)) (0))
            (sentence (C (stv 0.142 1.0)) (0))
            (sentence ((Concept Sam) (stv 0.142 1.0)) (0))
            (sentence ((Concept Raven) (stv 0.142 1.0)) (0))))

;3. Query PLN
(= (kb) (;Sam is a raven
         (sentence ((Inheritance (Concept Sam)
                                 (Concept Raven)) (stv 0.99 0.9)) (1))
         ;Thunder and Donner are equivalent
         (sentence ((Equivalence Thunder
                                 Donner) (stv 0.99 0.9)) (2))
         ;A implies C
         (sentence ((Implication A
                                 C) (stv 0.3 0.9)) (3))
         ;B implies C
         (sentence ((Implication B
                                 C) (stv 0.6 0.9)) (4))
         ;Penguins are not cars
         (sentence ((Not (Inheritance (Concept Penguin)
                                      (Concept Car))) (stv 0.99 0.9)) (5))))

!(Test (PLN.Query (kb) ;Are penguins not cars
                  (Inheritance (Concept Penguin)
                               (Concept Car)) 2)
       ((stv 0.01 0.9) (5)))

;Inversion
!(Test (PLN.Query (kb) ;Is Raven a Sam
                  (Inheritance (Concept Raven)
                               (Concept Sam)) 2)
       ((stv 0.99 0.54) (1)))

;Equivalence to implication
!(Test (PLN.Query (kb) ;Does Thunder imply Donner
                  (Implication Thunder
                               Donner) 5)
       ((stv 0.994974874371859 0.9) (2)))
