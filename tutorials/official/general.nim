#---------#---------#---------#---------#---------#---------#---------#---------
var x, y: int
var
  x2, y2: int
  # a comment
  a, b, c : string


# Assignment
var x3 = "abc"
x3 = "xyz"

var x4, y3 = 3 # both equal 3
echo "x4 ", x4
echo "y3 ", y3
x4 = 42
echo "x4 ", x4 # 42
echo "y3 ", y3   # still 3


# Constants
const xxx = "abc"
const
  x5 = 1
  # a comment here is a-ok
  y4 = 2
  z = y4 + 5


# Let
let a2 = "abc"
#a2 = "xyz"  # illegal; a already assigned

#const input = readLines(stdin) # Err: const expression expected
let input = readLine(stdin)     # ok



# Control Flow


# if
echo "Name? "
let name = readLine(stdin)
if name == "":
  echo "Poor soul, lost your name?"
elif name == "name":
  echo "Funny name, name!"
else:
  echo "Hi, ", name, "!"


# case
case name
of "":
  echo "Poor nameless soul!"
of "name":
  echo "Funny name, name!"
of "Bob", "Dave", "Frank":
  echo "Solid name, chap!"
else:
  echo "Hi, ", name, "!"

from strutils import parseInt

echo "A number please: "
let n = parseInt(readLine(stdin))
case n
of 0..2, 4..7:
  echo "n in {0, 1, 2, 4, 5, 6, 7}"
of 3, 8:
  echo "n in {3, 8}"
else:
  discard # do nothing


# while
echo "What is your name? "
var yourName = readLine(stdin)
while yourName == "":
  echo "Your name, please: "
  yourName = readLine(stdin)


# for
echo "Counting to 10..."
for i in countup(1, 10):
  echo i

var i = 1
while i <= 10:
  echo i
  inc(i)

echo "Counting down from 10..."
for i in countdown(10, 1):
  echo i

for i in 1..10:
  echo i

for i in 0..<10:
  echo i

var s = "some string"
for i in 0..<s.len:
  echo s[i]

for i, item in ["a", "b"].pairs: # = python enumberate(['a', 'b'])
  echo item, " at index ", i

block myblock:
  echo "entering block"
  while true:
    echo "looping..."
    break
  echo "still in block"

block myblock2:
  echo "entering 2nd block"
  while true:
    echo "looping...."
    break myblock2
  echo "This should be unreachable"

# When: 
echo "Running on... "
when system.hostOS == "windows":
  echo "...Winders"
elif system.hostOS == "linux":
  echo "...Linnix"
elif system.hostOS == "macosx":
  echo "...Osux"
else:
  echo "...Ida know"


# Procedures (functions)
proc yes(question: string): bool =
  echo question, "(y/n)"
  while true:
    case readLine(stdin)
    of "y", "Y", "yes", "Yes", "YES": return true
    of "n", "N", "no", "No", "NO": return false
    else: echo "Please be clear: yes or no?"

if yes("Should I delete all your files?"):
  echo "I'm sorry Dave, I'm afraid I can't do that."
else:
  echo "I think you know what the problem is just as well as I do"


# Result
proc sumTillNegative(x: varargs[int]): int =
  for i in x:
    if i < 0:
      return
    result = result + i

echo sumTillNegative() # 0
echo sumTillNegative(3, 4, 5) # 12
echo sumTillNegative(3, 4, -1, 6) # 7


# Parameters
proc printSeq(s: seq, nprinted: int = -1) =
  var nprinted = if nprinted == -1: s.len else: min(nprinted, s.len)
  for i in 0..<nprinted:
    echo s[i]

proc divmod(a, b: int; res, remainder: var int) =
  res = a div b # integer division
  remainder = a mod b

var 
  j, k: int
divmod(8, 5, j, k)
echo j
echo k

discard yes("May I ask a pointless question?")

proc p(x, y: int): int {.discardable.} = 
  return x + y

p(3, 4)


# Named Args
#proc createWindow(x, y, width, height: int; title: string; show: bool): Window =
#  ...

#var w = createWindow(show=true, title="My App", x=0, y=0, height=600, widht=800)


# Default Args
#proc createWindow(
#     x=0, y=0, width=550, height=700, title="Unknown", show=true): Window = 
# ...
#
# var w = createWindow(title="My App", height=600)


# Overloaded Procs
#proc toString(x: int): string = str(x)
proc toString(x: bool): string =
  if x: result = "true"
  else:
    result = "false"


# Forward declaration
proc even(n: int): bool # forward declaration

proc odd(n: int): bool =
  assert(n >= 0)
  if n == 0: false
  else:
    n == 1 or even(n - 1)

proc even(n: int): bool =
  assert(n >= 0)
  if  n == 1: false
  else:
    n == 0 or odd(n - 1)


# Iterators
echo "Counting to 10: "
for i in countup(1, 10):
  echo i

iterator myCountup(a, b: int): int =
  var res = a
  while res <= b:
    yield res
    inc(res)


# Enumerations
type
  Direction = enum
    north, east, south, writeStackTrace

var d = south
echo d


