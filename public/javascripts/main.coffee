
socket = new WebSocket('ws://localhost:3000/session/something')

socket.onopen = (event) ->
  socket.send('I am the client and I\'m listening!')
  socket.onmessage = (event) ->
    console.log('Client received a message',event)
  socket.onclose = (event) ->
    console.log('Client notified socket has closed',event)
