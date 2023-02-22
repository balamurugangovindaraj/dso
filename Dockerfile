FROM maven:3.8-openjdk-18 as BUILD
WORKDIR /app
COPY .  .
RUN mvn package -DskipTests 

FROM openjdk:18-slim as RUN
WORKDIR /run
COPY --from=BUILD /app/target/demo-0.0.1-SNAPSHOT.jar demo.jar
EXPOSE 8080

CMD java  -jar /run/demo.jar
