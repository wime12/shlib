_sub() {
  local s_srch rep sr1 sr2

  _SUB=$1

  [ -n "$2" ] || return 1	## nothing to search for: error
  s_srch=${2}			## pattern to replace
  rep=$3			## replacement string
  case $_SUB in
    *$s_srch*)			## if pattern exists in the string
      sr1=${_SUB%%$s_srch*}	## take the string preceding the first match
      sr2=${_SUB#*$s_srch}	## and the string following the first match
      _SUB=$sr1$rep$sr2		## and sandwich the replacement string between them
      ;;
    *) return 1 ;;		## if the pattern does not exist, return error code
  esac
}


sub() {
  _sub "$@" && printf "%s\n" "$_SUB"
}

_rsub() {
  local str s_srch rep sr1 sr2

  str=$1
  [ "$2" ] || return 1
  s_srch=${2}
  rep=$3
  case $str in
    *$s_srch*)
      sr1=${str%$s_srch*}
      sr2=${str##*$s_srch}
      _RSUB=$sr1$rep$sr2
      ;;
    *) _RSUB=
      false ;;
  esac
}

rsub() {
  _rsub "$@" && printf "%s\n" "$_RSUB"
}

_gsub() {
  local sr2 s_srch rep sr1
  ## assign the string to sr2; this will be gobbled up with each substitution
  sr2=$1

  ## return an error if there is no pattern specified
  [ -n "$2" ] || return 1

  ## assign the search pattern to s_srch
  s_srch=${2}

  ## assign the replacement text, if any, to rep
  rep=$3

  ## sr1 will hold the portion of the string that has been processed
  sr1=

  ## loop until sr2 no longer contains the search pattern
  while : ; do
    case $sr2 in
      *$s_srch*)
	## add the string upt to the match,
	## and the replacement text to sr1
	sr1=$sr1${sr2%%$s_srch*}$rep
	## remove up to the match from sr2
	sr2=${sr2#*$s_srch}
	;;
      *) break ;;
    esac
  done
  _GSUB=$sr1$sr2
}

gsub() {
  _gsub "$@" && printf "%s\n" "$_GSUB"
}
