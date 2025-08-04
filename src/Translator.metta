(= (sentence ((Implication ($LinkType1 $1 $11) ($LinkType2 $2 $22)) $TV) $Y)
   (if (not (== $LinkType2 Implication))
       (trace! (= (|- (($LinkType1 $1 $11) $TV1))
                  (($LinkType2 $2 $22) (Truth_ModusPonens $TV1 $TV)))
                  "PLN.Init: Translated implication into function")
       (empty)))

(= (sentence ((Implication ($LinkType1 $1 $11)
                          (Implication ($LinkType2 $2 $22)
                                      ($LinkType3 $3 $33))) $TV) $Y)
   (trace! (= (|- (($LinkType1 $1 $11) $TV1)
                          (($LinkType2 $2 $22) $TV2))
                      (($LinkType3 $3 $33) (Truth_ModusPonens (Truth_ModusPonens $TV1 $TV2) $TV)))
                      "PLN.Init: Translated nested implication into function"))

(= (sentence ($C $TV) $Y)
   (if (== () (collapse (superpose ((let (Implication $A $B) $C 42))))) ;not an implication?
       (trace! (= (STV $C) $TV)
               "PLN.Init: Translated concept into function")
       (empty)))


