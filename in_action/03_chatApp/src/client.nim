#---------#---------#---------#---------#---------#---------#---------#---------
import os


echo("Chat application started")
if paramCount() == 0:
    quit("Please specify the server address, e.g., ./client localhost")

let serverAddr = paramStr(1)
echo("Connected to ", serverAddr)
let message = stdin.readLine()
echo("Sending \"", message, "\"")