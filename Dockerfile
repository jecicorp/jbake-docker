FROM openjdk:8-jre

LABEL from="openjdk:8-jre"
LABEL maintainer="Jeremie Lesage <jeremie.lesage@jeci.fr>"
LABEL vendor="jeci.fr"


ENV JBAKE_VERSION=2.5.1 \
    JBAKE_SHA1=91c00c4eb94a25ca11b6f72792e8ed02707f57bc \
    JBAKE_DATA="/data"

RUN curl -sSL https://dl.bintray.com/jbake/binary/jbake-${JBAKE_VERSION}-bin.zip \
         -o /root/jbake-bin.zip \
    && echo "$JBAKE_SHA1  /root/jbake-bin.zip" | sha1sum --status -c - \
    && unzip /root/jbake-bin.zip -d /opt \
    && rm /root/jbake-bin.zip \
    && chmod 755 /opt/jbake-$JBAKE_VERSION/bin/*

ENV JBAKE_HOME /opt/jbake-$JBAKE_VERSION
ENV PATH $JBAKE_HOME/bin:$PATH

RUN mkdir -p "/data"
WORKDIR "$JBAKE_DATA"
RUN jbake -i

VOLUME "$JBAKE_DATA"
EXPOSE 8820

ENTRYPOINT ["jbake"]
CMD ["-b", "-s"]
