coclass 'jitters'
load 'api/ncurses'
coinsert 'ncurses'

pal =: 1,COLOR_WHITE,COLOR_BLACK,2,COLOR_WHITE,COLOR_RED,3,COLOR_BLUE,COLOR_BLACK
shakespath =: jpath '~addons/games/jitters/data'

beg =: 3 : 0
9!:1 <. 1000000 * 1 | 6!:1 ''
nodelay`keypad`:0 (1{a.) ;~ stdscr =: initscr TIMES =: INPUT =: ''
start_color`raw`noecho`cbreak`clear`:0 ''
_3 init_pair\ pal
SONNET =: ({~ ?@#) 1 dir shakespath,'/*.txt'
addstr PROMPT =: 1!:1 SONNET
STATBAR =: 1 + +/ LF = PROMPT
y [ draw ''
)

popch =: 3 : 0
INPUT =: }: INPUT
TIMES =: }: TIMES
attroff COLOR_PAIR 1
addstr,:PROMPT{~#INPUT[move pos ''
attron COLOR_PAIR 1
)

putch =: 3 : 0
mode =. 2 + ok =. y = PROMPT {~ n =. #INPUT
attron COLOR_PAIR mode
addstr ,: ok { y,~ n { PROMPT[move pos ''
attroff COLOR_PAIR mode
INPUT =: INPUT,y
TIMES =: TIMES,6!:1''
)

NB. based on input, determine what ncurses position should
NB. be. multiplying by sign of i fixes column for first row
pos =: 3 : 0
i =. +/ row =. LF = PROMPT {.~ n =. # INPUT
i , n - (*i) * 1 + row i: 1
)

putinfo =: 3 : 0
clrtoeol ''[addstr msg[move 0,~STATBAR+off['off msg' =. y
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
)

draw=: refresh@move@pos@status

NB. key_f 1 to quit
mid =: 3 : 0
whilst. INPUT <&# PROMPT do.
  if. 0 <: in =: getch '' do.
    if.     in -: 127    do. popch ''
    elseif. in = KEY_F 1 do. break.
    elseif. in < 256     do. putch in{a. end.
  end.  6!:3 ] 1r200 [ draw ''
end.
)

end =: 3 : 0
log =. < jpath '~user/temp/jitter.txt'
stamp =. < jpath '~user/temp/jitter_stamp.txt'
log 1!:3~ ((":6!:0''),TAB,(":wpm),TAB,(":100*accuracy),LF)
endwin ''
info =. (>SONNET);cps;wpm;(100*accuracy);dt
echo_z_ info ,.~ ;: 'sonnet cps wpm acc time'
stamp 1!:2~ ":TIMES
)

jitters =: end@mid@beg :: end
jitters_z_ =: jitters_jitters_
