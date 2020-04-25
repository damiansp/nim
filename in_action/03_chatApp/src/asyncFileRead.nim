# Simple example of asynchronous file reading; not a source file
import asyncdispatch, asyncfile

var file = openAsync("etc/passwd")
let dataFut = file.readAll()

dataFut.callback = 
  proc(future: Future[string]) = echo(future.read())

asyncdispatch.runForever()


# Example using `await`
proc readFiles() {.async.} =
  var file = openAsync("path/to/test.txt", fmReadWrite)
  let data = await file.readAll()
  echo(data)
  await file.write("Hello!\n")
  file.close()

waitFor readFiles()

