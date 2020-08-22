coclass 'jitters'
NB. useful resource: http://www.cs.ukzn.ac.za/~hughm/os/notes/ncurses.html#using
load 'api/ncurses'
coinsert 'ncurses'

NB. the default prompt. will add functionality to override
PROMPT =: 0 : 0
O Romeo, Romeo, wherefore art thou Romeo?
Deny thy father and refuse thy name.
Or if thou wilt not, be but sworn my love,
And I'll no longer be a Capulet.

'Tis but thy name that is my enemy;
Thou art thyself, though not a Montague.
What's Montague? It is nor hand nor foot,
Nor arm, nor face, nor any other part
Belonging to a man. O be some other name.
What's in a name? That which we call a rose
By any other name would smell as sweet;
So Romeo would, were he not Romeo call'd,
Retain that dear perfection which he owes
Without that title. Romeo, doff thy name,
And for thy name, which is no part of thee,
Take all myself.'
)

NB. will figure out a tolerable way to customize prompt
setprompt =: 3 : 0
select. # y
case. 2 do. PROMPT =: 1!:1 (1 { y)
case. do. end.
)

beg =: 3 : 0
stdscr =: initscr ''
clear ''
start_color ''
init_pair 1, COLOR_WHITE, COLOR_BLACK
init_pair 2, COLOR_WHITE, COLOR_RED
init_pair 3, COLOR_BLUE, COLOR_BLACK
raw''
keypad stdscr;1{a.
noecho''
cbreak''
nodelay stdscr;1{a.
addstr PROMPT
NEED_ENDWIN =: 1
TIME0 =: 0
INPUT =: ''
y [ draw''
)

NB. keys get appended here to input. this will be compared with PROMPT
NB. and various status information will be displayed somewhere and
NB. colors will indicate mistakes.
INPUT =: ''
STATBAR =: 2 + +/ LF = PROMPT

popch =: 3 : 0
INPUT =: (_1 - LF-:{:INPUT) }. INPUT
attron COLOR_PAIR 1
move pos ''
addstr ,: (#INPUT) { PROMPT
attroff COLOR_PAIR 1
)

putch =: 3 : 0
ok =. y = PROMPT {~ n =. #INPUT
mode =. 2 + ok
attron COLOR_PAIR mode
move pos ''
addstr ,: ok { (n{PROMPT),y
attroff COLOR_PAIR mode
INPUT =: INPUT,y
)

NB. based on input, determine what ncurses position should be.
pos =: 3 : 0
i =. +/ row =. LF = PROMPT {.~ n =. # INPUT
i , n - (*i) * 1 + row i: 1
)

putinfo =: 3 : 0
'off msg' =. y
move (STATBAR+off),0
addstr msg
clrtoeol ''
)

status =: 3 : 0
n=. #INPUT
if. 0=n do. TIME0 =: 6!:1 '' end.
wpm=: 60 * 1r5 * cps=: n % dt =: TIME0 -~ 6!:1 ''
accuracy=: n %~ +/INPUT=n{.PROMPT
putinfo 0 ; 'chars/sec:     ',": cps
putinfo 1 ; 'words/min:     ',": wpm
putinfo 2 ; 'accuracy:      ',": 100 * accuracy
putinfo 3 ; 'time elapsed:  ',": dt * 0.0001 < dt
putinfo 4 ; 'position:      ',": pos ''
)

draw=: refresh@move@pos@status

NB. key_f 1 to quit
mid =: 3 : 0
whilst. (INPUT <&# PROMPT) *. in ~: KEY_F 1 do.
  if. 0 <: in =: getch '' NB. 127 not KEY_BACKSPACE?
  do. if. 127 -: in do. popch '' elseif. in < 256 do. putch in{a.
  end. end.
  (6!:3) 1r200 [ draw ''
end. y
)

end =: 3 : 0
endwin ^: NEED_ENDWIN y
NEED_ENDWIN =: 0
info =. ('...' ,~ 20 {. PROMPT); cps;wpm;(100*accuracy);dt
hdr =. (;: 'prompt cps wpm acc time')
hdr ,. info
)

NB. will wrap (_ :: end), but this hides errors
jitters =: end@mid@beg
jitters_z_ =: jitters_jitters_