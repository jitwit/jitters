require 'plot'

ls =: 2 -~/\ I. LF=;(LF,1!:1@<) &.> 1 dir 'data'
N =: >. (+/%#) ls
log =: _2 _1 {"1 (0&".) (;._2) 1!:1 < jpath '~user/temp/jitter.txt'
log =: |: log #~ (*./"1) 50 < log
charhist =: (<;._2) 1!:1 < jpath '~user/temp/jitter_stamp.txt'

NB. most recent
'son stamp' =: (<;._1) TAB,4 {:: charhist
stamp =: 0 ". stamp

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
pd 'key wpm acc' NB. ; keypos top,outside,right'
pd 'show'
)

frames =: 1 2 4 8 * N NB. use average line length to reduce noise
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

NB. don't know how long for first char so that should be the one
NB. dropped?
timeofchars =: 3 : 0
chs =: y ]\ }. 1!:1 < son
dts =: chs (+/%#)/. (1+y) ({:-{.)\ stamp
(~.chs) (;&((\:dts)&{)) ,. dts
)


wpmvacc ''
overtime ''
lastround ''
timeofchars 1
