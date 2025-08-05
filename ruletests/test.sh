#borrow PLN.py:
cp ../examples/PLN.py ./

echo "transitiveSimilarity.metta:"
metta transitiveSimilarity.metta | grep "Passed:"

echo "evaluationWithNegationAndInheritanceInversion.metta:"
metta evaluationWithNegationAndInheritanceInversion.metta | grep "Passed:"

echo "equivalenceToImplication.metta:"
metta equivalenceToImplication.metta | grep "Passed:"

echo "evaluationImplicationRuleA.metta:"
metta evaluationImplicationRuleA.metta | grep "Passed:"

echo "inversion.metta:"
metta inversion.metta | grep "Passed:"

echo "memberDeductionA.metta:"
metta memberDeductionA.metta | grep "Passed:"

echo "RuleTester.metta:"
metta RuleTester.metta | grep "Passed:"

#remove borrowed PLN.py:
rm PLN.py
