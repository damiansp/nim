import os
import osproc

let path = getHomeDir() # $HOME
let filepath = path / "test.txt"
echo("file path is", filepath)
writeFile(filepath, "test data")

# alternately
let newpath = joinPath(getHomeDir(), "test.txt")

doAssert(splitPath("usr/local/bin") == ("usr/local", "bin"))
doAssert(parentDir("/Users/user") == "/Users")
doAssert(tailDir("usr/local/bin") == "local/bin")
doAssert(isRootDir("/"))
doAssert(splitFile("/home/user/file.txt") == ("/home/user", "file", ".txt"))

for kind, path in walkDir(getHomeDir()):
  case kind
  of pcFile: echo("Found file: ", path)
  of pcDir: echo("Found directory: ", path)
  of pcLinkToFile, pcLinkToDir: echo("Found link: ", path)

when defined(windows):
  let (ver, _) = execCmdEx("cmd /C ver")
else:
  let (ver, _) = execCmdEx("uname -sr")
echo("My OS is: ", ver)

