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


# Properties
type
  Socket* = ref object of RootObj 
    h: int # private (no *)

proc `host=`*(s: var Socket, value: int) {.inline.}  =
  # setter for host address
  s.h = value

proc host*(s: Socket): int {.inline.} =
  # getter of host address
  s.h 

var s: Socket
new s
s.host = 34 # same as `host=`(s, 34)

type
  Vector* = object 
    x, y, z: float

proc `[]=`*(v: var Vector, i: int, value: float) =
  # setter
  case i
  of 0: v.x = value
  of 1: v.y = value
  of 2: v.z = value
  else: assert(false)

proc `[]`*(v: Vector, i: int): float = 
  # getter
  case i 
  of 0: result = v.x
  of 1: result = v.y
  of 2: result = v.z
  else: assert(false)


# Dynamic Dispatch
type
  Expression = ref object of RootObj
  Literal = ref object of Expression
    x: int
  PlusExpr = ref object of Expression
    a, b: Expression

# Caution: 'eval' relies on dynamic binding
method eval(e: Expression): int {.base.} =
  # override this base method
  quit "to override!"

#method eval(e: Literal): int = e.x
method eval(e: PlusExpr): int = eval(e.a) + eval(e.b)

proc newLit(x: int): Literal = Literal(x: x)
proc newPlus(a, b: Expression): PlusExpr = PlusExpr(a: a, b: b)

#echo eval(newPlus(newPlus(newLit(1), newLit(2)), newLit(4)))


# Exceptions
#var
#  e: ref OSError
#new(e)
#e.msg = "the request to the OS failed"
#raise e

#raise newException(OSError, "the request to the OS failed")


var
  f: File 
if open(f, "numbers.txt"):
  try:
    let a = readLine(f)
    let b = readLine(f)
    echo "sum: ", strutils.parseInt(a) + strutils.parseInt(b)
  except OverflowError:
    echo "overflow!"
  except ValueError:
    echo "could not convert str to int"
  except IOError:
    echo "IOError!"
  except:
    echo "Unknown exception!"
    raise
  finally:
    close(f)

proc doSomething() =
  raise newException(OSError, "OSError!!")
try:
  doSomething()
except:
  let
    e = getCurrentException()
    msg = getCurrentExceptionMsg()
  echo "Got exception ", repr(e), "with message ", msg


# Generics
type
  BinaryTree*[T] = ref object # BinaryTree is a generic type with generic param
    le, ri: BinaryTree[T]     # T; le(ft) and ri(ght) are subtrees; may be nil
    data: T                   # data stored in node

proc newNode*[T](data: T): BinaryTree[T] =
  # node constuctor
  new(result)
  result.data = data

proc add*[T](root: var BinaryTree[T], n: BinaryTree[T]) =
  # insert node into tree
  if root == nil:
    root = n
  else:
    var it = root 
    while it != nil:
      # compare data items; uses generic cmp proc that works for any type that 
      # has == and < operators
      var c = cmp(it.data, n.data)
      if c < 0:
        if it.le == nil:
          it.le = n
          return
        it = it.le
      else:
        if it.ri == nil:
          it.ri = n
          return
        it = it.ri 

proc add*[T](root: var BinaryTree[T], data: T) =
  # convenience
  add(root, newNode(data))

iterator preorder*[T](root: BinaryTree[T]): T =
  # Preorder traversal of BinaryTree
  # Since recursive iterators not yet implemented, use a (more efficient) explicit
  # stack 
  var stack: seq[BinaryTree[T]] = @[root]
  while stack.len > 0:
    var n = stack.pop()
    while n != nil:
      yield n.data 
      add(stack, n.ri) # push r subtree onto the stack and follow l pointer
      n = n.le

var
  root: BinaryTree[string]  # instantiate tree
add(root, newNode("hello")) # instantiate node and add 
add(root, "world")
for str in preorder(root):
  stdout.writeLine(str)