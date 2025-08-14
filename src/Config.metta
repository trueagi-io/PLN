;Default params unless value is passed to PLN.Query/PLN.Derive

;How many derivation steps (task selections)
(= (PLN.Config.MaxSteps) 20)

;Size of active tasks PQ
(= (PLN.Config.TaskQueueSize) 50)

;Max beliefs buffer size
(= (PLN.Config.BeliefQueueSize) 400)
