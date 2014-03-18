export TEST_DIR="$(dirname "$0")"

th_mktemp() {
	TMPDIR="$SHUNIT_TMPDIR" mktemp "$@"
}
