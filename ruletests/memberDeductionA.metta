; manual test for Member deduction Rule
; makes use of Inheritance To Member Rule
; makes use of Revision Rule

(= (STV (Concept Tom))
   (stv 1.0 1.0))

(= (STV (Concept SpeciesA))
   (stv 1.0 1.0))

(= (STV (Concept SpeciesCats))
   (stv 1.0 1.0))


!(Question
   (
      ; Tom is a member of SpeciesA
      ; premise for Member deduction Rule
      (Sentence ((Member (Concept Tom) (Concept SpeciesA)) (stv 1.0 1.0)) (0))

      ; speciesA is a SpeciesCats
      ; premise for Member deduction Rule
      (Sentence ((Inheritance (Concept SpeciesA) (Concept SpeciesCats)) (stv 0.75 0.5)) (1))

      ; premise for Inheritance To Member Rule
      (Sentence ((Inheritance (Concept Tom) (Concept SpeciesCats)) (stv 0.7 0.5)) (2))
   )

   ; how much is Tom a cat?
   (Member (Concept Tom) (Concept SpeciesCats))

   2)
