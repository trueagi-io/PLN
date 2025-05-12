#Use your favorite MeTTa interpreter:
export METTA=$HOME/metta-wam/mettalog
#Ok let's build the MeTTa file with the example code added:
cd src
sh build.sh > ../RUN.metta
cd ..
cat $1 >> RUN.metta
#Done, let's run it:
$METTA RUN.metta
