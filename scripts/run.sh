#!/bin/bash
set -e

# dos2unix everything
find /opt/collectd/scripts -type f \( -iname \* \) -exec dos2unix {} + 
find /opt/collectd/scripts -type f \( -iname \*.conf -o -iname \*.j2 \) -exec dos2unix {} + 

# Detect requirements.txt and run if needed
find /opt/collectd/scripts -type f \( -iname requirements\*.txt \) -exec pip install -r {} +

# Copy over the extra files that we might have
find /opt/collectd/extra-configs -type f \( -iname \*.conf -o -iname \*.j2 \) -exec cp /etc/collectd/collectd.conf.d {} + 

find /etc/collectd -type f -iname '*.j2' -exec sh -c 'j2 -o "${0%.j2}" $0' {} \; -exec sh -c 'rm -f $0' {} \;

collectd -f