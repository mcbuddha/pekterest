req = require 'request'
che = require 'cheerio'

current_addr = ''
items = []

exports.crawl = (cb) ->
  if not current_addr then return cb []
  console.log current_addr
  req current_addr, (err, resp, body) ->
    $ = che.load body
    items = for it in $ '.side-dock li > a'
      url: ((($ it).attr 'href').split '?')[0]
      title: ($ it).find('h4').text()
      comments: ($ it).find('.comment').text()*1 or 0
      likes: ($ it).find('.loved').text()*1 or 0
      img: ($ it).find('img').attr('src').replace('_220x145', '_700b')
    n = Math.floor Math.random() * (items.length - 0.001)
    current_addr = items[n].url
    cb items

# init
req 'http://9gag.com', (err, resp, body) ->
  $ = che.load body
  n = Math.floor Math.random() * 9.999
  current_addr = ($ ($ 'li.entry-item')[n]).attr 'data-url'
