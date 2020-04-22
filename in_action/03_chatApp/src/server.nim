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


proc loop(server: Server, port=7687) {.async.} =
  server.socket.bindAddr(port.Port)
  server.socket.listen()
  while true:
    let (netAddr, clientSocket) = await server.socket.acceptAddr()
    echo("Accepted connection from ", netAddr)
    let client = Client(socket: clientSocket,
                        netAddr: netAddr,
                        id: server.clients.len,
                        isConnected: true)
    server.clients.add(client)


proc processMessages(server: Server, client: Client) {.async.} =
  while true:
    let line = await client.socket.recvLine()
    if line.len == 0:
      # as echo(client, ...) in book, but no mehthod to echo type client
      echo(client.id, " disconnected") 
      client.isConnected = false
      client.socket.close()
      return
    # as echo(client, ...) in book, but no mehthod to echo type client
    echo(client.id, " sent: ", line)


var server = newServer()

waitFor loop(server)

