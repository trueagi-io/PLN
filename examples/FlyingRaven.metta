!(import! &self (library lib_import))
!(git-import! "https://github.com/trueagi-io/PLN.git")
!(import! &self (library PLN lib_pln))

(= (STV Sam) (stv 0.16 0.9))
(= (STV Pingu) (stv 0.16 0.9))
(= (STV Penguin) (stv 0.16 0.9))
(= (STV Raven) (stv 0.16 0.9))
(= (STV Bird) (stv 0.16 0.9))
(= (STV (IntSet flies)) (stv 0.16 0.9))

(= (kb)
   ((Sentence ((Inheritance Sam
                            Raven)
               (stv 0.99 0.9)) (1))
    
    (Sentence ((Inheritance Pingu
                            Penguin)
               (stv 0.99 0.9)) (2))
    
    (Sentence ((Inheritance Penguin
                            (IntSet flies))
               (stv 0.01 0.9)) (3))

    (Sentence ((Inheritance Raven
                            Bird)
               (stv 0.99 0.9)) (4))
    
    (Sentence ((Inheritance Penguin
                            Bird)
               (stv 0.99 0.9)) (5))

    (Sentence ((Inheritance Bird
                            (IntSet flies))
               (stv 0.99 0.9)) (6))))

!(test (PLN.Query (kb)
                  (Inheritance Sam
                               (IntSet flies)))
       ((stv 0.9703557256235827 0.9) (1 4 6)))


!(test (PLN.Query (kb)
                  (Inheritance Pingu
                               (IntSet flies)))
       ((stv 0.011785714285714288 0.9) (2 3)))

