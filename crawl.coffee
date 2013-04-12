[req, che, async] = for m in ['request', 'cheerio', 'async'] then require m
choose_rand = (seq) -> seq[Math.floor Math.random() * (seq.length - 0.001)]

class Crawler
  current_addr: ''
  constructor: ->
    req @init_url, (err, resp, body) =>
      n = Math.floor Math.random() * 9.999
      @current_addr = choose_rand @get_first_addrs che.load body
      console.log @current_addr

  crawl: (cb) =>
    console.log @current_addr
    req @current_addr, (err, resp, body) =>
      items = @get_items(che.load body)
      @current_addr = (choose_rand items).url
      cb null, items

class C9gag extends Crawler
  init_url: 'http://9gag.com'
  get_first_addrs: ($) -> for li in ($ 'li.entry-item') then ($ li).attr 'data-url'
  get_items: ($) -> for it in $ '.side-dock li > a'
    url: ($ it).attr('href').split('?')[0]
    title: ($ it).find('h4').text()
    comments: ($ it).find('.comment').text()*1 or 0
    likes: ($ it).find('.loved').text()*1 or 0
    length: null
    img: ($ it).find('img').attr('src').replace('_220x145', '_700b')

class Croflto extends Crawler
  init_url: 'http://clips.rofl.to'
  get_first_addrs: ($) -> for a in ($ 'ul.video-list h2 > a') then ($ a).attr 'href'
  get_items: ($) ->
    for it in ($ 'ul.video-list-micro li') when ($ it).find('a').attr('title').search 'minutes' != -1
      url: ($ it).find('a').attr 'href'
      title: ($ it).find('h2').text().replace /^\s+|\s+$/g, ''
      comments: ($ it).find('h2').attr('title').replace(' comments', '')*1 or 0
      likes: null
      length: do (t = ($ it).find('a').attr('title')) ->
        t = t.replace('Video length: ', '').replace(/\ minutes?, /g, ':').replace(' seconds', '')
        if ':' not in t then '00:'+t else t
      img: ($ it).find('img').attr 'src'

crawlers = [new C9gag(), new Croflto()]
exports.crawl = (cb) ->
  async.parallel (c.crawl for c in crawlers), (err, results) ->
    if err then return
    items = []
    for i in [0...6]
      for j in [0...8] then items.push results[0].pop()
      items.push results[1].pop()
    cb items
