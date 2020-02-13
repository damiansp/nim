import future, sequtils, strutils

# functional style
let list = @["Alex Baldwin", "Charles Desmond", "Elinore Fox"]
list.map((x: string) -> (string, string) => (x.split[0], x.split[1])).echo

# procedural style
for name in list:
  echo((name.split[0], name.split[1]))