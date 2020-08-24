require 'regex'

NB. 'file url' =. y. will actually learn wget at some point
dlwget =: 3 : 0
2!:0 ^: (0 = 1!:4 :: 0: {. y) 'wget -O ', ;:^:_1 y
)

url =: 'http://shakespeare.mit.edu/Poetry/'
out =: jpath '~user/jitters/sonnets'

dlsonnet =: 3 : 0
dlwget ('data/',y);url,y
)

dlsonnets =: 3 : 0
dlwget 'data/sonnet-index.html';url,'sonnets.html'
dlsonnet &> 'sonnet.[IVXLCDM]+.html' rxall 1!:1 < 'data/sonnet-index.html'
)

clipbr=: #~ [: -. [: +/ (-i.4) |.!.0"0 _/ ('<BR>'&E.)

parse_sonnet =: 3 : 0
s =. clipbr _3 }. 11 }. (#~ 1 = [: +/\ 'BLOCKQUOTE'&E.) 1!:1 y
s 1!:2 ('.txt',~ _5&}.) &.> y
)

parse_sonnets =: 3 : 0
parse_sonnet"0 ] 1 dir 'data/sonnet.*.html'
)

