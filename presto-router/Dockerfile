FROM quay.io/centos/centos:stream9

ARG PRESTO_VERSION
ARG PRESTO_PKG=presto-server-$PRESTO_VERSION.tar.gz
ARG PRESTO_ROUTER_PKG=presto-router-$PRESTO_VERSION.tar.gz
ARG JMX_PROMETHEUS_JAVAAGENT_VERSION=0.20.0

RUN dnf install -y java-11-openjdk wget tar gzip git jq make python3.11 python3-pip sudo procps-ng && \
    dnf clean all && \
    mkdir -p /usr/lib/jvm && \
    ln -s /usr/bin/python3 /usr/bin/python

COPY PRESTO_ROUTER_PKG /opt/

RUN tar -xf /opt/presto-router-$PRESTO_VERSION.tar.gz -C /opt && \
    rm /opt/presto-router-$PRESTO_VERSION.tar.gz && \
    mv /opt/presto-router-$PRESTO_VERSION /opt/presto && \
    mkdir /opt/presto/plugin && \
    mkdir /opt/presto/etc

COPY PRESTO_PKG /opt/

RUN tar -xf /opt/presto-server-$PRESTO_VERSION.tar.gz -C /opt && \
    rm /opt/presto-server-$PRESTO_VERSION.tar.gz && \
    mv /opt/presto-server-$PRESTO_VERSION /opt/presto-server && \
    mv /opt/presto-server/plugin/password-authenticators /opt/presto/plugin/password-authenticators && \
    rm -rf /opt/presto-server && \
    chmod -R 777 /opt/presto

COPY etc /opt/presto/etc
COPY entrypoint.sh /opt/presto/entrypoint.sh

RUN sh -c 'wget -P /opt/presto/lib https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${JMX_PROMETHEUS_JAVAAGENT_VERSION}/jmx_prometheus_javaagent-${JMX_PROMETHEUS_JAVAAGENT_VERSION}.jar -q'

ENTRYPOINT ["/opt/presto/entrypoint.sh"]
USER 1001