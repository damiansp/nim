#=========#=========#=========#=========#=========#=========#=========#=========
import os
import sequtils, sugar # <- replaces future


var
  text = "hello"
  number: int = 10
  isTrue = false
let 火 = "fire"

# Create a var called "var" (requires "stropping")
var `var` = "Hello"
echo(`var`) # Hello

proc greet(name: string): string = "Hello " & name 

let greeting = greet("Damian")
echo greeting

discard greet("Jimbo") # like Pyhong _, but MUST be used for unused returns

# Forward declarartions
proc bar(): int # declaration required in this case b/c...
proc foo(): float = bar().float
proc bar(): int = foo().int 

# no returns
proc noReturn() = echo("Hello")
proc noReturn2(): void = echo("Hello")
proc noReturn3 = echo("Hello")

proc implicit: string = "I will be returned"
#proc discarded: string = discard "I will not be retruned"
proc explicit: string = return "I will be returned"
proc resultVar: string = result = "I will be returned"
proc resultVar2: string =
  result = ""
  result.add("I will be")
  result.add(" returned")

#proc resultVar3: string =
#  result = "I am the result"
#  "I will cause an error"

assert implicit() == "I will be returned"
#assert discarded() == nil # nil no longer valid for strings
assert explicit() == "I will be returned"
assert resultVar() == "I will be returned"
assert resultVar2() == "I will be returned"

proc message(recipient: string): auto = "Hello " & recipient
assert message("Bill") == "Hello Bill"

proc max(a: int, b:int): int =
  if a > b:
    a
  else:
    b
assert max(5, 10) == 10

proc min(a, b: int): int =
  if a < b: a else: b
assert min(5, 10) == 5

proc genHello(name: string, surname="Doe"): string =
  "Hello, " & name & " " & surname
echo genHello("Peter")
echo genHello("Peter",  "Smith")

proc genHello2(names: varargs[string]): string =
  result = ""
  for name in names:
    result.add("Hello, " & name & "\n")

echo genHello2("Mary", "Dave", "Sally")


# Proc overloading
proc getUserCity(name, surname: string): string =
  case name 
  of "Damian": return "Eugene"
  of "McKenzie": return "Los Angeles"
  else: return "Unknown"

proc getUserCity(userID: int): string =
  case userID
  of 1: return "Tokyo"
  of 2: return "New York"
  else: return "Unknown"

echo getUserCity("Damian", "Phillips")
echo getUserCity(1)

let numbers = @[1, 2, 3, 4, 5, 6]
let odd = filter(numbers, proc(x: int): bool = x mod 2 != 0)
echo odd 

# sugar
let even = filter(numbers, (x: int) -> bool => x mod 2 == 0)
echo even 

proc isValid(x: int, validator: proc (x: int): bool) =
  if validator(x):
    echo(x, " is valid")
  else:
    echo(x, " is NOT valid")

# sugar
proc isAlsoValid(x: int, validator: (x: int) -> bool) = 
  if validator(x):
    echo(x, " is valid")
  else:
    echo(x, " is NOT valid")


# Collection Types

# Arrays (STATIC LENGTH)
var list: array[3, int] # array of 3 ints
list[0] = 1
list[1] = 42
echo list.repr

var neglist: array[-10 .. -9, int] # int array with inidces -10 and -9
neglist[-10] = 0
neglist[-9] = 1

var words = ["Hi", "there"]

var sent = ["My", "name", "is", "not", "Bob"]
for word in sent:
  echo(word)

for i in sent.low .. sent.high:
  echo(sent[i])


# Sequences (VAR LENGTH)
var slist: seq[int] = @[]
#slist[0] = 1 # out of bounds error
slist.add(2)
echo(slist[0])

var wordlist = newSeq[string](3)
wordlist[0] = "Foo"
wordlist[1] = "Bar"
wordlist[2] = "Baz"
wordlist.add("Lorem")

let numlist = @[4, 8, 15, 16, 31, 32]
for i in 0 .. numlist.len - 1:
  stdout.write($numlist[i] & "... ")
echo ""


# Sets
var collection: set[int16]
assert collection == {}

let letterSet = {'a', 'x', 'r'}
assert 'a' in letterSet

let letterSet2 = {'a', 'T', 'z'}
let isAllLowerCase = {'A' .. 'Z'} * letterSet2
if isAllLowerCase == {}:
  echo "LetterSet2 all lower case"
else:
  echo "Some non-lower case chars in letterSet2"


# Control Flow
let itsName = "Duran Duran"
case itsName
of "Arthur", "Zaphod", "Ford":
  echo "Male"
of "Marvin":
  echo "Martian"
of "Trillian":
  echo "Female"
else:
  echo "Unknown"

var age = 42
var ageDesc = if age < 18: "Minor" else: "Adult"

var j = 0
while j < 10:
  echo j
  j.inc

block label:
  var k = 0
  while true:
    while k < 5:
      if k > 3: break label # !
      k.inc

iterator values(): int =
  var m = 0
  while m < 0:
    yield m
    m.inc 

for value in values():
  echo value

for filename in walkFiles("*.nim"):
  echo filename 

for item in @[1, 2, 3]:
  echo item


# Exception Handling
proc second() =
  raise newException(IOError, "Somebody sent us the bomb")

proc first() =
  try:
    second()
  except:
    echo("Cannot perform second(): " & getCurrentExceptionMsg())

first()


# Objects
type
  Person = object
    name: string
    age: int

var person = Person(name: "Neo", age: 28)

type
  PersonObj = object 
    name: string
    age: int
  PersonRef = ref PersonObj

# This fails: can't modify a non-ref param b/c might have been copied
# prior to this. E.g., param is immutable
#proc setName(person: PersonObj) = 
#  person.name = "George"

# Ok:
proc setName(person: PersonRef) =
  person.name = "George"


# Tuples
# nominative vs structural typing
type
  DogObj = object
    name: string

  CatObj = object 
    name: string

let dog: DogObj = DogObj(name: "Fluffy")
let cat: CatObj = CatObj(name: "Fluffy")
#echo(dog == cat) # false --> Now: Error: type mismatch

# BUT
type
  DogTup = tuple
    name: string
  CatTup = tuple 
    name: string

let doggie: DogTup = (name: "Spot")
let kitty: CatTup = (name: "Spot")
echo(doggie == kitty) # true

type
  Point = tuple[x, y: int]
  Point2 = (int, int)

let pos: Point = (x: 100, y: 50)
doAssert pos == (100, 50)

let (x, y) = pos
let (left, _) = pos
doAssert x == pos[0]
doAssert y == pos[1]
doAssert left == x


# Enums
type
  Color = enum
    colRed,
    colGreen,
    colBlue

let color: Color = colRed

type 
  PureColor {.pure.} = enum
    red, green, blue 

let pureColor = PureColor.red # dot syntax required for .pure.


# Pragmata
