import net, times

proc main(port : int) =
  var socket = newSocket()
  socket.bindAddr(Port(port))
  socket.listen()
  var client = new Socket
  var address = ""
  while true:
    echo("Waiting for connection...")
    socket.acceptAddr(client, address)
    echo("Client connected from: ", address)
    try:
      var c : TaintedString = "INIT"
      while c != "":
        client.readLine(c)
        stdout.writeLine(c)
    finally:
      client.close() # Necessary so we can send another request

when isMainModule:
  import os
  from strutils import parseInt
  if paramCount() > 0:
    let x = paramStr(1)
    main(parseInt(x))
  else:
    stderr.writeLine("Exported parameter: port number")
