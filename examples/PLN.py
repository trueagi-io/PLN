import os
import re
import sys
import json
import shutil
import ctypes
from ctypes import *
from hyperon.ext import register_atoms
from hyperon import *

class PatternOperation(OperationObject):
    def __init__(self, name, op, unwrap=False, rec=False):
        super().__init__(name, op, unwrap)
        self.rec = rec
    def execute(self, *args, res_typ=AtomType.UNDEFINED):
        return super().execute(*args, res_typ=res_typ)

def wrapnpop(func):
    def wrapper(*args):
        a = [str("'"+arg) if arg is SymbolAtom else str(arg) for arg in args]
        res = func(*a)
        return [res]
    return wrapper

def call_plninit(*a):
    global globalmetta
    plnpath = os.path.expanduser("~/PLN")
    mettamorphpath = os.path.expanduser("~/metta-morph")
    tokenizer = globalmetta.tokenizer()
    os.system(f"cd {plnpath} && sh build.sh")
    os.system(f"cp {plnpath}/src/Translator.metta ./TRANSLATE.metta")
    with open("TRANSLATE.metta", "a") as f:
        f.write("!(superpose " + str(a[0]).replace("#","")+")")
    os.system("cat ../PLN.metta > TRANSLATED.metta")
    os.system("metta TRANSLATE.metta 2>> TRANSLATED.metta")
    with open("TRANSLATED.metta", "r") as f1:
        content = f1.read()
        content = re.sub(r'\$([A-Za-z0-9]+)#([0-9]+)', r'$\1\2', content) #removes # in variable names
    with open("TRANSLATED.metta", "w") as f2:
        f2.write(content)
    name = "plnblob.metta"
    if len(sys.argv) > 1:
        name = sys.argv[1]
    os.system(f"cmp -s TRANSLATED.metta {mettamorphpath}/extend/{name} || cp TRANSLATED.metta {mettamorphpath}/extend/{name}")
    os.system("rm TRANSLATE.metta TRANSLATED.metta")
    cwd = os.getcwd()
    os.chdir(f'{mettamorphpath}/extend/')
    sys.path.append(os.getcwd())
    globalmetta.run("!(import! &self mettamorph)")
    globalmetta.run(f'!(compile! {name})')
    globalmetta.run("(= (sentence $A $B) (Sentence $A $B))")
    os.chdir(cwd)
    parser = SExprParser(f"(PLN.Init.Success)")
    return parser.parse(tokenizer)


globalmetta = None
@register_atoms(pass_metta=True)
def scheme_atoms(metta):
    global globalmetta
    globalmetta = metta
    call_PLNInit_atom = G(PatternOperation('PLN.Init', wrapnpop(call_plninit), unwrap=False))
    return { r"PLN.Init": call_PLNInit_atom }
