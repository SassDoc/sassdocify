VERSION = 0.2.2

PREFIX = /usr/local
PROGRAM = sassdocify

BIN = bin/$(PROGRAM)
MAN = man/man1/$(PROGRAM).1

RONN = bundle exec ronn --warnings

export RONN_MANUAL = SassDoc Manual
export RONN_ORGANIZATION = $(PROGRAM) $(VERSION)

all: man README

man: $(MAN) $(MAN).html

clean:
	rm -f $(MAN) $(MAN).html

pages: $(MAN).html
	rm -rf $@
	git clone -b gh-pages . $@
	git -C $@ remote set-url origin "$$(git config --get remote.origin.url)"
	git -C $@ pull
	cp $< $@/index.html
	git -C $@ commit -am 'Update man page'
	git -C $@ push

version:
	sed -i 's/VERSION=.*/VERSION=$(VERSION)/' $(BIN)
	sed -i 's/"version": .*/"version": "$(VERSION)",/' package.json
	$(MAKE) clean all

README: $(MAN)
	MANWIDTH=80 man $(MAN) | cat -s > $@

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
