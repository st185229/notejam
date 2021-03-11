# we are extending everything from tomcat:8.0 image ...
FROM openjdk:8-jdk-alpine
COPY target/notejam-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]