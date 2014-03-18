#!/bin/sh

. "$PWD"/hostsd_functions.sh
. "$PWD"/tests/helpers.sh

test_find_files() {
	local result_file=$(th_mktemp)
	find_files "$TEST_DIR/hosts.d" >"$result_file"
	assertTrue "Wrong file listing" "diff -u '$TEST_DIR/files' '$result_file'"
}

test_merge_files() {
	local result_file=$(th_mktemp)
	merge_files "$TEST_DIR/hosts.d" <"$TEST_DIR/files" >"$result_file"
	assertTrue "Wrong hosts file" "diff -u '$TEST_DIR/hosts' '$result_file'"
}

test_create_hosts_file() {
	local result_file=$(th_mktemp)
	create_hosts_file "$TEST_DIR/hosts.d" "$result_file"
	assertTrue "Wrong hosts file" "diff -u '$TEST_DIR/hosts' '$result_file'"
}

. /usr/share/shunit2/shunit2
