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

