#shellcheck shell=ksh
if [ "$SHELLSPEC_COVERAGE_KSH_WORKAROUND" = "strict" ]; then
  trap '(ulimit -t unlimited; echo "kcov@${.sh.file}@${LINENO}@" >/dev/fd/$KCOV_BASH_XTRACEFD)' DEBUG
else
  trap '(echo "kcov@${.sh.file}@${LINENO}@" >/dev/fd/$KCOV_BASH_XTRACEFD; set -- "$IFS"; unset IFS; IFS=$1)' DEBUG
fi