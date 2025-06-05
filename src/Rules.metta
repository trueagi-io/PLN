;; INFERENCE RULES

;Revision
(= (|- ($T $T1) 
       ($T $T2))
       ($T (Truth_Revision $T1 $T2)))

;Modus Ponens
(= (|- ($A $T1) 
       ((Implication $A $B) $T2))
   ($B (Truth_ModusPonens $T1 $T2)))

; guard to only allow inference for certain link types
(= (SymmetricModusPonensRuleGuard Similarity) True)
(= (SymmetricModusPonensRuleGuard IntentionalSimilarity) True)
(= (SymmetricModusPonensRuleGuard ExtensionalSimilarity) True)

; SymmetricModusPonens rule, see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/symmetric-modus-ponens.scm
(= (|- ($A $TruthA)
       (($LinkType $A $B) $TruthAB))
   (if (SymmetricModusPonensRuleGuard $LinkType)
      ($B (Truth_SymmetricModusPonens $TruthA $TruthAB))
      (empty)))

; guard to only allow inference for certain link types
(= (SyllogisticRuleGuard Inheritance) True)
(= (SyllogisticRuleGuard Implication) True)
(= (SyllogisticRuleGuard Subset) True)

; Deduction rule, see https://github.com/opencog/pln/blob/master/opencog/pln/rules/term/deduction.scm
(= (|- (($LinkType $A $B) $T1)
       (($LinkType $B $C) $T2))
   (if (SyllogisticRuleGuard $LinkType)
      (($LinkType $A $C)
        (Truth_Deduction (STV $A)
                         (STV $B)
                         (STV $C) $T1 $T2))
      (empty)))
      

; Induction rule, see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/induction.scm
(= (|- (($LinkType $C $A) $T1)
       (($LinkType $C $B) $T2))
   (if (SyllogisticRuleGuard $LinkType)
      (($LinkType $A $B) (Truth_Induction (STV $A)
                                             (STV $B)
                                             (STV $C) $T1 $T2))
      (empty)))

; Abduction rule, see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/abduction.scm
(= (|- (($LinkType $A $C) $T1)
       (($LinkType $B $C) $T2))
   (if (SyllogisticRuleGuard $LinkType)
      (($LinkType $A $B)
        (Truth_Abduction (STV $A)
                         (STV $B)
                         (STV $C) $T1 $T2))
      (empty)))

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

; negation introduction, takes only one premise (is unary)
(= (|- ($x $t))
       (if (not (== $x (Not $_))) ;don't derive if it is already a NotLink
           ((Not $x) (Truth_negationIntroduction $t)) (empty)))

; not elimination rule, see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/not-elimination.scm#L1-L8
(= (|- ((Not $x) $t))
       ($x (Truth_negationElimination $t)))

; Inheritance Inversion Rule, see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/inversion.scm
(= (|- ((Inheritance $A $B) $Truth))
   ((Inheritance $B $A) (Truth_inversion $Truth)))

; Implication Inversion Rule (same)
(= (|- ((Implication $A $B) $Truth))
   ((Implication $B $A) (Truth_inversion $Truth)))

; equivalence to implication rule, see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/equivalence-to-implication.scm
(= (|- ((Equivalence $A $B) $ABTruth))
   ((Implication $A $B) (Truth_equivalenceToImplication (STV $A) (STV $B) $ABTruth)))

; Implication Implicant Conjunction Rule, see https://github.com/opencog/pln/blob/75815f9f21ad899f44eccba1921fa253a7c6216f/opencog/pln/rules/wip/implication-implicant-conjunction.scm
(= (|- ((Implication $A $C) $tvAC)
       ((Implication $B $C) $tvBC))
   (if (not (== $A $B)) ; GuardCondition: A is not identical to B
       ((Implication (And $A $B) $C)
        (Truth_ImplicationImplicantConjunction (STV $A)
                                               (STV $B)
                                               (STV $C) $tvAC $tvBC)) (empty)))

; Implication Implicant Disjunction Rule, see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/implication-implicant-disjunction.scm
(= (|- ((Implication $A $C) $tvAC)
       ((Implication $B $C) $tvBC))
   (if (not (== $A $B)) ; GuardCondition: A is not identical to B
       ((Implication (Or $A $B) $C)
        (Truth_ImplicationImplicantDisjunction (STV $A)
                                               (STV $B)
                                               (STV $C) $tvAC $tvBC)) (empty)))

; Inheritance To Member Rule, see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/inheritance-to-member.scm
(= (|- ((Inheritance $B $C) $Truth))
   ((Member $B $C) (Truth_inheritanceToMember $Truth)))

; Condition Negation Rule, see https://github.com/opencog/pln/blob/master/opencog/pln/rules/term/condition-negation.scm
(= (|- ((Subset $A $B) $ABTruth))
   ((Subset (Not $A) $B) (Truth_ConditionNegation (STV $A) (STV $B) $ABTruth)))

; transitive similarity Rule, see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/transitive-similarity.scm
(= (|- ((Similarity $A $B) $T1)
       ((Similarity $B $C) $T2))
       ((Similarity $A $C)
        (Truth_transitiveSimilarity
                     (STV $A)
                     (STV $B)
                     (STV $C) $T1 $T2)))

; term - Condition Negation Rule, see https://github.com/opencog/pln/blob/master/opencog/pln/rules/term/condition-negation.scm
(= (|- ((Subset $A $B) $Truth))
       ((Subset (Not $A) $B) (Truth_conditionNegation (STV $A) (STV $B) $Truth)))

; Equivalence to Implication Rule, see https://github.com/opencog/pln/blob/master/opencog/pln/rules/wip/equivalence-to-implication.scm
(= (|- ((Equivalence $A $B) $Truth))
   ((Implication $A $B) (Truth_equivalenceToImplication (STV $A) (STV $B) $Truth)))

(= (|- ((Equivalence $A $B) $Truth))
   ((Implication $B $A) (Truth_equivalenceToImplication (STV $A) (STV $B) $Truth)))

; extensional - Member deduction rule, see https://github.com/opencog/pln/blob/master/opencog/pln/rules/extensional/member-deduction.scm
; we are using the truth of deduction here
(= (|- ((Member $A $B) $T1)
       ((Inheritance $B $C) $T2))
       ((Member $A $C)
        (Truth_Deduction (STV $A)
                         (STV $B)
                         (STV $C) $T1 $T2)))
