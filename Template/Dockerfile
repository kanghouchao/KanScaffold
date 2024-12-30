# syntax=docker/dockerfile:1.10.0
FROM maven:3.9.9-amazoncorretto-17-alpine AS init
WORKDIR /build
COPY ../pom.xml pom.xml
RUN --mount=type=cache,id=repository,target=/root/.m2/repository mvn dependency:resolve

FROM init AS test
COPY src src
RUN --mount=type=cache,id=repository,target=/root/.m2/repository mvn clean test

FROM init AS package
COPY src src
RUN --mount=type=cache,id=repository,target=/root/.m2/repository mvn clean package -DskipTests

FROM openjdk:17-ea-17-slim-buster AS build
EXPOSE 8080
RUN addgroup --gid 1001 kan && \
    adduser --disabled-login --gid 1001  kan
USER kan:kan
WORKDIR /home/kan
COPY --from=package /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-server", "-jar", "app.jar"]
