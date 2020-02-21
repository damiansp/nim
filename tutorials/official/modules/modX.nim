# Exports x and *, but not y
var
  x*, y: int

proc `*` *(a, b: seq[int]): seq[int] =
  newSeq(result, len(a))
  # multipy two int seqs
  for i in 0..len(a) - 1:
    result[i] = a[i] * b[i]

when isMainModule:
  # test the new ``*`` operator for seqs
  assert(@[1, 2, 3] * @[2, 3, 4] == @[2, 6, 12])
  