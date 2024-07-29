FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV TERM=screen-256color

RUN groupadd -r scan \
    && useradd --no-log-init -r -g scan scan \
    && mkdir /scan \
    && chown -R scan:scan /scan

RUN apt-get update \
    && apt-get install -yq locales \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN buildDeps='wget' \
    && set -x \
    && apt-get update \
    && apt-get install -yq $buildDeps xmlstarlet \
    && echo "=> Install Kaspersky..." \
    && wget --progress=bar:force -O /opt/kvrt.run https://devbuilds.s.kaspersky-labs.com/kvrt_linux/latest/kvrt.run \
    && chmod +x /opt/kvrt.run \
    && wget --progress=bar:force -O /opt/kvrt.xml https://devbuilds.s.kaspersky-labs.com/kvrt_linux/latest/kvrt.xml \
    && echo "=> Clean up unnecessary files..." \
    && apt-get purge -y --auto-remove $buildDeps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives /tmp/* /var/tmp/*

COPY scan.sh /opt/scan.sh

RUN chmod +x /opt/scan.sh

ENTRYPOINT ["/opt/scan.sh"]
