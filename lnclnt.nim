import net, times

proc main(port : int) =
  var client = newSocket()
  client.connect("localhost", Port(port))
  try:
    while true:
      echo("Send what? ")
      var toSend = stdin.readLine()
      if toSend == ":q":
        break
      echo("Sending...")
      client.send(toSend)
      echo("Sent: ", toSend)
      echo("Receiving...")
      var msg = client.recvLine()
      echo("Received: ", msg)
  finally:
    client.close() # Necessary so we can send another request

when isMainModule:
  import os
  from strutils import parseInt
  if paramCount() > 0:
    let x = paramStr(1)
    main(parseInt(x))
  else:
    stderr.writeLine("Expected parameter: port")
