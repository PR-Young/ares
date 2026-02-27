FROM openjdk:17
LABEL authors="young"

EXPOSE 8080

ARG APP_FILE=ares-bin.zip

ADD /ares-bootstrap/target/$JAR_FILE /ares/ares-bin.zip

RUN sed -i 's#http://archive.ubuntu.com/#http://mirrors.tuna.tsinghua.edu.cn/#' /etc/apt/sources.list ;  \
    apt-get update && apt-get install -y unzip ; \
    unzip /ares/ares-bin.zip ; \

ENTRYPOINT ["java", "-Dloader.path=/ares/lib" , "-jar", "/ares.jar"]
