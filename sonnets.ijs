require 'regex'
coinsert 'jregex'

dlwget =: 3 : 0
2!:0 ^: (0 = 1!:4 :: 0: {. y) 'wget -O ', ;:^:_1 y
)

url =: 'http://shakespeare.mit.edu/Poetry/'

NB. 'file url' =. y
get_sonnet_index =: 3 : 0
dlwget 'data/sonnet-index.html';url,'sonnets.html'
)

dlsonnet =: 3 : 0
dlwget ('data/',y);url,y
)

get_sonnets =: 3 : 0
dlsonnet &> 'sonnet.[IVXLCDM]+.html' rxall 1!:1 < 'data/sonnet-index.html'
)

main =: 3 : 0
get_sonnet_index ''
get_sonnets ''
)