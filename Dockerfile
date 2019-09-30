FROM openjdk:11-jdk as build

ENV JBAKE_VERSION="master" \
    GRADLE_OPT="--console=plain --no-build-cache --no-daemon"

RUN curl -sSL https://github.com/jbake-org/jbake/archive/$JBAKE_VERSION.zip \
         -o /root/jbake.zip && \
    unzip /root/jbake.zip -d /opt && \
    rm /root/jbake.zip

WORKDIR /opt/jbake-$JBAKE_VERSION/

RUN ./gradlew ${GRADLE_OPT} --version
RUN ./gradlew ${GRADLE_OPT} build -x test
RUN ./gradlew ${GRADLE_OPT} installDist

FROM openjdk:11-jre
ENV JBAKE_VERSION="master"

ENV JBAKE_HOME="/opt/jbake/" \
    JBAKE_DATA="/data"

COPY --from=build  /opt/jbake-$JBAKE_VERSION/jbake-dist/build/install/jbake $JBAKE_HOME

ENV PATH $JBAKE_HOME/bin:$PATH

RUN mkdir -p "${JBAKE_DATA}"
WORKDIR "$JBAKE_DATA"
RUN jbake -i

VOLUME "$JBAKE_DATA"
EXPOSE 8820

ENTRYPOINT ["jbake"]
CMD ["-b -s"]
