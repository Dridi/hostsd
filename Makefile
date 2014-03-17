check:
	shellcheck hostsd

run:
	./hostsd -f /dev/stdout -p hostsd.pid
