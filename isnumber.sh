only_digits() {
    case "$1" in
	''|*[!0-9]*) return 1
	    ;;
	*) return 0
    esac
}

is_integer() {
    only_digits ${1#[+-]}
}

is_float() {
    case ${1#[+-]} in
	''|*[!0-9.]*|'.'|*.*.*) return 1
	    ;;
	*) return 0
    esac
}
