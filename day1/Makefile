# Makefile to run make in both the part1 and part2 subdirectories.

SUBDIRS	:= part1

all:
	@for dir in $(SUBDIRS); do if test -e $$dir/Makefile ; then $(MAKE) -C $$dir || { exit 1;} fi; done;


clean:
	@for dir in $(SUBDIRS); do if test -e $$dir/Makefile ; then $(MAKE)  -C $$dir clean || { exit 1;} fi; done;
