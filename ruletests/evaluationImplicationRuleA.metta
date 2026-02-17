!(translatePredicate (retractall (Predicate (fun Predicate))))
!(import! &self (library lib_import))
!(git-import! "https://github.com/trueagi-io/PLN.git")
!(import! &self (library PLN lib_pln))

;1. Set up PLN reasoning context
(= (STV (List (Concept Tom))) (stv 0.25 1.0))
(= (STV (List (Concept Cat))) (stv 0.25 1.0))
(= (STV (Predicate IsFat)) (stv 0.25 1.0))
(= (STV (Predicate IsReallyFat)) (stv 0.25 1.0))

;2. Query PLN
!(test (PLN.Query (; Tom is really fat
                   (Sentence ((Evaluation (Predicate IsReallyFat)
                                          (List (Concept Cat))) (stv 1.0 1.0)) (1))
                   ; if something is really fat then it's fat
                   (Sentence ((Implication (Predicate IsReallyFat)
                                           (Predicate IsFat)) (stv 1.0 1.0)) (2))
                   ; premise necessary for application of rule for unary predicate
                   ; Tom is a cat
                   (Sentence ((Inheritance (Concept Tom)
                                           (Concept Cat)) (stv 1.0 1.0)) (3)))
                  ; are cats fat?
                  (Evaluation (Predicate IsFat)
                              (List (Concept Tom))) 10)
       ((stv 1.0 0.7290000000000001) (1 2 3)))
