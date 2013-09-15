SessionView = Backbone.View.extend
  el: '#session'

  initialize: ->
    @render()

  render: ->
    url = "#{ window.baseUrl }#session/#{ encodeURIComponent @model.get('key') }"

    @$('a').attr('href', url)
      .text url

    @$('img').attr 'src', "https://chart.googleapis.com/chart?chs=300x300&cht=qr&chl=#{ encodeURIComponent url }&choe=UTF-8"