coffeescript = require('connect-coffee-script')
express      = require('express')
http         = require('http')
path         = require('path')
routes       = require('./routes')
user         = require('./routes/user')
websocket    = require('websocket-driver')

Session = require './src/Session'

SESSION_URL_PREFIX = '/session/'

sessionMap = {}

app = express()

# all environments
app.set 'port', process.env.PORT or 3000
app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'

app.use express.favicon()
app.use express.logger('dev')
app.use express.bodyParser()
app.use app.router

app.use coffeescript
  src: __dirname + '/public'
  bare: true

app.use express.static(path.join(__dirname, 'public'))

# development only
app.use express.errorHandler()  if app.get('env') is 'development'
app.get '/', routes.index
app.get '/users', user.list
server = http.createServer(app)
server.listen app.get('port'), ->
  console.log 'Express server listening on port ' + app.get('port')

server.on 'upgrade', (request, socket, body) ->
  if request.url.indexOf(SESSION_URL_PREFIX) is 0
    sessionId = request.url.substring SESSION_URL_PREFIX.length

    if sessionId.length > 1 and websocket.isWebSocket(request)
      # extend default HTTP socket timeout
      socket.setTimeout 300000

      # HTTP sockets allow half-open hence cleanup
      socket.on 'end', ->
        socket.end()

      driver = websocket.http(request)

      driver.io.write(body)
      socket.pipe(driver.io).pipe(socket)

      driver.start()

      session = sessionMap[sessionId]

      if not session
        session = sessionMap[sessionId] = new Session(driver.messages)

      session.addClient driver.messages