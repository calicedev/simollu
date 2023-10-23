FROM openjdk:17-ea-11-jdk-slim
VOLUME /tmp
COPY build/libs/WaitingService-1.0.jar WaitingService.jar
ENTRYPOINT ["java","-jar","WaitingService.jar"]