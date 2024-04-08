# Use a base image with JRE to run the Spring Boot application
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the .mvn/wrapper folder into the container
COPY .mvn/wrapper/maven-wrapper.jar /app/maven-wrapper..jar

# Command to run the Spring Boot application when the container starts
CMD ["java", "-jar", "maven-wrapper..jar"]
