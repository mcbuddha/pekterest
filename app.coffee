fs = require 'fs'
flatiron = require 'flatiron'
plates = require 'plates'
crawler = require './crawl'

app = flatiron.app
app.use flatiron.plugins.http

main_plate = '''
<html style="background:#eee;">
<head>
  <title>Pekterest</title>
  <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
  <script src="/js"></script>
  <link href="//netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css" rel="stylesheet">
  <style>
    #ct{margin-left:auto; margin-right: auto; font: 12px sans; width: 1000px;}
    .col{float:left; margin:4px; width: 182px}
    .box{margin-bottom:8px; padding:4px; border-radius:4px; background: #fff;}
  </style>
</head>
<body onload="view_init()"><div id="ct"><div style="clear:both"></div></div></body>
</html>
'''

app.router.get '/', ->
  @res.writeHead 200, 'Content-Type': 'text/html'
  @res.end main_plate

app.router.get '/js', ->
  @res.writeHead 200, 'Content-Type': 'text/javascript'
  for f in ['node_modules/plates/lib/plates.js', 'view.js']
    @res.write fs.readFileSync f
  @res.end ''

app.router.get '/moar', ->
  crawler.crawl (data) => @res.end JSON.stringify data

app.start 8080
