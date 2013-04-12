req = require 'request'

sources = [
  'http://screenlyapp.com'
  'http://www.nytimes.com/'
  'http://www.collegehumor.com/'
  'http://www.tumblr.com/'
  'http://www.twitter.com/'
]

pattern = /<a\s[^>]*href=\"(http[^\"]*)\".*>(.*)<\/a>/g
crawl = (here) ->
  req here, (err, resp, body) ->
    unless err
      while candidate = pattern.exec body
        funny_or_die candidate[0..2]
    else
      console.log err

exports.funny_things = []

funny_or_die = (candidate) ->
  funny = no
  funny = funny or candidate[1].match /funny/i
  funny = funny or candidate[2].match /humor/i

  if funny
    exports.funny_things.push thing: candidate[1], title: candidate[2]

for source in sources
  crawl source

for i in [0..250]
  exports.funny_things.push thing: 'http://placekitten.com/100/100', title: "Title #{i}"
