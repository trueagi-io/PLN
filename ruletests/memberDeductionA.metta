; manual test for Member deduction Rule
; makes use of Inheritance To Member Rule
; makes use of Revision Rule

!(import! &self (library lib_import))
!(git-import! "https://github.com/trueagi-io/PLN.git")
!(import! &self (library PLN lib_pln))

;1. Set up PLN reasoning context
(= (STV (Concept Tom)) (stv 0.333 1.0))
(= (STV (Concept SpeciesA)) (stv 0.333 1.0))
(= (STV (Concept SpeciesCats)) (stv 0.333 1.0))

;2. Query PLN
!(test (PLN.Query (; Tom is a member of SpeciesA
                   ; premise for Member deduction Rule
                   (Sentence ((Member (Concept Tom)
                                      (Concept SpeciesA)) (stv 1.0 1.0)) (1))
                   ; speciesA is a SpeciesCats
                   ; premise for Member deduction Rule
                   (Sentence ((Inheritance (Concept SpeciesA)
                                           (Concept SpeciesCats)) (stv 0.75 0.5)) (2))
                   ; premise for Inheritance To Member Rule
                   (Sentence ((Inheritance (Concept Tom)
                                           (Concept SpeciesCats)) (stv 0.7 0.5)) (3)))
                  ; how much is Tom a cat?
                  (Member (Concept Tom)
                          (Concept SpeciesCats)) 1)
       ((stv 0.75 0.5) (1 2)))
