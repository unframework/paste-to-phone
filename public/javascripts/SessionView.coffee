SessionView = Backbone.View.extend
  el: '<div class="session"></div>'

  initialize: ->
    @$a = $('<h2><a href=""></a></h2>').appendTo(@el).find 'a'
    @$img = $('<img />').appendTo(@el)

    @render()

  render: ->
    url = "#{ window.baseUrl }#session/#{ encodeURIComponent @model.get('key') }"

    @$a.attr('href', url)
      .text url

    @$img.attr 'src', "https://chart.googleapis.com/chart?chs=300x300&cht=qr&chl=#{ encodeURIComponent url }&choe=UTF-8"