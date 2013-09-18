
Router = Backbone.Router.extend
  routes:
    '': 'index'
    'session/:sessionKey': 'session'

  index: ->
    @navigate 'session/' + 'newSessionKey'

  session: (sessionKey) ->
    model = new Session
      key: sessionKey

    sessionView = new SessionView
      model: model

    $('body').append sessionView.el

    # clean up before next display
    setTimeout =>
      @once 'route', ->
        model.close()
        sessionView.$el.remove()
    , 0

$ ->
  router = new Router
  Backbone.history.start()
