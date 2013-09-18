SessionView = Backbone.View.extend
  el: '<div class="session"></div>'

  initialize: ->
    url = "#{ window.baseUrl }#session/#{ encodeURIComponent @model.get('key') }"

    @$el.append('<div class="connection-message">Connecting</div>')

    @$qrCodeImage = $('<img class="qr-code" />').appendTo(@el)
    @$qrCodeImage.attr 'src', "https://chart.googleapis.com/chart?chs=300x300&cht=qr&chl=#{ encodeURIComponent url }&choe=UTF-8"

    @listenTo @model, 'connect', @render.bind(this)
    @listenTo @model, 'disconnect', @render.bind(this)
    @listenTo @model, 'client', @render.bind(this)

    @render()

  render: ->
    @$el.toggleClass 'connected', @model.isConnected
    @$el.toggleClass 'has-peer', @model.clientCount > 1
