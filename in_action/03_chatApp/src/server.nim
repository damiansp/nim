import asyncdispatch, asyncnet


type 
	Client = ref object
		socket: AsyncSocket
		netAddr: string
		id: int
		isConnected: bool

	Server = ref object
		socket: AsyncSocket
		clients: seq[Client]


proc newServer(): Server = Server(socket: newAsyncSocket(), clients: @[])


var server = newServer()



