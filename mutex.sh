#       mutex file
## Open a mutual exclusion lock on the file, unless another process already owns one.
## If the file is already locked by another process, the operation fails.
# This function defines a lock on a file as having a file descriptor open to the file.
# This function uses FD 9 to open a lock on the file. To release the lock, close FD 9:
# exec 9>&-#
mutex() {
    local file=$1 pid pids

    exec 9>>"$file"
    { pids=$(fuser -f "$file"); } 2>&- 9>&-
    for pid in $pids; do
        [[ $pid = $$ ]] && continue

        exec 9>&-
        return 1 # Locked by a pid.
    done }
