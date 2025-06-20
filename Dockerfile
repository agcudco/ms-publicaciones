# Use the official Maven image with Java 11
FROM maven:3.8.1-jdk-11-slim

# Create and change to the app directory.
WORKDIR /app

# Copy local code to the container image.
COPY . ./

# Ensure mvnw has execute permissions
RUN chmod +x ./mvnw

# Build the app without running tests
RUN ./mvnw clean install -DskipTests -B

# Stage 2: Create a lightweight runtime image
FROM openjdk:11-jre-slim

# Create and change to the app directory.
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=0 /app/target/*.jar app.jar

# Run the app
CMD ["java", "-jar", "app.jar"]
