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

lastround =: 3 : 0
frame =. 200
minif =. 20
pd 'reset; visible 0'
pd 'title jitters; subtitle rolling wpm'
pd 'xcaption char;ycaption wpm'
pd 'type dot; pensize 1; color 20 200 140,244 160 10,255 20 120,20 120 255'
pd (;~ (-:-:minif)+i.@#) 12 * 1 % (-:minif) (+/%#)\ 2 -~/\ stamp
pd (;~ (-:frame)+i.@#) 12 * 1 % frame (+/%#)\ 2 -~/\ stamp
pd (;~ (-:minif) + i.@#) 12 * 1 % minif (+/%#)\ 2 -~/\ stamp
pd (;~ (-:-:frame)+i.@#) 12 * 1 % (-:frame) (+/%#)\ 2 -~/\ stamp
pd 'key ',": minif ,&(,~-:) frame
pd 'show'
)

wpmvacc''
overtime''
lastround''
