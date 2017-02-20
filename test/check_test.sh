#!/bin/bash

# Given directory listing
# kernel-default-4.9.10-1.1.x86_64.rpm
# kernel-default-4.9.9-1.2.x86_64.rpm

BEFORE="4.9.9-1.2"
LATEST="4.9.10-1.1"

echo "expects single version if given can't be found: the last one $LATEST"
bash assets/check <<EOF
{
  "source": {
    "url": "https://download.opensuse.org/tumbleweed/repo/oss/suse/x86_64/",
    "regexp": "kernel-default-(.*).x86_64.rpm"
  },
  "version": { "ref": "MISSING" }
}
EOF

echo "expects two version: [ $BEFORE, $LATEST ]"
bash assets/check <<EOF
{
  "source": {
    "url": "https://download.opensuse.org/tumbleweed/repo/oss/suse/x86_64/",
    "regexp": "kernel-default-(.*).x86_64.rpm"
  },
  "version": { "ref": "$BEFORE" }
}
EOF

echo "expects single version if given the current one: $LATEST"
bash assets/check <<EOF
{
  "source": {
    "url": "https://download.opensuse.org/tumbleweed/repo/oss/suse/x86_64/",
    "regexp": "kernel-default-(.*).x86_64.rpm"
  },
  "version": { "ref": "$LATEST" }
}
EOF

echo "expects single version if not given any: latest $LATEST"
bash assets/check <<EOF
{
  "source": {
    "url": "https://download.opensuse.org/tumbleweed/repo/oss/suse/x86_64/",
    "regexp": "kernel-default-(.*).x86_64.rpm"
  }
}
EOF
