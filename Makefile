.PHONY : clean run sonnets

run :
	jconsole jitters.ijs -js "exit echo jitters ''"

data :
	mkdir -p $@

sonnets : data
	jconsole $@.ijs -js "exit parse_sonnets dlsonnets ''"

clean :
	find . -name "*~" -exec rm {} \;

