NB. a typing game?
NB. useful resource: http://www.cs.ukzn.ac.za/~hughm/os/notes/ncurses.html#using
load 'api/ncurses'
coinsert 'ncurses'

NB. press enter to start? exit when match prompt
NEED_ENDWIN =: 1
TIME0 =: 0
nada =: 0

NB. the game states
'READY RUN DONE EXIT'=: i. 4

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

NB. keys get appended here to input. this will be compared with PROMPT
NB. and various status information will be displayed somewhere and
NB. colors will indicate mistakes.
INPUT =: ''

NB. to draw with flare, logical or target flare with char
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

status =: 3 : 0
n=. #INPUT
if. 0=n do. TIME0 =: 6!:1 '' end.
dt =: TIME0 -~ 6!:1 ''
move 20 0
addstr 'chars/sec: ',": charssec=: n % dt
clrtoeol''
move 21 0
addstr 'accuracy: ', '%',~ ": 100 * accuracy=: n %~ +/INPUT=n{.PROMPT
clrtoeol ''
move 22 0
addstr 'input size: ',": n
clrtoeol ''
move 23 0
addstr 'position: ',": y
clrtoeol ''
)

draw =: 3 : 0
status xy =. pos ''
move xy
refresh''
)


NB. initscr must be called first
NB. cbreak? to get char at time input
NB. noecho to supress typed chars echoing
NB. keypad stdscr;1{a. to use backspace, delete, arrows
NB. endwin call to restore terminal

beg =: 3 : 0
NB. 'clear' is a macro that implicitly passes '' to wclear
NB. stdscr;''. Same for many of the other ncurses verbs.
NB. want nodelay, will have to check for new input expliciltly
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
INPUT =: ''
nada =: 0
draw''
)

NB. key_f 1 to quit
mid =: 3 : 0
whilst. (INPUT <&# PROMPT) *. in ~: KEY_F 1 do.
  if. 0 <: in =: getch ''
  do. if. 127 -: in NB. not KEY_BACKSPACE?
      do. popch ''
      elseif. in < 256 do. putch in{a. end. end.
  draw ''
  6!:3 (0.001)
end.
)

end =: 3 : 0
endwin ^: NEED_ENDWIN y
NEED_ENDWIN =: 0
)

main =: 3 : 0
beg '' NB. will wrap (beg :: end), but this hides errors
mid ''
end ''
)