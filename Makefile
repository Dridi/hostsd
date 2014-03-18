TEST_SCRIPTS = $(wildcard tests/*/tests.sh)
TEST_RESULTS = $(TEST_SCRIPTS:tests/%/tests.sh=tests/%/tests.log)

build: hostsd

hostsd: hostsd_defaults.sh hostsd_functions.sh  hostsd_main.sh
	: make $@
	@cat $^ > $@
	@chmod +x $@

check: shellcheck.xml $(TEST_RESULTS)

shellcheck.xml: hostsd tests/*.sh $(TEST_SCRIPTS)
	: make $@
	@shellcheck -f checkstyle $^ >$@

$(TEST_RESULTS): $(TEST_SCRIPTS) hostsd_*.sh
	: make $@
	@$< >$@

dry-run: hostsd
	./hostsd -f /dev/stdout -p hostsd.pid

.PHONY: clean

clean:
	: make $@
	@rm hostsd shellcheck.xml tests/*/tests.log
