;; INFERENCE RULES

;Revision
(= (|- ($T $T1) 
       ($T $T2))
       ($T (Truth_Revision $T1 $T2)))

;Modus Ponens
(= (|-FoI ($A $T1) 
       ((Implication $A $B) $T2))
   ($B (Truth_ModusPonens $T1 $T2)))

; guard to only allow inference for certain link types
(= (SymmetricModusPonensRuleGuard Similarity) True)
(= (SymmetricModusPonensRuleGuard IntentionalSimilarity) True)
(= (SymmetricModusPonensRuleGuard ExtensionalSimilarity) True)

; SymmetricModusPonens rule   see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/symmetric-modus-ponens.scm
(= (|-FoI ($A $TruthA)
       (($LinkType $A $B) $TruthAB))
   (if (SymmetricModusPonensRuleGuard $LinkType)
      ($B (Truth_SymmetricModusPonens $TruthA $TruthAB))
      ()))

;Deduction
(= (|-FoI ((Inheritance (Concept $A)
                     (Concept $B)) $T1)
       ((Inheritance (Concept $B)
                     (Concept $C)) $T2))
       ((Inheritance (Concept $A)
                     (Concept $C))
        (Truth_Deduction (STV (Concept $A))
                         (STV (Concept $B))
                         (STV (Concept $C)) $T1 $T2)))

;Induction
(= (|-FoI ((Inheritance (Concept $C)
                     (Concept $A)) $T1)
       ((Inheritance (Concept $C)
                     (Concept $B)) $T2))
       ((Inheritance (Concept $A)
                     (Concept $B)) (Truth_Induction (STV (Concept $A))
                                                    (STV (Concept $B))
                                                    (STV (Concept $C)) $T1 $T2)))
;Abduction
(= (|-FoI ((Inheritance (Concept $A) (Concept $C)) $T1)
       ((Inheritance (Concept $B) (Concept $C)) $T2))
       ((Inheritance (Concept $A) (Concept $B))
        (Truth_Abduction (STV (Concept $A))
                         (STV (Concept $B))
                         (STV (Concept $C)) $T1 $T2)))


;Usage of inheritance for predicates
;unary arg
(= (|-FoI ((Evaluation (Predicate $x)
                    (List (Concept $C))) $T1)
       ((Inheritance (Concept $S) (Concept $C)) $T2))
       ((Evaluation (Predicate $x)
                    (List (Concept $S))) (Truth_ModusPonens $T1 $T2)))

;binary arg1
(= (|-FoI ((Evaluation (Predicate $x)
                    (List (Concept $C1) (Concept $C2))) $T1)
       ((Inheritance (Concept $S) (Concept $C1)) $T2))
       ((Evaluation (Predicate $x)
                    (List (Concept $S) (Concept $C2))) (Truth_ModusPonens $T1 $T2)))

;binary arg2
(= (|-FoI ((Evaluation (Predicate $x)
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






; higher-order inferences for left side of term with common right side of term
; first item of argument tuple is the guard for which Link-Type to allow this inference

; example:
;
; Inheritance
;    A
;    R
; ,
; Inheritance
;    B
;    R
; |-
; Inheritance
;    AndLink
;       A
;       B
;    R
;
; see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/and-introduction.scm
; see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/and-as-1st-arg-inside-inheritance-link.scm
(= (InfHoILeftside Inheritance ($ATerm $ATruth) ($BTerm $BTruth))
   ((AndLink $ATerm $BTerm) (Truth_AndIntroduction $ATruth $BTruth))
)

; see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/or-introduction.scm
; see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/implication-implicant-disjunction.scm
(= (InfHoILeftside Implication ($ATerm $ATruth) ($BTerm $BTruth))
   ((OrLink $ATerm $BTerm) (Truth_OrIntroduction $ATruth $BTruth))
)

; see https://github.com/opencog/pln/blob/master/opencog/pln/rules/propositional/fuzzy-conjunction-introduction.scm
; ?   should this be on leftside or rightside?
(= (InfHoILeftside Inheritance ($ATerm $ATruth) ($BTerm $BTruth))
   ((AndLink $ATerm $BTerm) (Truth_FuzzyConjunctionIntroduction $ATruth $BTruth))
)

; see https://github.com/opencog/pln/blob/master/opencog/pln/rules/propositional/fuzzy-disjunction-introduction.scm
; ?   should this be on leftside or rightside?
(= (InfHoILeftside Inheritance ($ATerm $ATruth) ($BTerm $BTruth))
   ((OrLink $ATerm $BTerm) (Truth_FuzzyDisjunctionIntroduction $ATruth $BTruth))
)



; try to apply possible higher-order rules for leftside of both premises
(= (|-HoI (($LinkType $TermALeft $TermCommonRight) $TruthA) (($LinkType $TermBLeft $TermCommonRight) $TruthB))
   ; try to apply to left side
   (let* (($LeftConcl  (InfHoILeftside $LinkType ($TermALeft $TruthA) ($TermBLeft $TruthB)))
          ($TermLeftConcl  (getTerm $LeftConcl))
          ($TruthConcl  (getTruth $LeftConcl)))
      (($LinkType $TermLeftConcl $TermCommonRight) $TruthConcl)
   )
)


(= (|- $A $B)
   (|-FoI $A $B)
)
(= (|- $A $B)
   (|-HoI $A $B)
)


