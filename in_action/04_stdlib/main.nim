import misc/example
import misc/example2

echo(name)
echo(example.moduleVersion)
echo(example2.moduleVersion)

# can also use
# import misc/example except moduleVersion


proc welcome(name: string) = echo("Hello, ", name)

welcome("Malcolm")
"Malcolm".welcome() # same as previous
