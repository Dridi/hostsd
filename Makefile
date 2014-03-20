TARGET = hostsd

VERSION = 0.1

TEST_SCRIPTS = $(wildcard tests/*/tests.sh)
TEST_RESULTS = $(TEST_SCRIPTS:tests/%/tests.sh=tests/%/tests.log)

TARGET_RPMS  = $(foreach type, src noarch, $(TARGET)-$(VERSION)-1.$(type).rpm)
TARGET_FILES = $(TARGET) $(TARGET).tar.gz shellcheck.xml $(TEST_RESULTS) $(TARGET_RPMS)

all: check man

build: $(TARGET)

$(TARGET): hostsd_defaults.sh hostsd_functions.sh  hostsd_main.sh
	: make $@
	@cat $^ > $@
	@chmod +x $@

check: shellcheck.xml $(TEST_RESULTS)

shellcheck.xml: $(TARGET) tests/*.sh $(TEST_SCRIPTS)
	: make $@
	@shellcheck -f checkstyle $^ >$@

$(TEST_RESULTS): $(TEST_SCRIPTS) hostsd_*.sh
	: make $@
	@$< >$@

man: $(TARGET).8

$(TARGET).8:
	: TODO make $@

dist: $(TARGET).tar.gz

$(TARGET).tar.gz:
	: make $@
	@git archive --format=tar.gz --prefix=$(TARGET)-$(VERSION)/ -o $@ HEAD

srpm: $(TARGET)-$(VERSION)-1.src.rpm

rpm:  $(TARGET)-$(VERSION)-1.noarch.rpm

%.noarch.rpm: %.src.rpm
	: make $@
	@rpmbuild --quiet --rebuild $< -D'dist %nil'
	@mv $(shell rpm --eval '%_rpmdir')/noarch/$@ .

$(TARGET)-$(VERSION)-1.src.rpm: $(TARGET).spec dist
	: make $@
	@rpmbuild --quiet -bs $< \
		-D'_sourcedir $(PWD)' \
		-D'_srcrpmdir $(PWD)' \
		-D'version $(VERSION)' \
		-D'dist %nil'

$(TARGET_RPMS): dist

dry-run: $(TARGET)
	./$(TARGET) -f /dev/stdout -p dry-run.pid

.PHONY: clean $(TARGET).tar.gz

clean:
	: make $@
	@rm -f $(TARGET_FILES)
