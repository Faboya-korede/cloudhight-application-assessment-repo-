FROM maven:3.8.3-openjdk-11-slim AS build

WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the application source code
COPY src ./src

# Build the application
RUN mvn package -DskipTests

# Use a lightweight Java runtime image
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the build stage to the current location
COPY --from=build /app/target/*.war app.war

# Expose the port the application listens on
EXPOSE 8080

# Specify the command to run your application
CMD ["java", "-jar", "app.war"]