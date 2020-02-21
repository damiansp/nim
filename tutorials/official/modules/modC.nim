# modA: 
# var x*: string
# proc p*(a: string): string = $a

# modB:
# var x*: int
# proc p*(a: int): string = $a

import modA, modB
#write(stdout, x) # error: ambiguous
write(stdout, modA.x) # ok

var x = 4
write(stdout, x) # = C.x

write(stdout, p(3))      # call type matches B.p
write(stdout, p("juju")) # call type matches A.p

proc p*(a: int): string = discard
#wirte(stdout, p(3)) # now ambiguous


# Can in/exclude from imports
#import mymodule except y
#from mymodule import x, y, z
#x() # ok

# from mymodule import nil
#mymodule.x() # ok
#x()          # compile error

# from mymodule as m import nil
#m.x() # ok

# `include` simply includes the contents of a file
#include fileA, fileB, fileC