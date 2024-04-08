# Use an official Maven image as a parent image
FROM maven:3.8.3-openjdk-11-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project descriptor and the source code
COPY pom.xml .
COPY src ./src

# Build the application using Maven
RUN mvn clean package

# Use a smaller base image for runtime
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/my-java-app.jar .

EXPOSE 8080

# Specify the command to run on container start
CMD ["java", "-jar", "my-java-app.jar"]