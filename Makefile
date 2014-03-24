TARGET = hostsd

VERSION = 0.1

TEST_SCRIPTS = $(wildcard tests/*/tests.sh)
TEST_RESULTS = $(TEST_SCRIPTS:tests/%/tests.sh=tests/%/tests.log)

TARGET_RPMS  = $(foreach type, src noarch, $(TARGET)-$(VERSION)-1.$(type).rpm)
TARGET_FILES = $(TARGET) README.html man/$(TARGET).8 $(TARGET).tar.gz shellcheck.xml $(TEST_RESULTS) $(TARGET_RPMS)

prefix  = /usr/local
sbindir = $(prefix)/sbin
mandir  = $(prefix)/share/man
unitdir = $(prefix)/lib/systemd/system

all: check docs

build: $(TARGET)

$(TARGET): $(foreach f, defaults functions main, src/$(TARGET)_$(f).sh)
	: make $@
	@cat $^ > $@
	@chmod +x $@

check: shellcheck.xml $(TEST_RESULTS)

shellcheck.xml: $(TARGET) tests/*.sh $(TEST_SCRIPTS)
	: make $@
	@shellcheck -f checkstyle $^ >$@

$(TEST_RESULTS): $(TEST_SCRIPTS) src/*
	: make $@
	@$< >$@

docs: README.html man

%.html: %.rst
	: make $@
	@rst2html $< $@

man: man/$(TARGET).8

man-show: man
	man -l man/$(TARGET).8

man/%: man/%.rst
	: make $@
	@rst2man $< $@

install: build man
	install -m0755 -d $(DESTDIR)$(sbindir)
	install -m0755 -t $(DESTDIR)$(sbindir) $(TARGET)
	install -m0755 -d $(DESTDIR)$(mandir)/man8
	install -m0644 -t $(DESTDIR)$(mandir)/man8 man/$(TARGET).8
	install -m0755 -d $(DESTDIR)$(unitdir)
	install -m0644 -t $(DESTDIR)$(unitdir) systemd/$(TARGET).service

dist: $(TARGET).tar.gz

$(TARGET).tar.gz:
	: make $@
	@git archive --format=tar.gz --prefix=$(TARGET)-$(VERSION)/ -o $@ HEAD

rpmlint: $(TARGET_RPMS) rpm/$(TARGET).spec
	rpmlint $^

srpm: $(TARGET)-$(VERSION)-1.src.rpm

rpm:  $(TARGET)-$(VERSION)-1.noarch.rpm

%.noarch.rpm: %.src.rpm
	: make $@
	@rpmbuild --quiet --rebuild $< -D'dist %nil'
	@mv $(shell rpm --eval '%_rpmdir')/noarch/$@ .

$(TARGET)-$(VERSION)-1.src.rpm: rpm/$(TARGET).spec dist
	: make $@
	@rpmbuild --quiet -bs $< \
		-D'_sourcedir $(PWD)' \
		-D'_srcrpmdir $(PWD)' \
		-D'version $(VERSION)' \
		-D'dist %nil'

$(TARGET_RPMS): dist

dry-run: $(TARGET)
	./$(TARGET) -f /dev/stdout -p dry-run.pid

.PHONY: clean install $(TARGET).tar.gz

clean:
	: make $@
	@rm -f $(TARGET_FILES)
