fs = require 'fs'
flatiron = require 'flatiron'
app = flatiron.app

plates = require 'plates'

main_plate = '''
<html>
  <head>
    <title>Pekterest</title>
    <script src="/js"></script>
  </head>
  <body id="content" onload="view_init()"></body>
</html>
'''

crawler = require './crawler.js'

app.use flatiron.plugins.http

app.router.get '/', ->
  @res.writeHead 200, 'Content-Type': 'text/html'
  @res.end main_plate

app.router.get '/js', ->
  @res.writeHead 200, 'Content-Type': 'text/javascript'
  @res.write fs.readFileSync 'node_modules/plates/lib/plates.js'
  @res.write fs.readFileSync 'node_modules/zepto/zepto.min.js'
  @res.write fs.readFileSync 'view.js'
  @res.end ''

app.router.get '/take/:howmany', (thismany) ->
  @res.writeHead 200, 'Content-Type': 'text/javascript'
  @res.end JSON.stringify crawler.funny_things[0...(parseInt thismany)]

app.router.get '/take_from/:where/:howmany', (here, thismany) ->
  @res.writeHead 200, 'Content-Type': 'text/javascript'
  from = parseInt here
  to = from + parseInt thismany
  @res.end JSON.stringify crawler.funny_things[from...to]

app.start 8080