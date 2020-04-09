import json

type
  Message* = object
    username*: string
    message*: string

proc parseMessage*(data: string): Message =
  let dataJson = parseJson(data)
  result.username = dataJson["username"].getStr()
  result.message = dataJson["message"].getStr()

proc createMessage*(username, message: string): string = 
  result = $(%{"username": %username, "message": %message}) & "\c\l"

# Test
when isMainModule:
  block:
    let data = """{"username": "John", "message": "Hi!"}"""
    let parsed = parseMessage(data)
    doAssert parsed.username == "John"
    doAssert parsed.message == "Hi!"
  block:
    let data = """fubar"""
    try:
      let parsed = parseMessage(data)
      doAssert false
    except JsonParsingError:
      doAssert true
    except:
      doAssert false
  block:
    let expected = """{"username":"Judy","message":"Hey there!"}""" & "\c\l"
    doAssert createMessage("Judy", "Hey there!") == expected

  echo("All tests passed!")