# Use a base image with Maven to build the project
FROM maven:3.8.1-jdk-11 AS build

# Copy the Maven project and build it
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Use a base image with JRE to run the Spring Boot application
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file built in the previous stage into the container
COPY --from=build /app/target/spring-petclinic-2.4.2.jar /app/spring-petclinic-2.4.2.jar

# Command to run the Spring Boot application when the container starts
CMD ["java", "-jar", "spring-petclinic-2.4.2.jar"]
