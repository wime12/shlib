# Customize the following lines if needed

PREFIX=/usr/local

SHLIB=$(PREFIX)/share/shlib

# END of custom lines

install:
	test -d $(SHLIB) || mkdir -p $(SHLIB)
	install -m 0644 *.sh $(SHLIB)

.PHONY: install
