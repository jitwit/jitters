.PHONY : run clean sonnets

J = jconsole
VERSION = '1.0.11'
CAPTION = 'jitters - a typing experience'
DESCRIPTION = 'ncurses typing experience'
FOLDER = 'games/jitters'
DEPENDS = api/ncurses graphics/plot
FILES = jitters.ijs plot.ijs data/*.txt

run :
	$(J) jitters.ijs -js \
		"shakespath_jitters_ =: jcwdpath'data'" \
		"jitters ''" \
		"exit 0"

data :
	mkdir -p $@

sonnets : data
	jconsole $@.ijs -js "exit parse_sonnets dlsonnets ''"

manifest.ijs : $(FILES)
	echo "VERSION =: $(VERSION)" > $@
	echo "CAPTION =: $(CAPTION)" >> $@
	echo "DESCRIPTION =: $(DESCRIPTION)" >> $@
	echo "FOLDER =: $(FOLDER)" >> $@
	echo "FILES =: 0 : 0" >> $@
	echo "DEPENDS =: 0 : 0" >> $@
	(for x in $(DEPENDS); do echo $$x >> $@; done)
	echo ")" >> $@
	(for x in $?; do echo $$x >> $@; done)
	echo ")" >> $@

clean :
	find . -name "*~" -exec rm {} \;
	find . -name "*.html" -exec rm {} \;
