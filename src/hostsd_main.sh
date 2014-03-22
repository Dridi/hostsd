while getopts d:f:hp: opt
do
	case "$opt" in
	d) HOSTSD_DIR="$OPTARG";;
	f) HOSTS_FILE="$OPTARG";;
	p) PIDFILE="$OPTARG";;
	*) usage ;;
	esac
done

setup_env

trap clean_env EXIT SIGTERM

create_hosts_file "$HOSTSD_DIR" "$HOSTS_FILE"

while true
do
	watch_files "$HOSTSD_DIR"
	create_hosts_file "$HOSTSD_DIR" "$HOSTS_FILE"
	wait
done
