#Use your favorite MeTTa interpreter:
if [ -z "$2" ]; then
    echo "Argument 2 has to be hyperon or wam"
    exit 1
fi
export HyperonMeTTa="python3 $HOME/hyperon-experimental/python/hyperon/metta.py"
export BoostedMeTTa="$HOME/metta-wam/mettalog"
export METTA=$HyperonMeTTa
if [ "$2" = "wam" ]; then
    export METTA=$BoostedMeTTa
fi
#Ok let's build the MeTTa file with the example code added:
sh build.sh
cat PLN.metta $1 > RUN.metta
#Done, let's run it:
$METTA RUN.metta
