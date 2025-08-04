#borrow PLN.py
cp ../examples/PLN.py ./
echo "transitiveSimilarity.metta:"
metta transitiveSimilarity.metta | grep "Passed:"
echo "evaluationWithNegationAndInheritanceInversion.metta:"
metta evaluationWithNegationAndInheritanceInversion.metta | grep "Passed:"

#remove borrowed PLN.py
rm PLN.py
