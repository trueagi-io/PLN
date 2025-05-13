;; INFERENCE RULES

;Revision
(= (|- ($T $T1) 
       ($T $T2))
       ($T (Truth_Revision $T1 $T2)))

;Modus Ponens
(= (|- ($A $T1) 
       ((Implication $A $B) $T2))
   ($B (Truth_ModusPonens $T1 $T2)))

;Deduction
(= (|- ((Inheritance (Concept $A) (Concept $B)) $T1) 
       ((Inheritance (Concept $B) (Concept $C)) $T2))
       ((Inheritance $A $C) 
        (Truth_Deduction (STV $A) 
                         (STV $B)
                         (STV $C) $T1 $T2)))

;Induction
(= (|- ((Inheritance (Concept $C) 
                     (Concept $A)) $T1)
       ((Inheritance (Concept $C) 
                     (Concept $B)) $T2))
       ((Inheritance $A 
                     $B) (Truth_Induction (STV $A) 
                                          (STV $B)
                                          (STV $C) $T1 $T2)))
;Abduction
(= (|- ((Inheritance (Concept $A) (Concept $C)) $T1)
       ((Inheritance (Concept $B) (Concept $C)) $T2))
       ((Inheritance $A $B)
        (Truth_Abduction (STV $A) (STV $B) (STV $C) $T1 $T2)))


;Usage of inheritance for predicates
;unary arg
(= (|- ((Evaluation (Predicate $x)
                    (List (Concept $C))) $T1)
       ((Inheritance (Concept $S) (Concept $C)) $T2))
       ((Evaluation (Predicate $x)
                    (List (Concept $S))) (Truth_ModusPonens $T1 $T2)))

;binary arg1
(= (|- ((Evaluation (Predicate $x)
                    (List (Concept $C1) (Concept $C2))) $T1)
       ((Inheritance (Concept $S) (Concept $C1)) $T2))
       ((Evaluation (Predicate $x)
                    (List (Concept $S) (Concept $C2))) (Truth_ModusPonens $T1 $T2)))

;binary arg2
(= (|- ((Evaluation (Predicate $x)
                    (List (Concept $C1) (Concept $C2))) $T1)
       ((Inheritance (Concept $S) (Concept $C2)) $T2))
       ((Evaluation (Predicate $x)
                    (List (Concept $C1) (Concept $S))) (Truth_ModusPonens $T1 $T2)))



; negation introduction
; takes only unary
(= (|- ($x $t)
       ; CONTROL : don't derive if it is already a NotLink
       (If (Not (Same $x (NotLink $_)))
              ((NotLink $x) (Truth_negationIntroduction $t))
       )
))
