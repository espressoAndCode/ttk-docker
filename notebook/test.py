from paraview.simple import *

for sym in dir(paraview.simple):
    if sym.startswith("TTK"):
        print(sym)
