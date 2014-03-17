build: hostsd

hostsd: hostsd_defaults.sh hostsd_functions.sh  hostsd_main.sh
	: make $@
	@cat $^ > $@
	@chmod +x $@

check: shellcheck.xml

shellcheck.xml: hostsd
	: make $@
	@shellcheck -f checkstyle hostsd >$@

run: hostsd
	./hostsd -f /dev/stdout -p hostsd.pid

.PHONY: clean

clean:
	: make $@
	@rm hostsd shellcheck.xml
