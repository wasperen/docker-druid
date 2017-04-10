FROM centos:7
MAINTAINER willem@van.asperen.org Willem van Asperen

ENV DRUID_HOME /opt/druid

# core OS dependencies and configuration
RUN yum -y update \
    && yum -y install \
      java-1.8.0-openjdk

RUN rm /etc/localtime && \
    ln -s /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime && \
    localedef --quiet -c -i en_US -f UTF-8 en_US.UTF-8

# user
RUN mkdir /opt/druid \
    && useradd -ms /bin/bash -d ${DRUID_HOME} druid 

ADD entrypoint.sh ${DRUID_HOME}/entrypoint.sh

# install druid
RUN cd /tmp \
    && curl -O http://static.druid.io/artifacts/releases/druid-0.9.2-bin.tar.gz \
    && tar xzf druid-0.9.2-bin.tar.gz \
    && mv druid-0.9.2 ${DRUID_HOME} \
    && ln -s ${DRUID_HOME}/druid-0.9.2 ${DRUID_HOME}/current \
    && chmod +x ${DRUID_HOME}/entrypoint.sh \
    && chown druid: -R ${DRUID_HOME}

EXPOSE 8090

USER druid
WORKDIR ${DRUID_HOME}/current
ENTRYPOINT ["../entrypoint.sh"]