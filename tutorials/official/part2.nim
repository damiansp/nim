#=========#=========#=========#=========#=========#=========#=========#=========
import sequtils, strutils

# Inheritance
type
  Person = ref object of RootObj
    name*: string # * indicates that it is public/accessible to other modules
    age: int      # private

  Student = ref object of Person # inherits from Person
    id: int

var
  student: Student
  person: Person

assert(student of Student) # true
student = Student(name: "Anton", age: 5, id: 2)
echo student[]


# Mutually recursive types
type
  Node = ref object # a reference to an object with the following fields
    le, ri: Node    # left and right nodes
    sym: ref Sym    # leaves contain a ref to a Sym

  Sym = object      # a symbol
    name: string    # symbol's name
    line: int       # line where symbol was declared
    code: Node      # symbol's abstract syntax tree


# Type conversion
# InvalidObjectConversionError if x is not a Student
proc getID(x: Person): int = Student(x).id 


# Object variants
# Ex of nim modeling of abstract syntax tree
type
  KnodeKind = enum
    kkInt,
    kkFloat,
    kkString,
    kkAdd,
    kkSub,
    kkIf
  Knode = ref object 
    case kind: KnodeKind
    of kkInt: intVal: int
    of kkFloat: floatVal: float
    of kkString: strVal: string
    of kkAdd, kkSub:
      leftOp, rightOp: Knode
    of kkIf:
      condition, thenPart, elsePart: Knode

var k = Knode(kind: kkFloat, floatVal: 1.0)
#k.strVal = "" # error


# Method call syntax
# method(obj, args) equivalent to obj.method(args)
stdout.writeLine("Give a list of numbers separated by spaces")
stdout.write(stdin.readLine.splitWhitespace.map(parseInt).max.`$`)
stdout.writeLine(" is the max!")