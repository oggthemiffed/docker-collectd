FROM				python:3.8-alpine

RUN					mkdir -p /etc/collectd/collectd.conf.d && \
					mkdir -p /opt/collectd/ && \
					rm -rf /etc/collectd/*

COPY				config/collectd.conf.j2 /etc/collectd/collectd.conf.j2
COPY				config/logging.conf.j2 /etc/collectd/logging.conf.j2
COPY				config/collectd.conf.d /etc/collectd/collectd.conf.d
COPY				scripts/run.sh /opt/collectd/run.sh


RUN					apk add --no-cache collectd collectd-python dos2unix util-linux && \
					pip install collectd j2cli && \
					dos2unix /opt/collectd/run.sh && \
					find /etc/collectd -type f -name '*.j2' -exec dos2unix "{}" \; && \
					apk del dos2unix

ENTRYPOINT			["sh", "/opt/collectd/run.sh"]
					
