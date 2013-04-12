box_plate = '''
<div class="box">
  <a class="url" href="" target="_blank"><img class="thumbnail" width="175" src="" alt=""/></a>
  <div class="title"></div>
  <div style="float:left"><span class="likes"></span></div>
  <div style="float:left"><span class="length"></span></div>
  <div style="float:right"><span class="comments"></span></div>
  <div style="clear:both"></div>
</div>
'''

box_map = Plates.Map()
for field in ['title', 'comments', 'likes', 'length']
  (box_map.class field).to field
(((box_map.where 'class').is 'url').use 'url').as 'href'
(((box_map.where 'class').is 'thumbnail').use 'img').as 'src'
(((box_map.where 'class').is 'thumbnail').use 'title').as 'alt'

len = 0
fetching = no

moar = ->
  if fetching then return
  c = null
  for n in [0..4] # find shortest column
    if not c or ($ "#c#{n}").height() < c.height()
      c =($ "#c#{n}")

  if ($ 'body').scrollTop() + ($ 'body')[0].clientHeight > c[0].scrollHeight - 1000
    fetching = yes
    $.getJSON "/moar", (items) ->
      for it in items
        it.comments = '<i class="icon-comment-alt"/>' + it.comments
        it.length = '<i class="icon-play"/>' + it.length if it.length != null
        it.likes = '<i class="icon-thumbs-up"/>' + it.likes if it.likes != null
        ($ "#c#{len % 5}").append Plates.bind box_plate, [it], box_map
        len += 1
      fetching = no
      #moar()

view_init = ->
  for n in [4..0]
    ($ '#ct').prepend "<div id='c#{n}' class='col'></div>"
  ($ window).on 'scroll', moar
  moar()
