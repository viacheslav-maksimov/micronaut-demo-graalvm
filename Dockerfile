# syntax=docker/dockerfile:experimental

FROM ghcr.io/graalvm/graalvm-ce:ol8-java11-22.2.0 as build
RUN gu install native-image
RUN microdnf install -y zip

ENV MAVEN_VERSION=3.8.6
ENV MAVEN_OPTS='-XX:+PrintFlagsFinal -Xlog:gc -verbose:gc -XX:MetaspaceSize=64M -XX:MaxMetaspaceSize=128M -XX:CompressedClassSpaceSize=16M'

WORKDIR /home/myapp

RUN curl -OLs https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz\
 && tar -zxf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /usr/local/ \
 && ln -s /usr/local/apache-maven-${MAVEN_VERSION}/bin/mvn /usr/bin/mvn \
 && rm apache-maven-${MAVEN_VERSION}-bin.tar.gz

# Copy sources and build them
COPY . .

RUN mvn clean package -X -U -V --batch-mode -Dexternal.maven.fixed-ports.skip=false -Dsurefire.useFile=false -T4 -DskipTests  -Dapp.packaging=native-image

EXPOSE 8080
ENTRYPOINT ["/home/myapp/target/micronaut-demo-graalvm"]