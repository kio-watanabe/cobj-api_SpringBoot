FROM openjdk:17

WORKDIR /Spring-boot-api-demo

COPY .mvn .mvn
COPY gradle gradle
COPY lib lib
COPY target target
COPY ./pom.xml .
COPY ./mvnw .


ENTRYPOINT [ "./mvnw", "spring-boot:run", "-Dmaven.test.skip=true", "-f", "pom.xml" ]