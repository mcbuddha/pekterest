fs = require 'fs'
flatiron = require 'flatiron'
app = flatiron.app

plates = require 'plates'

main_plate = '''
<html>
  <head>
    <title>Pekterest</title>
    <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="/js"></script>
    <style>.box{float:left; margin:10px;}</style>
  </head>
  <body id="content" onload="view_init()"></body>
</html>
'''

crawler = require './crawl_9gag'

app.use flatiron.plugins.http

app.router.get '/', ->
  @res.writeHead 200, 'Content-Type': 'text/html'
  @res.end main_plate

app.router.get '/js', ->
  @res.writeHead 200, 'Content-Type': 'text/javascript'
  @res.write fs.readFileSync 'node_modules/plates/lib/plates.js'
  @res.write fs.readFileSync 'view.js'
  @res.end ''

app.router.get '/moar', ->
  crawler.crawl (data) =>
    @res.end JSON.stringify data

app.start 8080
