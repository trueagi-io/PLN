!(import! &self (library lib_import))
!(git-import! "https://github.com/trueagi-io/PLN.git")
!(import! &self (library PLN lib_pln))

;1. Set up PLN reasoning context
(= (STV Thunder) (stv 0.142 1.0))
(= (STV Donner) (stv 0.142 1.0))
(= (STV A) (stv 0.142 1.0))
(= (STV B) (stv 0.142 1.0))
(= (STV C) (stv 0.142 1.0))
(= (STV Sam) (stv 0.142 1.0))
(= (STV Raven) (stv 0.142 1.0))
(= (STV Penguin) (stv 0.142 1.0))
(= (STV Car) (stv 0.142 1.0))

;2. Query PLN
(= (kb) (;Sam is a raven
         (Sentence ((Inheritance Sam
                                 Raven) (stv 0.99 0.9)) (1))
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
         (Sentence ((Not (Inheritance Penguin
                                      Car)) (stv 0.99 0.9)) (5))))

!(test (PLN.Query (kb) ;Are penguins not cars
                  (Inheritance Penguin
                               Car) 5)
       ((stv 0.010000000000000009 0.9) (5)))

;Inversion
!(test (PLN.Query (kb) ;Is Raven a Sam
                  (Inheritance Raven
                               Sam) 2)
       ((stv 0.99 0.54) (1)))

;Equivalence to implication
!(test (PLN.Query (kb) ;Does Thunder imply Donner
                  (Implication Thunder
                               Donner) 5)
       ((stv 0.9949748743718593 0.9) (2)))
