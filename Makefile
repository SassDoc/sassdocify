VERSION = 0.3.3
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
