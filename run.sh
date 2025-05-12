#Use your favorite MeTTa interpreter:
export METTA=$HOME/metta-wam/mettalog
#Ok let's build the MeTTa file with the example code added:
sh build.sh
cat PLN.metta $1 > RUN.metta
#Done, let's run it:
$METTA RUN.metta
