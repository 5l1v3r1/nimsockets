import net, times, strutils

proc main(port : int) =
  var client = newSocket()
  client.connect("localhost", Port(port))
  try:
      echo("Send what? ")
      var toSend = stdin.readLine()
      var l = len(toSend)
      if l > 99999:
        echo("Sorry, too long.")
      else:
        var toSend = intToStr(l, 5) & toSend
        echo("Sending: " & toSend)
        client.send(toSend)
        echo("Sent: ", toSend)
        echo("Receiving...")
        let rl = parseInt(client.recv(5))
        var msg = client.recv(rl)
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
