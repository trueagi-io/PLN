(= (TupleConcat $Ev1 $Ev2) (collapse (superpose ((superpose $Ev1) (superpose $Ev2)))))

;1. Set up PLN reasoning context
!(import! &self PLN)
;person;bicycle;car;motorbike;aeroplane;bus;train;truck;boat;traffic light;fire hydrant
;stop sign;parking meter;bench;bird;cat;dog;horse;sheep;cow;elephant;bear;zebra;giraffe
;backpack;umbrella;handbag;tie;suitcase;frisbee;skis;snowboard;sports ball;kite;baseball bat
;baseball glove;skateboard;surfboard;tennis racket;bottle;wine glass;cup;fork;knife;spoon;bowl
;banana;apple;sandwich;orange;broccoli;carrot;hot dog;pizza;donut;cake;chair;sofa;pottedplant
;bed;diningtable;toilet;tvmonitor;laptop;mouse;remote;keyboard;cell phone;microwave;oven;toaster
;sink;refrigerator;book;clock;vase;scissors;teddy bear;hair drier;toothbrush;
(= (kbstatic)
   ((sentence ((Concept person) (stv 0.2 0.9)) (0))
    (sentence ((Concept frisbee) (stv 0.2 0.9)) (0))
    (sentence ((Concept sportsball) (stv 0.2 0.9)) (0))
    (sentence ((Concept chair) (stv 0.2 0.9)) (0))
    (sentence ((Concept toy) (stv 0.2 0.9)) (0))
    (sentence ((Implication (Inheritance (Concept $1)
                                         (Concept see))
                            (Implication (Inheritance (Concept $1)
                                                      (Concept toy))
                                         (Inheritance (Concept $1)
                                                      (Concept bring)))) (stv 0.99 0.99)) (3))))
!(PLN.Init (kbstatic))
(= (kbdynamic)
   ((sentence ((Inheritance (Concept frisbee)
                            (Concept toy)) (stv 0.99 0.99)) (10))
    (sentence ((Inheritance (Concept sportsball)
                            (Concept toy)) (stv 0.99 0.99)) (11))))
(= (PLNcategorizeObject $label $category)
   (Question (TupleConcat (kbdynamic)
                          ((sentence ((Inheritance (Concept $label)
                                                   (Concept see)) (stv 0.99 0.99)) (12))))
             (Inheritance (Concept $label)
                          (Concept $category)) 3))

(= (PLNobjectsOfCategoryHelper $objects $category)
   (let (detection $label $coord) (superpose $objects)
        (if (not (== (PLNcategorizeObject $label $category) ()))
            (detection $label $coord)
            (empty))))

(= (PLNobjectsOfCategory $objects $category)
   (let $tuple (collapse (PLNobjectsOfCategoryHelper $objects $category))
        (unique-atom $tuple)))

!(PLNobjectsOfCategory ((detection frisbee someCoords1)
                        (detection {SELF} someCoords2)
                        (detection person someCoords3))
                       bring)
