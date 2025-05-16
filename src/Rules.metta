;; INFERENCE RULES

;Revision
(= (|- ($T $T1) 
       ($T $T2))
       ($T (Truth_Revision $T1 $T2)))

;Modus Ponens
(= (|- ($A $T1) 
       ((Implication $A $B) $T2))
   ($B (Truth_ModusPonens $T1 $T2)))


; SymmetricModusPonens rule   see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/symmetric-modus-ponens.scm
(= (|- ($A $TruthA)
       ((Similarity $A $B) $TruthAB))
   ($B (Truth_SymmetricModusPonens $TruthA $TruthAB)))

; SymmetricModusPonens rule   see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/symmetric-modus-ponens.scm
(= (|- ($A $TruthA)
       ((IntentionalSimilarity $A $B) $TruthAB))
   ($B (Truth_SymmetricModusPonens $TruthA $TruthAB)))

; SymmetricModusPonens rule   see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/symmetric-modus-ponens.scm
(= (|- ($A $TruthA)
       ((ExtensionalSimilarity $A $B) $TruthAB))
   ($B (Truth_SymmetricModusPonens $TruthA $TruthAB)))


;Deduction
(= (|- ((Inheritance (Concept $A) (Concept $B)) $T1)
       ((Inheritance (Concept $B) (Concept $C)) $T2))
       ((Inheritance (Concept $A) (Concept $C))
        (Truth_Deduction (STV (Concept $A))
                         (STV (Concept $B))
                         (STV (Concept $C)) $T1 $T2)))

;Induction
(= (|- ((Inheritance (Concept $C)
                     (Concept $A)) $T1)
       ((Inheritance (Concept $C)
                     (Concept $B)) $T2))
       ((Inheritance (Concept $A)
                     (Concept $B)) (Truth_Induction (STV (Concept $A))
                                                    (STV (Concept $B))
                                                    (STV (Concept $C)) $T1 $T2)))
;Abduction
(= (|- ((Inheritance (Concept $A) (Concept $C)) $T1)
       ((Inheritance (Concept $B) (Concept $C)) $T2))
       ((Inheritance (Concept $A) (Concept $B))
        (Truth_Abduction (STV (Concept $A))
                         (STV (Concept $B))
                         (STV (Concept $C)) $T1 $T2)))


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
; takes only one premise (is unary)
(= (|- ($x $t))
       (if (not (== $x (NotLink $_))) ;don't derive if it is already a NotLink
           ((NotLink $x) (Truth_negationIntroduction $t)) ()))

; not elimination rule
; see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/not-elimination.scm#L1-L8
(= (|- ((NotLink $x) $t))
       ($x (Truth_negationElimination $t)))

