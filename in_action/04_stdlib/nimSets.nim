import sets

var accessSet = toSet(["Jack", "Hurley", "Desmond"])

if "John" notin accessSet:
  echo("Access Denied")
else:
  echo("Access Granted")

