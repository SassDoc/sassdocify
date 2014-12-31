PREFIX = /usr/local
PROGRAM = sassdocify

BIN = bin/$(PROGRAM)
MAN = man/man1/$(PROGRAM).1

all: man

man: $(MAN) $(MAN).html

pages: $(MAN).html
	rm -rf $@
	git clone -b gh-pages . $@
	cp $< $@/index.html
	cd $@
	git commit -am 'Update man page'
	git push

.SUFFIXES: .ronn
.ronn:
	ronn --warnings --roff $<

.SUFFIXES: .html
.ronn.html:
	ronn --warnings --html --style toc $<

install: all
	install -m 755 -d $(DESTDIR)$(PREFIX)/bin
	install -m 755 $(BIN) $(DESTDIR)$(PREFIX)/bin
	install -m 755 -d $(DESTDIR)$(PREFIX)/share/man/man1
	install -m 644 $(MAN) $(DESTDIR)$(PREFIX)/share/man/man1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/$(BIN)
	rm -f $(DESTDIR)$(PREFIX)/share/$(MAN)
