#!/bin/bash
set -e
find /etc/collectd -type f -name '*.j2' -exec sh -c 'j2 -o "${0%.j2}" $0' {} \; -exec sh -c 'rm -f $0' {} \;