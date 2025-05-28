FROM debian:bookworm

ENV CURL_RETRY_OPT='--retry 3 --max-time 180 --retry-max-time 300'

COPY setup_ml.sh /opt/setup_ml.sh
