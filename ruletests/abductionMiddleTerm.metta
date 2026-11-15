; manual test for the Abduction Rule
;
; important is that the shared right-side term of the two premises is passed
; to the truth function as the middle term: two things that are both cars are
; not thereby one another with a strength above 1

!(import! &self (library lib_import))
!(git-import! "https://github.com/trueagi-io/PLN.git")
!(import! &self (library PLN lib_pln))

;1. Set up PLN reasoning context
(= (STV (Concept Car1)) (stv 0.5 1.0))
(= (STV (Concept Car2)) (stv 0.5 1.0))
(= (STV (Concept Car)) (stv 0.93 1.0))

;2. Query PLN
!(test (PLN.Query ((Sentence ((Inheritance (Concept Car1)
                                           (Concept Car)) (stv 0.93 0.9)) (1))
                   (Sentence ((Inheritance (Concept Car2)
                                           (Concept Car)) (stv 0.93 0.9)) (2)))
                  (Inheritance (Concept Car1)
                               (Concept Car2)) 1)
       ((stv 0.5 0.4296469514629556) (1 2)))
