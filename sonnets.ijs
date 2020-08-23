require 'regex'
coinsert 'jregex'
url =: 'http://shakespeare.mit.edu/Poetry/'
wgetO =: 'wget -O'

NB. 'file url' =. y
dlwget =: 3 : 0
(2!:0) ^: (0 = 1!:4 :: 0: {. y) 'wget -O ', ;:^:_1 y
)

get_sonnet_index =: 3 : 0
dlwget 'sonnet-index.html';url,'sonnets.html'
)

dlsonnet =: 3 : 0
dlwget ('data/',y);url,y
)

get_sonnets =: 3 : 0
dlsonnet &> 'sonnet.[IVXLM]+.html' rxall 1!:1 < 'sonnet-index.html'
)