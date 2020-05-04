import algorithm

var numbers = @[3, 8, 67, 23, 1, 2]
numbers.sort(system.cmp[int])
doAssert(numbers == @[1, 2, 3, 8, 23, 67])

var names = ["Dexter", "Poindexter", "Rita", "Margarita"]
let sortedNames = names.sorted(system.cmp[string])
doAssert(sortedNames == @["Dexter", "Margarita", "Poindexter", "Rita"])
doAssert(names == ["Dexter", "Poindexter", "Rita", "Margarita"])

# sytem.cmp:
proc comp*[T](x, y: T): int = 
  if x == y: return 0
  if x < y: return -1
  return 1

doAssert(comp(6, 5) == 1) 
doAssert(comp(5, 5) == 0)
doAssert(comp(5, 6) == -1)
