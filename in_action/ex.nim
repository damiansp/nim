type
    Dog = object
      age: int

let dog = Dog(age: 3)


proc showNumber(num: int | float) = echo(num)

showNumber(3)
showNumber(3.14)


for i in 0 .. <10:
    echo(i)

