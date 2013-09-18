SessionView = Backbone.View.extend
  el: '<div class="session"></div>'

  initialize: ->
    url = "#{ window.baseUrl }#session/#{ encodeURIComponent @model.get('key') }"

    @$el.append('<div class="connection-message">Connecting</div>')

    @$qrCodeImage = $('<img class="qr-code" />').appendTo(@el)
    @$qrCodeImage.attr 'src', "https://chart.googleapis.com/chart?chs=300x300&cht=qr&chl=#{ encodeURIComponent url }&choe=UTF-8"

    @$textEntry = $('<textarea class="text-entry"></textarea>').appendTo(@el)

    @listenTo @model, 'connect', @render.bind(this)
    @listenTo @model, 'disconnect', @render.bind(this)

    @listenTo @model, 'client', =>
      @render()
      @$textEntry.focus()

    @listenTo @model, 'text', @render.bind(this)

    @$textEntry.on 'keyup', =>
      setTimeout =>
        text = @$textEntry.val()
        if text isnt @model.text
          @model.updateText text
      , 0

    @render()

  render: ->
    @$el.toggleClass 'connected', @model.isConnected
    @$el.toggleClass 'has-peer', @model.isConnected and @model.clientCount > 1

    @$textEntry.val @model.text
