FROM				python:3.6-slim

RUN					rm -rf /etc/collectd && \
				    mkdir -p /etc/collectd/collectd.conf.d && \
					mkdir -p /opt/collectd/

COPY				config/collectd.conf.j2 /etc/collectd/collectd.conf.j2
COPY				config/logging.conf.j2 /etc/collectd/logging.conf.j2
COPY				config/collectd.conf.d /etc/collectd/collectd.conf.d
COPY				scripts/run.sh /opt/collectd/run.sh


RUN					apt-get update && \
                    apt-get install -y --no-install-recommends collectd dos2unix util-linux && \
					pip install collectd j2cli && \
					dos2unix /opt/collectd/run.sh && \
					find /etc/collectd -type f -name '*.j2' -exec dos2unix "{}" \; && \
					apt-get remove -y --purge dos2unix && \
					apt-get auto-remove -y && \
					rm -rf /var/lib/apt/lists/*

ENTRYPOINT			["/opt/collectd/run.sh"]
					