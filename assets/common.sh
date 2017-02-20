parse_source_config() {
  URL=$(jq -r '.source.url // "https://download.opensuse.org"' $payload)
  REGEXP=$(jq -r '.source.regexp // ""' $payload)
  VERSION=$(jq -r '.version.ref // ""' $payload)
}

get_listing() {
  GLOB=$(echo "$REGEXP" | sed 's/(.*)/*/')
  LISTING=$(lftp -c "open $URL; cls -1 $GLOB")
}

parse_versions() {
  REG=$(echo "$REGEXP" | sed -e 's/\./\\./g' -e 's/(.*)/\\([0-9.-]*\\)/')
  FOUND_VERSIONS=$(echo $LISTING | sed -ne "s/$REG/\1/p")
}

