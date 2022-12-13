# Makefile to run make in all subdirectories containing a Makefile.

SUBDIRS	:= $(wildcard */.)

all:
	@for dir in $(SUBDIRS); do if test -e $$dir/Makefile ; then $(MAKE) -C $$dir || { exit 1;} fi; done;


clean:
	@for dir in $(SUBDIRS); do if test -e $$dir/Makefile ; then $(MAKE)  -C $$dir clean || { exit 1;} fi; done;
