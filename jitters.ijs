coclass 'jitters'
NB. useful resource: http://www.cs.ukzn.ac.za/~hughm/os/notes/ncurses.html#using
load 'api/ncurses'
coinsert 'ncurses'

pal =: 1,COLOR_WHITE,COLOR_BLACK,2,COLOR_WHITE,COLOR_RED,3,COLOR_BLUE,COLOR_BLACK

beg =: 3 : 0
9!:1 <. 1000000 * 1 | 6!:1 ''
nodelay`keypad`:0 (1{a.) ;~ stdscr =: initscr ''
start_color`raw`noecho`cbreak`clear`:0 ''
_3 init_pair\ pal
'INPUT TIME0 NEED_ENDWIN' =: '' ; 0 ; 1
addstr PROMPT =: 1!:1 SONNET =: ({~ ?@#) 1 dir 'data/sonnet.*.txt'
STATBAR =: 1 + +/ LF = PROMPT
(LF,~(": 6!:0 ''),~':  ',~_4}.5}.>SONNET) 1!:3 < jpath '~/.jitter'
y [ draw ''
)

NB. keys get appended here to input. this will be compared with PROMPT
NB. and various status information will be displayed somewhere and
NB. colors will indicate mistakes.
INPUT =: ''

popch =: 3 : 0
INPUT =: }: INPUT
attron COLOR_PAIR 1
move pos ''
addstr ,: PROMPT {~ #INPUT
attroff COLOR_PAIR 1
)

putch =: 3 : 0
ok =. y = PROMPT {~ n =. #INPUT
mode =. 2 + ok
attron COLOR_PAIR mode
move pos ''
addstr ,: ok { y,~ n { PROMPT
attroff COLOR_PAIR mode
INPUT =: INPUT,y
)

NB. based on input, determine what ncurses position should
NB. be. multiplying by sign of i fixes column for first row
pos =: 3 : 0
i =. +/ row =. LF = PROMPT {.~ n =. # INPUT
i , n - (*i) * 1 + row i: 1
)

putinfo =: 3 : 0
'off msg' =. y
move 0,~STATBAR+off
addstr msg
clrtoeol ''
)

status =: 3 : 0
if. 0 = n=. #INPUT do. TIME0 =: 6!:1 '' end.
wpm=: 60 * 1r5 * cps=: n % dt =: TIME0 -~ 6!:1 ''
accuracy=: n %~ +/ INPUT= n {. PROMPT
putinfo 0 ; 'chars/sec: ',": cps
putinfo 1 ; 'words/min: ',": wpm
putinfo 2 ; 'accuracy:  ',": 100 * accuracy
putinfo 3 ; 'time:      ',": dt * 0.0001 < dt
putinfo 4 ; 'position:  ',": pos ''
NB. putinfo 5 ; 'sonnet:    ',   SONNET
)

draw=: refresh@move@pos@status

NB. key_f 1 to quit
mid =: 3 : 0
whilst. INPUT <&# PROMPT do.
  if. 0 <: in =: getch '' do.
    if.     in -: 127    do. popch ''
    elseif. in = KEY_F 1 do. break.
    elseif. in < 256     do. putch in{a. end.
  end. 6!:3 (1r200) [ draw '' end.
)

end =: 3 : 0
endwin ^: NEED_ENDWIN y
NEED_ENDWIN =: 0
info =. ('...' ,~ 20 {. PROMPT);cps;wpm;(100*accuracy);dt
hdr =. ;: 'prompt cps wpm acc time'
hdr ,. info
)

NB. wrapping end hides errors
jitters =: end@mid@beg :: end
jitters_z_ =: jitters_jitters_