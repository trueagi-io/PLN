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

!(test (PLN.Query (kb) (Inheritance raven (IntSet black)))
       ((stv 0.38000000000000006 0.6541049798115747) (1 2 3 4)))
