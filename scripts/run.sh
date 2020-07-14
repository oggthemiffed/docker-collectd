#!/bin/bash
set -e

# Copy over the extra files that we might have
find /opt/collectd/extra-configs -type f \( -iname \*.conf -o -iname \*.j2 \) -exec mv -t /etc/collectd/collectd.conf.d {} + 

find /etc/collectd -type f -iname '*.j2' -exec sh -c 'j2 -o "${0%.j2}" $0' {} \; -exec sh -c 'rm -f $0' {} \;

collectd -f 