FROM openjdk:11-jre
MAINTAINER Jeremie Lesage <jeremie.lesage@gmail.com>

ENV JBAKE_VERSION=2.6.4 \
    JBAKE_SHA1=df6926721202e036f84079b830859d176a2c1a32 \
    JBAKE_DATA="/data"

RUN curl -sSL https://dl.bintray.com/jbake/binary/jbake-${JBAKE_VERSION}-bin.zip \
         -o /root/jbake-bin.zip \
    && echo "$JBAKE_SHA1  /root/jbake-bin.zip" | sha1sum --status -c - \
    && unzip /root/jbake-bin.zip -d /opt \
    && rm /root/jbake-bin.zip

ENV JBAKE_HOME /opt/jbake-$JBAKE_VERSION-bin/
ENV PATH $JBAKE_HOME/bin:$PATH

RUN mkdir -p "/data"
WORKDIR "$JBAKE_DATA"
RUN jbake -i

VOLUME "$JBAKE_DATA"
EXPOSE 8820

ENTRYPOINT ["jbake"]
CMD ["-b -s"]
