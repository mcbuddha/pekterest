box_plate = '''
<div class="box">
  <span class="title">Empty title</span>
  <br/>
  <img class="thumbnail" width="175" src="" alt=""/>
</div>
'''

you_at = 0

moar = ->
  c = ($ '#content')
  console.log c.scrollTop() + c.height() , c[0].scrollHeight - 1000
  if c.scrollTop() + c.height() > c[0].scrollHeight - 1000
    $.getJSON "/moar", (items) ->
      you_at += items.length
      box_map = Plates.Map()
      (box_map.class 'title').to 'title'
      (((box_map.where 'class').is 'thumbnail').use 'img').as 'src'
      (((box_map.where 'class').is 'thumbnail').use 'title').as 'alt'
      ($ '#content').append Plates.bind box_plate, items, box_map

view_init = ->
  ($ window).on 'scroll resize', moar
  moar()
