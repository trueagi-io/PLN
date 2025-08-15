(= (buildlink $Premise1Fn $Premise3Fn $ResultFn $Link1 $Link3 $Link4 $TV1 $TV3 $TVImp)
   (trace! (= (|- ($Link1 $TV1) ($Link3 $TV3))
              ($Link4 ($ResultFn (Truth_ModusPonens (Truth_ModusPonens ($Premise1Fn $TV1) ($Premise3Fn $TV3)) $TVImp))))
           "PLN.Init: Translated nested implication into function"))

(= (buildlink $Premise1Fn $ResultFn $Link1 $Link2 $TV1 $TVImp)
   (trace! (= (|- ($Link1 $TV1))
              ($Link2 ($ResultFn (Truth_ModusPonens ($Premise1Fn $TV1) $TVImp))))
           "PLN.Init: Translated implication into function"))

(= (sentence ((Implication $Link1 $Link2) $TV) $Y)
   (case $Link2
         (((Implication $Link3 $Link4)
           (case $Link1
                 (((Not $Link1c) (case $Link3
                                       (((Not $Link3c) (case $Link4
                                                             (((Not $Link4c) (buildlink Truth_Negation Truth_Negation Truth_Negation $Link1c $Link3c $Link4c $TV1 $TV3 $TV))
                                                               ($Link4c      (buildlink Truth_Negation Truth_Negation Truth_Identity $Link1c $Link3c $Link4c $TV1 $TV3 $TV)))))
                                         ($Link3c      (case $Link4
                                                             (((Not $Link4c) (buildlink Truth_Negation Truth_Identity Truth_Negation $Link1c $Link3c $Link4c $TV1 $TV3 $TV))
                                                               ($Link4c      (buildlink Truth_Negation Truth_Identity Truth_Identity $Link1c $Link3c $Link4c $TV1 $TV3 $TV))))))))
                   ($Link1c       (case $Link3
                                       (((Not $Link3c) (case $Link4
                                                             (((Not $Link4c) (buildlink Truth_Identity Truth_Negation Truth_Negation $Link1c $Link3c $Link4c $TV1 $TV3 $TV))
                                                               ($Link4c      (buildlink Truth_Identity Truth_Negation Truth_Identity $Link1c $Link3c $Link4c $TV1 $TV3 $TV)))))
                                         ($Link3c      (case $Link4
                                                             (((Not $Link4c) (buildlink Truth_Identity Truth_Identity Truth_Negation $Link1c $Link3c $Link4c $TV1 $TV3 $TV))
                                                               ($Link4c      (buildlink Truth_Identity Truth_Identity Truth_Identity $Link1c $Link3c $Link4c $TV1 $TV3 $TV)))))))))))
          ($Else
           (case $Link1
                 (((Not $Link1c) (case $Link2
                                       (((Not $Link2c) (buildlink Truth_Negation Truth_Negation $Link1c $Link2c $TV1 $TV))
                                       ($Link2c        (buildlink Truth_Negation Truth_Identity $Link1c $Link2c $TV1 $TV)))))
                  ($Link1c       (case $Link2
                                       (((Not $Link2c) (buildlink Truth_Identity Truth_Negation $Link1c $Link2c $TV1 $TV))
                                         ($Link2c      (buildlink Truth_Identity Truth_Identity $Link1c $Link2c $TV1 $TV)))))))))))

(= (sentence ($C $TV) $Y)
   (if (== () (collapse (superpose ((let (Implication $A $B) $C 42))))) ;not an implication?
       (trace! (= (STV $C) $TV)
               "PLN.Init: Translated concept into function")
       (empty)))
