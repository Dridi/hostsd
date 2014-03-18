usage() {
	cat >&2 <<-EOF
	hostsd - Hosts file updater dameon

	Usage: $0 [-d HOSTSD_DIR] [-f HOSTS_FILE] [-p PIDFILE]
	       $0 -h
	EOF
	return 1
}

watch_files() {
	inotifywait "$1" >/dev/null 2>&1
}

find_files() {
	find "$1" -maxdepth 1 -type f -printf '%f\n' | sort
}

merge_files() {
	local first=1

	while read -r file
	do
		[ $first = 1 ] && first=0 || echo

		echo "#[$file]"
		cat "$1/$file"
		echo "#[/$file]"
	done
}

create_hosts_file() {
	find_files "$1" | merge_files "$1" > "$2"
}

setup_env() {
	echo $$ >"$PIDFILE"
}

clean_env() {
	rm "$PIDFILE"
}
