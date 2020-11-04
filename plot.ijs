require 'plot'

log =. _2 _1 {"1 (0&".) (;._2) 1!:1 < jpath '~user/temp/jitter.txt'
log =. |: log #~ (*./"1) 50 < log
stamp =. 0 ". 1!:1 < jpath '~user/temp/jitter_stamp.txt'

wpmvacc =: 3 : 0
pd 'reset; visible 0'
pd 'title jitters; subtitle wpm v. acc; xcaption wpm; ycaption acc'
pd 'type dot; pensize 1.5; color 20 120 255'
pd <"1 log
pd 'show'
)

overtime =: 3 : 0
pd 'reset; visible 0'
pd 'title jitters; subtitle performance over time; xcaption wpm; ycaption acc'
pd 'type dot; pensize 1.5; color 255 20 120,20 120 255'
pd"1 log
pd 'key wpm acc; keypos top,outside,right'
pd 'show'
)

frames =: 200 100 20 10
coords =: {{ y ;~ (-:x) + i. # y }}
framecoords =: {{ y coords 12 * 1 % y (+/%#)\ 2 -~/\ stamp }}

lastround =: 3 : 0
pd 'reset; visible 0'
pd 'title jitters; subtitle rolling wpm'
pd 'xcaption char;ycaption wpm'
pd 'type dot; pensize 1; color 20 200 140,255 100 0,255 20 120,20 120 255'
pd"1 framecoords"0 frames
pd 'key ',": frames
pd 'show'
)

NB. wpmvacc ''
NB. overtime ''
lastround ''
