require 'regex'
coinsert 'jregex'
url =: 'http://shakespeare.mit.edu/Poetry/'

dlwget =: 3 : 0
'file url' =. y
(2!:0) ^: (0 = 1!:4 :: 0: < file) 'wget -O ',file,' ',url
)

get_sonnet_index =: 3 : 0
dlwget 'sonnet-index.html';url,'sonnets.html'
)

dlsonnet =: 3 : 0
dlwget ('data/',y);url,y
)

get_sonnets =: 3 : 0
links =. 'sonnet.[IVXLM]+.html' rxall 1!:1 < 'sonnet-index.html'
dlsonnet &> links
)