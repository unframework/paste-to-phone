var socket;

socket = new WebSocket('ws://localhost:3000/session/something');

socket.onopen = function(event) {
  socket.send('I am the client and I\'m listening!');
  socket.onmessage = function(event) {
    return console.log('Client received a message', event);
  };
  return socket.onclose = function(event) {
    return console.log('Client notified socket has closed', event);
  };
};
