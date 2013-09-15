
class Session
  constructor: ->
    @streamList = []

    console.log 'session created'

  addClient: (client) ->
    @streamList.push client

    client.on 'data', (message) =>
      for otherClient in @streamList
        if otherClient isnt client
          otherClient.write message

    client.write JSON.stringify(null) for client in @streamList

module.exports = Session
