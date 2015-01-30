VERSION = 0.3.2

PREFIX = /usr/local
PROGRAM = sassdocify

BIN = bin/$(PROGRAM)
MAN = man/man1/$(PROGRAM).1

RONN = bundle exec ronn --warnings

export RONN_MANUAL = SassDoc Manual
export RONN_ORGANIZATION = $(PROGRAM) $(VERSION)

all: man

man: $(MAN) $(MAN).html

clean:
	rm -f $(MAN) $(MAN).html

version:
	sed -i 's/VERSION=.*/VERSION=$(VERSION)/' $(BIN)
	sed -i 's/"version": .*/"version": "$(VERSION)",/' package.json
	$(MAKE) clean all

.SUFFIXES: .ronn
.ronn:
	$(RONN) --roff $<

.SUFFIXES: .html
.ronn.html:
	$(RONN) --html --style toc $<

install: all
	install -m 755 -d $(DESTDIR)$(PREFIX)/bin
	install -m 755 $(BIN) $(DESTDIR)$(PREFIX)/bin
	install -m 755 -d $(DESTDIR)$(PREFIX)/share/man/man1
	install -m 644 $(MAN) $(DESTDIR)$(PREFIX)/share/man/man1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/$(BIN)
	rm -f $(DESTDIR)$(PREFIX)/share/$(MAN)
