# Makefile to run make in all subdirectories containing a Makefile.

SUBDIRS	:= $(wildcard */.)

all:
# No alpha, opaque bit set, LZ77 compression, 16-bit bitmap, ASM only (no header).
	grit topscreen.png -W1 -gT! -gzl -gB16 -gb -fts -fh!
	@for dir in $(SUBDIRS); do if test -e $$dir/Makefile ; then $(MAKE) -C $$dir || { exit 1;} fi; done;


clean:
	@rm topscreen.s
	@for dir in $(SUBDIRS); do if test -e $$dir/Makefile ; then $(MAKE)  -C $$dir clean || { exit 1;} fi; done;
