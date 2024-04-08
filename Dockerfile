# Use a base image with Maven and JDK pre-installed
FROM maven:3.8.4-openjdk-11-slim AS builder

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project files to the working directory
COPY . .

# Build the Maven project
RUN mvn clean package

# Use a smaller base image for the final image
FROM adoptopenjdk/openjdk11:alpine-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/spring-petclinic-2.4.2.war .


EXPOSE 8080

# Command to run your application
CMD ["java", "-jar", "spring-petclinic-2.4.2.war"]
