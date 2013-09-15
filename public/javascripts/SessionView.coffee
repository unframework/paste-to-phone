SessionView = Backbone.View.extend
  el: '#session'

  initialize: ->
    @render()

  render: ->
    @$el.text "Session key is #{ @model.get 'key' }"
