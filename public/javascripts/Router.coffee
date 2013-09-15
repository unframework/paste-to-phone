
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

$ ->
  router = new Router
  Backbone.history.start()
