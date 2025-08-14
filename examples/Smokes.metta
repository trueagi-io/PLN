!(import! &self PLN)

(= (kbstatic)
   ((sentence ((Implication (Inheritance (Product $1 $2) friend)
                            (Implication (Inheritance $1
                                                      (IntSet smokes))
                                         (Inheritance $2
                                                      (IntSet smokes))))
               (stv 0.4 0.9)) (1))
    (sentence ((Implication (Inheritance $1
                                         (IntSet smokes))
                            (Inheritance $1
                                         (IntSet cancerous)))
               (stv 0.6 0.9)) (2))))

;takes 30 sec to compile (no reasoning happening here just preparing a fast PLN reasoner with the concepts and implications engraved)
!(PLN.Init (kbstatic))

(= (kbdynamic)
   ((sentence ((Inheritance (Product Anna Bob)
                            friend) 
               (stv 1.0 0.9)) (3))
    (sentence ((Inheritance (Product Anna Edward)
                            friend)
               (stv 1.0 0.9)) (4))
    (sentence ((Inheritance (Product Anna Frank)
                            friend)
               (stv 1.0 0.9)) (5))
    (sentence ((Inheritance (Product Edward Frank)
                            friend)
               (stv 1.0 0.9)) (6))
    (sentence ((Inheritance (Product Gary Helen)
                            friend)
               (stv 1.0 0.9)) (7))
    (sentence ((Inheritance (Product Gary Frank)
                            friend)
               (stv 0.0 0.9)) (8))
    (sentence ((Inheritance Anna
                            (IntSet smokes))
               (stv 1.0 0.9)) (9))
    (sentence ((Inheritance Edward
                            (IntSet smokes))
               (stv 1.0 0.9)) (10))))

!(Test (PLN.Query (kbdynamic)
                  (Inheritance Edward
                              (IntSet cancerous))
                  ) ;11 2 11) ;uncomment for example-specific minimal resource usage
       ((stv 0.666075051380597 0.531093236569029) (5 6 9 10)))
