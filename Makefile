.PHONY : clean run

run :
	jconsole jitters.ijs -js "exit echo_z_ main ''"

clean :
	find . -name "*~" -exec rm {} \;

