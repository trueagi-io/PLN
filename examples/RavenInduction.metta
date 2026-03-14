!(import! &self (library lib_patrick))
!(import! &self (library lib_pln))

(= (STV rv1) (stv 0.25 0.9))
(= (STV rv2) (stv 0.25 0.9))
(= (STV raven) (stv 0.25 0.9))
(= (STV (IntSet black)) (stv 0.25 0.9))

(= (kb)
   ((Sentence ((Inheritance rv1 raven) (stv 0.9 0.9)) (1))
    (Sentence ((Inheritance rv2 raven) (stv 0.9 0.9)) (2))
    (Sentence ((Inheritance rv1 (IntSet black)) (stv 0.8 0.9)) (3))
    (Sentence ((Inheritance rv2 (IntSet black)) (stv 0.0 0.9)) (4))
   ))

!(let ($tasks $beliefs) (PLN.Derive (kb) (kb))
      (for $belief $beliefs
           (add-atom &beliefs $belief)))

!(PLN.Derive (cons (Sentence ((Inheritance rv1 raven) (stv 1.0 0.9)) (5)) 
                   (get-atoms &beliefs))
             (get-atoms &beliefs))

;!(PLN.Query (kb) (Inheritance raven (IntSet black)))
