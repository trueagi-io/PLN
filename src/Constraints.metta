; Consistency Conditions: PLN book "5.2.2.2 PLN Deduction and Second-Order Probability", page 74:
; borrowed from https://github.com/trueagi-io/hyperon-pln/blob/main/metta/pln/dependent-types/DeductionDTL.metta
(: smallest-intersection-probability (-> Number Number Number))
(= (smallest-intersection-probability $As $Bs)
   (clamp (/ (- (+ $As $Bs) 1) $As) 0 1))

(: largest-intersection-probability (-> Number Number Number))
(= (largest-intersection-probability $As $Bs)
   (clamp (/ $Bs $As) 0 1))

(: conditional-probability-consistency (-> Number Number Number Bool))
(= (conditional-probability-consistency $As $Bs $ABs)
   (and (< 0 $As)
        (and (<= (smallest-intersection-probability $As $Bs) $ABs)
             (<= $ABs (largest-intersection-probability $As $Bs)))))

(= (Consistency_ImplicationImplicantConjunction $As $Bs $Cs $ACs $BCs)
   ; Conditional probability consistency checks:
   ; P(C|A) <= P(C)/P(A)  =>  $sAC <= $sC / $sA
   ; P(C|B) <= P(C)/P(B)  =>  $sBC <= $sC / $sB
   ; Also ensure denominators are not zero for the checks.
   (and5 (> $As 0) (> $Bs 0) (> $Cs 0) ; Avoid division by zero and ensure meaningful probabilities
         (<= $ACs (/ $Cs $As))
         (<= $BCs (/ $Cs $Bs))))
