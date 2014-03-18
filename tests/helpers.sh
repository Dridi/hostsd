export TEST_DIR="$(dirname "$0")"

th_mktemp() {
	TMPDIR="$SHUNIT_TMPDIR" mktemp "$@"
}

th_assertSameFiles() {
	assertTrue "$1" "diff '$2' '$3'"
}
