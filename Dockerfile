FROM				python:3-slim

RUN					apt-get update && \
					apt-get upgrade -y --no-install-recommends  && \
                    apt-get install -y --no-install-recommends collectd dos2unix util-linux && \
					pip install collectd j2cli && \
					rm -rf /etc/collectd

RUN				    mkdir -p /etc/collectd/collectd.conf.d && \
					mkdir -p /opt/collectd/ && \
					mkdir -p /opt/collectd/extra-configs

COPY				config/collectd.conf.j2 /etc/collectd/collectd.conf.j2
COPY				config/logging.conf.j2 /etc/collectd/logging.conf.j2
COPY				config/collectd.conf.d /etc/collectd/collectd.conf.d
COPY				config/output.conf.d /etc/collectd/output.conf.d
COPY				scripts/run.sh /opt/collectd/run.sh

RUN					dos2unix /opt/collectd/run.sh && \
					apt-get remove -y --purge dos2unix && \
					apt-get auto-remove -y && \
					rm -rf /var/lib/apt/lists/*

VOLUME				[ "/opt/collectd/extra-configs", "/data", "/opt/collectd/scripts"]

ENV 				COLLECTD_CSV_OUTPUT="true"
ENV 				COLLECTD_GRAPHITE_OUTPUT="false"
ENV 				COLLECTD_ENABLE_LOG_FILE='false'

ENTRYPOINT			["/opt/collectd/run.sh"]
					