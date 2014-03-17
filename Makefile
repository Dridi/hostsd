check: shellcheck.xml

shellcheck.xml:
	@shellcheck -f checkstyle hostsd >$@

run:
	./hostsd -f /dev/stdout -p hostsd.pid
