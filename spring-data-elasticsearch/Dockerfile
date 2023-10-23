FROM openjdk:17-ea-11-jdk-slim
VOLUME /tmp
COPY build/libs/elasticsearch-1.0.jar Restaurant.jar
ENTRYPOINT ["java","-jar","Restaurant.jar"]