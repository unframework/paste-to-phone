
class Session
  constructor: ->
    @streamList = []

  addClient: (client) ->
    @streamList.push client

    client.on 'data', (message) =>
      for otherClient in @streamList
        if otherClient isnt client
          otherClient.write message

    client.write JSON.stringify(@streamList.length) for client in @streamList

module.exports = Session
