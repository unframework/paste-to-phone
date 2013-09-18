
Session = Backbone.Model.extend
  defaults:
    key: ''

  initialize: ->
    @isConnected = false
    @clientCount = 0
    @socket = new WebSocket('ws://localhost:3000/session/' + encodeURIComponent @get 'key')
    @text = ''

    @socket.onopen = (event) =>
      @isConnected = true
      @trigger 'connect'

    @socket.onmessage = (event) =>
      data = JSON.parse event.data

      if typeof data is 'number'
        @clientCount = data
        @trigger 'client'

      if typeof data is 'string'
        # @todo encrypt/decrypt
        @text = data
        @trigger 'text'

    @socket.onclose = (event) =>
      @isConnected = false
      @trigger 'disconnect'

  updateText: (text) ->
    if not @isConnected
      throw 'not connected'

    @text = text
    @socket.send JSON.stringify(@text)

  close: ->
