
Session = Backbone.Model.extend
  defaults:
    key: ''

  initialize: ->
    @isConnected = false
    @clientCount = 0
    @socket = new WebSocket('ws://localhost:3000/session/' + encodeURIComponent @get 'key')

    @socket.onopen = (event) =>
      @isConnected = true
      @trigger 'connect'

    @socket.onmessage = (event) =>
      data = JSON.parse event.data

      if typeof data is 'number'
        console.log "client count", data

        @clientCount = data
        @trigger 'client'

    @socket.onclose = (event) =>
      @isConnected = false
      @trigger 'disconnect'

  close: ->
