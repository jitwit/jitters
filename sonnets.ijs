require 'regex'

NB. 'file url' =. y
dlwget =: 3 : 0
2!:0 ^: (0 = 1!:4 :: 0: {. y) 'wget -O ', ;:^:_1 y
)

url =: 'http://shakespeare.mit.edu/Poetry/'

dlsonnet =: 3 : 0
dlwget ('data/',y);url,y
)

dlsonnets =: 3 : 0
dlwget 'data/sonnet-index.html';url,'sonnets.html'
dlsonnet &> 'sonnet.[IVXLCDM]+.html' rxall 1!:1 < 'data/sonnet-index.html'
)

random_sonnet =: 3 : 0
({~ ?@#) 1 dir 'data/sonnet.*.html'
)

clipbr=: #~ [: -. [: +/ (-i.4) |.!.0"0 _/ ('<BR>'&E.)

parse_sonnet =: 3 : 0
clipbr _3 }. 11 }. (#~ 1 = [: +/\ 'BLOCKQUOTE'&E.) 1!:1 y
)