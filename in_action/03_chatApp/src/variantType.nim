type 
  Box = object
    case empty: bool
    of false:
      contents: string
    else:
      discard

var obj = Box(empty: false, contents: "Hello")
assert obj.contents == "Hello"

var obj2 = Box(empty: true)
# echo(obj2.contents) # error

