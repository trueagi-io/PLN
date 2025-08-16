(= (buildlink $Y $Premise1Fn $Premise3Fn $ResultFn $Link1 $Link3 $Link4 $TV1 $TV3 $TVImp)
   (trace! (superpose ((= (|-s ($Link1 $TV1) ($Link3 $TV3))
                          ($Link4 ($ResultFn (Truth_Deduction (Truth_Deduction ($Premise1Fn $TV1) ($Premise3Fn $TV3)) $TVImp)) ())) ;no stamp overlap in imp deduction
                       (= (|-s ($Link4 $TV4))
                          ($Link1 ($Premise1Fn (Truth_Abduction $TVImp ($ResultFn $TV4))) $Y))
                       (= (|-s ($Link4 $TV4))
                          ($Link3 ($Premise3Fn (Truth_Abduction $TVImp ($ResultFn $TV4)) $TVImp) $Y))))
           "PLN.Init: Translated nested implication into function"))

(= (buildlink $Y $Premise1Fn $ResultFn $Link1 $Link2 $TV1 $TVImp)
   (trace! (superpose ((= (|-s ($Link1 $TV1))
                          ($Link2 ($ResultFn (Truth_Deduction ($Premise1Fn $TV1) $TVImp)) ())) ;no stamp overlap in imp deduction
                       (= (|-s ($Link2 $TV1))
                          ($Link1 ($Premise1Fn (Truth_Abduction $TVImp ($Premise1Fn $TV1))) $Y))))
           "PLN.Init: Translated implication into function"))

(= (sentence ((Implication $Link1 $Link2) $TV) $Y)
   (case $Link2
         (((Implication $Link3 $Link4)
           (case $Link1
                 (((Not $Link1c) (case $Link3
                                       (((Not $Link3c) (case $Link4
                                                             (((Not $Link4c) (buildlink $Y Truth_Negation Truth_Negation Truth_Negation $Link1c $Link3c $Link4c $TV1 $TV3 $TV))
                                                               ($Link4c      (buildlink $Y Truth_Negation Truth_Negation Truth_Identity $Link1c $Link3c $Link4c $TV1 $TV3 $TV)))))
                                         ($Link3c      (case $Link4
                                                             (((Not $Link4c) (buildlink $Y Truth_Negation Truth_Identity Truth_Negation $Link1c $Link3c $Link4c $TV1 $TV3 $TV))
                                                               ($Link4c      (buildlink $Y Truth_Negation Truth_Identity Truth_Identity $Link1c $Link3c $Link4c $TV1 $TV3 $TV))))))))
                   ($Link1c       (case $Link3
                                       (((Not $Link3c) (case $Link4
                                                             (((Not $Link4c) (buildlink $Y Truth_Identity Truth_Negation Truth_Negation $Link1c $Link3c $Link4c $TV1 $TV3 $TV))
                                                               ($Link4c      (buildlink $Y Truth_Identity Truth_Negation Truth_Identity $Link1c $Link3c $Link4c $TV1 $TV3 $TV)))))
                                         ($Link3c      (case $Link4
                                                             (((Not $Link4c) (buildlink $Y Truth_Identity Truth_Identity Truth_Negation $Link1c $Link3c $Link4c $TV1 $TV3 $TV))
                                                               ($Link4c      (buildlink $Y Truth_Identity Truth_Identity Truth_Identity $Link1c $Link3c $Link4c $TV1 $TV3 $TV)))))))))))
          ($Else
           (case $Link1
                 (((Not $Link1c) (case $Link2
                                       (((Not $Link2c) (buildlink $Y Truth_Negation Truth_Negation $Link1c $Link2c $TV1 $TV))
                                       ($Link2c        (buildlink $Y Truth_Negation Truth_Identity $Link1c $Link2c $TV1 $TV)))))
                  ($Link1c       (case $Link2
                                       (((Not $Link2c) (buildlink $Y Truth_Identity Truth_Negation $Link1c $Link2c $TV1 $TV))
                                         ($Link2c      (buildlink $Y Truth_Identity Truth_Identity $Link1c $Link2c $TV1 $TV)))))))))))
