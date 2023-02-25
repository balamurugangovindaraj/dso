FROM maven:3-eclipse-temurin-19-alpine as BUILD
RUN apk update && apk upgrade && \
    apk add --no-cache openjdk11-jdk && \
    apk add --no-cache libtasn1
WORKDIR /app
COPY .  .
RUN mvn package -DskipTests 

FROM openjdk:19-jdk-alpine3.16 as RUN
RUN apk update && apk upgrade && \
    apk add --no-cache libtasn1
WORKDIR /run
COPY --from=BUILD /app/target/demo-0.0.1-SNAPSHOT.jar demo.jar

ARG USER=devops
ENV HOME /home/$USER
RUN adduser -D $USER && \
chown $USER:$USER /run/demo.jar

RUN apk add --no-cache curl
HEALTHCHECK --interval=30s --timeout=10s --retries=2 --start-period=20s \
CMD curl -f http://localhost:8080/ || exit 1

USER $USER

EXPOSE 8080

CMD java  -jar /run/demo.jar
