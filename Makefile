.PHONY : clean run sonnets

run :
	jconsole jitters.ijs -js \
		"shakespath_jitters_ =: jcwdpath'data'" \
		"jitters ''" \
		"exit 0"

data :
	mkdir -p $@

sonnets : data
	jconsole $@.ijs -js "exit parse_sonnets dlsonnets ''"

clean :
	find . -name "*~" -exec rm {} \;

