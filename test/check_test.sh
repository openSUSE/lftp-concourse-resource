#!/bin/bash

# Given directory listing
# kernel-default-4.9.10-1.1.x86_64.rpm
# kernel-default-4.9.9-1.2.x86_64.rpm

BEFORE="4.9.9-1.2"
LATEST="4.17.14-1.2"

echo "expect empty array if regex does not match"
out=`bash assets/check <<EOF
{
  "source": {
    "url": "https://download.opensuse.org/tumbleweed/repo/oss/x86_64/",
    "regexp": "kernel-defaultnothere-(.*).x86_64.rpm"
  },
  "version": { "ref": "MISSING" }
}
EOF
`
if ! echo "$out" | grep -q "\[\]"; then
  echo "expected: []"
  echo "actual: $out"
  echo "test failed!!!"
  exit 1
fi

echo "expects single version if given can't be found: the last one $LATEST"
out=`bash assets/check <<EOF
{
  "source": {
    "url": "https://download.opensuse.org/tumbleweed/repo/oss/x86_64/",
    "regexp": "kernel-default-(.*).x86_64.rpm"
  },
  "version": { "ref": "MISSING" }
}
EOF
`
if ! echo "$out" | grep -q "$LATEST"; then
  echo "$out"
  echo "Test failed"
fi


echo "expects two version: [ $BEFORE, $LATEST ]"
bash assets/check <<EOF
{
  "source": {
    "url": "https://download.opensuse.org/tumbleweed/repo/oss/x86_64/",
    "regexp": "kernel-default-(.*).x86_64.rpm"
  },
  "version": { "ref": "$BEFORE" }
}
EOF

echo "expects single version if given the current one: $LATEST"
bash assets/check <<EOF
{
  "source": {
    "url": "https://download.opensuse.org/tumbleweed/repo/oss/x86_64/",
    "regexp": "kernel-default-(.*).x86_64.rpm"
  },
  "version": { "ref": "$LATEST" }
}
EOF

echo "expects single version if not given any: latest $LATEST"
bash assets/check <<EOF
{
  "source": {
    "url": "https://download.opensuse.org/tumbleweed/repo/oss/x86_64/",
    "regexp": "kernel-default-(.*).x86_64.rpm"
  }
}
EOF
