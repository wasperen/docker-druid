FROM centos:7
MAINTAINER willem@van.asperen.org Willem van Asperen

# dependencies
RUN yum update \
    && yum install \
      curl \
      java-1.8.0-openjdk

# user
RUN mkdir /opt/druid \
    && useradd --home-dir /opt/druid \
    && chown druid: -R /opt/druid \

# install druid
RUN cd /tmp \
    && curl -O http://static.druid.io/artifacts/releases/druid-0.9.2-bin.tar.gz \
    && tar xzf druid-0.9.2-bin.tar.gz \
    && mv druid-0.9.2 /opt/druid \
    && ln -s /opt/druid/druid-0.9.2 /opt/druid/current

WORKDIR /opt/druid
ADD entrypoint.sh
ADD conf/ current/conf

ENTRYPOINT /opt/druid/entrypoint.sh
