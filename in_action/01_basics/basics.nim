#=========#=========#=========#=========#=========#=========#=========#=========
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
