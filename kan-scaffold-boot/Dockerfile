# syntax=docker/dockerfile:1.10.0
FROM maven:3.9.9-amazoncorretto-17-alpine AS init
WORKDIR /build
COPY pom.xml pom.xml
RUN --mount=type=cache,id=repository,target=/root/.m2/repository mvn dependency:resolve

FROM init AS test
COPY src src
RUN --mount=type=cache,id=repository,target=/root/.m2/repository mvn clean test
