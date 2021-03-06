#!/bin/sh

set -eu

test || __() { :; }

# shellcheck disable=SC2016
generate() {
  echo "#!/bin/sh -e"
  echo ". \"\$SHELLSPEC_SUPPORT_BIN\""
  echo "invoke $1 \"\$@\""
}

__ main __

if [ ! -e "$SHELLSPEC_SPECDIR" ]; then
  echo "Not a shellspec directory"
  exit 1
fi

mkdir -p "$SHELLSPEC_SUPPORT_BINDIR"

for cmd; do
  bin="$SHELLSPEC_SUPPORT_BINDIR/$cmd"
  if [ -e "$bin" ]; then
    echo "Skip, $cmd already exist (${SHELLSPEC_SUPPORT_BINDIR#"$PWD/"}/$cmd)"
  else
    generate "${cmd#@}" > "$bin"
    chmod +x "$bin"
    echo "Generate $cmd (${bin#"$PWD/"})"
  fi
done
