
Router = Backbone.Router.extend
  routes:
    '': 'index'
    'session/:sessionKey': 'session'

  index: ->
    BASE58_CHARS = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'
    sessionKey = (BASE58_CHARS[Math.floor Math.random() * BASE58_CHARS.length] for i in [1..10]).join ''

    @navigate 'session/' + encodeURIComponent(sessionKey), true

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
