(= (STV (Concept Anna))
   (stv 0.1667 0.9))

(= (STV (Concept Bob))
   (stv 0.1667 0.9))

(= (STV (Concept Edward))
   (stv 0.1667 0.9))

(= (STV (Concept Frank))
   (stv 0.1667 0.9))

(= (STV (Concept Gary))
   (stv 0.1667 0.9))

(= (STV (Concept Helen))
   (stv 0.1667 0.9))

(= (kb)
   (
            (Sentence ((Implication (Evaluation (Predicate friend) 
                                                (List $1 $2))
                                    (Implication (Evaluation (Predicate smokes) 
                                                             (List $1)) 
                                                 (Evaluation (Predicate smokes)
                                                             (List $2))))
                       (stv 0.4 0.9)) (1))

            (Sentence ((Implication (Evaluation (Predicate smokes)
                                                (List $1)) 
                                    (Evaluation (Predicate cancerous) (List $1))) 
                       (stv 0.6 0.9)) (2))

            (Sentence ((Evaluation (Predicate friend) 
                                   (List (Concept Anna) 
                                         (Concept Bob))) 
                       (stv 1.0 0.9)) (3))

            (Sentence ((Evaluation (Predicate friend) 
                                   (List (Concept Anna) 
                                         (Concept Edward)))
                       (stv 1.0 0.9)) (4))

            (Sentence ((Evaluation (Predicate friend) 
                                   (List (Concept Anna)
                                         (Concept Frank)))
                       (stv 1.0 0.9)) (5))

            (Sentence ((Evaluation (Predicate friend)
                                   (List (Concept Edward)
                                         (Concept Frank)))
                       (stv 1.0 0.9)) (6))

            (Sentence ((Evaluation (Predicate friend)
                                   (List (Concept Gary)
                                         (Concept Helen)))
                       (stv 1.0 0.9)) (7))

            (Sentence ((Evaluation (Predicate friend)
                                   (List (Concept Gary) 
                                         (Concept Frank)))
                       (stv 0.0 0.9)) (8))

            (Sentence ((Evaluation (Predicate smokes)
                                   (List (Concept Anna)))
                       (stv 1.0 0.9)) (9))

            (Sentence ((Evaluation (Predicate smokes) 
                                   (List (Concept Edward)))
                       (stv 1.0 0.9)) (10))
   )
)


!(setup)

!(runInferenceAndStoreConclusions (kb) 3)


!(Question 

           (Evaluation (Predicate cancerous)
                       (List (Concept Edward)))
           )
