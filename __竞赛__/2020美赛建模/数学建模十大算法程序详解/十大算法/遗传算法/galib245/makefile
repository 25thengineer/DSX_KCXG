# Makefile for GAlib
# Copyright (c) 1996-1999 Matthew Wall, all rights reserved

VERSION=2.4.5
VER=245

all:
	cd ga; make
	cd examples; make

install:
	cd ga; make install

clean:
	cd ga; make clean
	cd examples; make clean



# This stuff is for managing galib releases.  You probably will not have to 
# use any of these rules.

RELDIR=../galib-releases/galib$(VER)
TMPDIR=/var/tmp
ARCDIR=/home/mbwall/archives

version:
	perl -pi -e 's/Revision: \S+/Revision: $(VERSION)/' ga/gaversion.h
	perl -pi -e 'chop($$dt = `date +"%Y/%m/%d %T"`); s/Date: \S+ \S+/Date: $$dt/' ga/gaversion.h

release: clean version
	rm -rf $(RELDIR)
	mkdir -p $(RELDIR)
	cp -rp * $(RELDIR)
	echo $(VERSION) > $(RELDIR)/VERSION
	rm -rf $(RELDIR)/CVS
	rm -rf $(RELDIR)/doc/CVS
	rm -rf $(RELDIR)/doc/images/CVS
	rm -rf $(RELDIR)/ga/CVS
	rm -rf $(RELDIR)/examples/CVS
	rm -rf $(RELDIR)/examples/graphic/CVS
	rm -rf $(RELDIR)/examples/graphic/bitmaps/CVS
	rm -rf $(RELDIR)/examples/gnu/CVS
	rm -rf $(RELDIR)/examples/pvmind/CVS
	rm -rf $(RELDIR)/examples/pvmpop/CVS
	@echo "  GAlib $(VERSION) has been released"

archive:
	mkdir $(TMPDIR)/galib-`date +"%y%m%d"`
	cp -rp COPYRIGHT LICENSE README\
 makefile makevars makefile.win32 makevars.win32\
 ga examples doc $(TMPDIR)/galib-`date +"%y%m%d"`
	cd $(TMPDIR);\
 tar cvf galib-`date +"%y%m%d"`.tar galib-`date +"%y%m%d"`;\
 gzip galib-`date +"%y%m%d"`.tar;\
 mv galib-`date +"%y%m%d"`.tar.gz $(ARCDIR);\
 rm -rf galib-`date +"%y%m%d"`
	@echo "archive has been made as"
	@echo "   $(ARCDIR)/galib-`date +"%y%m%d"`.tar.gz"
