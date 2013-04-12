box_plate = '''
<div class="box">
  <span class="title">Empty title</span>
  <br/>
  <img class="thumbnail" width="175" src="" alt=""/>
</div>
'''

box_map = Plates.Map()
(box_map.class 'title').to 'title'
(((box_map.where 'class').is 'thumbnail').use 'img').as 'src'
(((box_map.where 'class').is 'thumbnail').use 'title').as 'alt'

len = 0
fetching = no

moar = ->
  if fetching then return
  c = null
  for n in [0..4] # find shortest column
    if not c or ($ "#c#{n}").height() < c.height()
      c = ($ "#c#{n}")

  if ($ '#content').scrollTop() + ($ '#content').height() > c[0].scrollHeight - 1000
    fetching = yes
    $.getJSON "/moar", (items) ->
      for it in items
        ($ "#c#{len % 5}").append Plates.bind box_plate, [it], box_map
        len += 1
      fetching = no
      moar()

view_init = ->
  for n in [0..4]
    ($ '#content').append "<div id='c#{n}' class='col'></div>"
  ($ window).on 'scroll resize', moar
  moar()
