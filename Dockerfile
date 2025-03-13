FROM openjdk:17
LABEL authors="young"

EXPOSE 8080

ARG JAR_FILE=ares.jar

ADD /ares-bootstrap/target/$JAR_FILE /ares.jar

ENTRYPOINT ["java", "-jar", "/ares.jar"]
