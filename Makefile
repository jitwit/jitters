.PHONY : clean run

run :
	jconsole jitters.ijs -js "exit echo jitters ''"

clean :
	find . -name "*~" -exec rm {} \;

