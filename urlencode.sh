urlencode() {
    local s="$1"
    local c rest

    while [ -n "$s" ]; do
        rest=${s#?}
        c=${s%%"$rest"}
        s="$rest"
        case "$c" in
            [a-zA-Z0-9]) printf "%s" "$c"
                ;;
            *) printf "%%%02X" "'$c"
        esac
    done
}

# vim:shiftwidth=4:softtabstop=4:expandtab:
