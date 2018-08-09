parse_source_config() {
  URL=$(jq -r '.source.url // "https://download.opensuse.org"' $payload)
  REGEXP=$(jq -r '.source.regexp // ""' $payload)
  VERSION=$(jq -r '.version.ref // ""' $payload)
  POSIX_REGEXP=$(jq -r '.source.posix_regexp // ""' $payload)
}

get_listing() {
  if [ -n ${POSIX_REGEXP} ]; then
    GLOB="*"
  else
    GLOB=$(echo "$REGEXP" | sed 's/(.*)/*/')
  fi
  LISTING=$(lftp -c "open $URL; set cmd:cls-default ''; cls -1 $GLOB")
}

parse_versions() {
  if [ -n ${POSIX_REGEXP} ]; then
    FOUND_VERSIONS=""
    if [[ $LISTING =~ ${POSIX_REGEXP} ]]; then
      FOUND_VERSIONS=${BASH_REMATCH[1]}
    fi
  else
    REG=$(echo "$REGEXP" | sed -e 's/\./\\./g' -e 's/(.*)/\\([0-9.-]*\\)/')
    FOUND_VERSIONS=$(echo $LISTING | sed -ne "s/$REG/\1/p")
  fi
}
