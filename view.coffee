box_plate = '''
<div class="box" style="float: left; margin: 10px">
  <span class="title">Empty title</span>
  <br/>
  <img class="thing" width="100" height="100" src="http://placehold.it/100x100"/>
</div>
'''

you_at = 0

show_some_more = (thismany) ->
  $.getJSON "/take_from/#{you_at}/#{thismany}", (some_boxes) ->
    you_at += some_boxes.length
    box_map = Plates.Map()
    (box_map.class 'title').to 'title'
    (((box_map.where 'class').is 'thing').use 'thing').as 'src'
    ($ '#content').append Plates.bind box_plate, some_boxes, box_map

view_init = ->
  ($ window).scroll ->
    if screenTop + scrollY + ($ '#content').height() > ($ '#content')[0].scrollHeight
      show_some_more 25
  show_some_more 50
