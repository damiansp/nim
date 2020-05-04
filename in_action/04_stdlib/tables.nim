import hashes, tables

var numbers = @[3, 8, 1, 10]
numbers.add(12)

var animals = @["Dog", "Raccoon", "Sloth", "Cat"]
animals.add("Red Panda")

var animalAges = toTable[string, int]({"Dog": 3,
																			 "Racoon": 8,
																			 "Sloth": 1, 
																			 "Cat": 10})
animalAges["Red Panda"] = 12

type
	Dog = object
		name: string

proc hash(x: Dog): Hash =
	result = x.name.hash
	result = !$result # !$ operator checks for hash uniqueness

var dogOwners = initTable[Dog, string]()
dogOwners[Dog(name: "Koko")] = "Mom"