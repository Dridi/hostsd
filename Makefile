TARGET = hostsd

TEST_SCRIPTS = $(wildcard tests/*/tests.sh)
TEST_RESULTS = $(TEST_SCRIPTS:tests/%/tests.sh=tests/%/tests.log)

TARGET_FILES = $(TARGET) $(TARGET).tar.gz shellcheck.xml $(TEST_RESULTS)

all: check

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

dist: $(TARGET).tar.gz

$(TARGET).tar.gz:
	: make $@
	@git archive --format=tar.gz --prefix=hostsd/ -o hostsd.tar.gz HEAD

dry-run: $(TARGET)
	./$(TARGET) -f /dev/stdout -p dry-run.pid

.PHONY: clean $(TARGET).tar.gz

clean:
	: make $@
	@rm -f $(TARGET_FILES)
