import os

let path = getHomeDir() # $HOME
let filepath = path / "test.txt"
echo("file path is", filepath)
writeFile(filepath, "test data")
