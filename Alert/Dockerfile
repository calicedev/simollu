FROM openjdk:17-ea-11-jdk-slim
VOLUME /tmp
COPY build/libs/Alert-1.0.jar Alert.jar
ENTRYPOINT ["java","-jar","Alert.jar"]