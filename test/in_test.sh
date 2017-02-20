#!/bin/bash
set -xe
mkdir -p tmp
sh assets/in tmp <<EOF
{
  "source": {
    "url": "http://download.opensuse.org/tumbleweed/repo/oss/suse/x86_64/",
    "regexp": "kernel-default-(.*).x86_64.rpm"
  },
  "version": { "ref": "4.9.9-1.2" }
}
EOF

sh assets/in tmp <<EOF
{
  "source": {
    "url": "http://download.opensuse.org/tumbleweed/repo/oss/suse/x86_64/",
    "regexp": "kernel-default-(.*).x86_64.rpm"
  },
  "version": { "ref": "4.9.10-1.1" }
}
EOF

sh assets/in tmp <<EOF
{
  "source": {
    "url": "http://download.opensuse.org/tumbleweed/repo/oss/suse/x86_64/",
    "regexp": "kernel-default-(.*).x86_64.rpm"
  }
}
EOF
