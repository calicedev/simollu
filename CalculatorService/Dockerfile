FROM openjdk:17-ea-11-jdk-slim
VOLUME /tmp
COPY build/libs/CalculatorService-1.0.jar CalculatorService.jar
ENTRYPOINT ["java","-jar","CalculatorService.jar"]