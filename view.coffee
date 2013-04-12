box_plate = '''
<div class="box">
  <img class="thumbnail" width="175" src="" alt=""/>
  <div class="title"></div>
  <div style="float:left"><i class="icon-comment-alt"/><span class="comments"></span></div>
  <div style="float:right"><i class="icon-thumbs-up"/><span class="likes"></span></div>
  <div style="clear:both"></div>
</div>
'''

box_map = Plates.Map()
for field in ['title', 'comments', 'likes']
  (box_map.class field).to field
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
        ($ "#c#{len % 5}").append Plates.bind box_plate, [it], box_map
        len += 1
      fetching = no
      #moar()

view_init = ->
  for n in [4..0]
    ($ '#ct').prepend "<div id='c#{n}' class='col'></div>"
  ($ window).on 'scroll', moar
  moar()
