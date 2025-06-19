# Use the official Maven image
FROM maven:3.8.1-jdk-11-slim

# Create and change to the app directory.
WORKDIR /app

# Copy local code to the container image.
COPY . ./

# Ensure mvnw has execute permissions
RUN chmod +x ./mvnw

# Build the app.
RUN ./mvnw -DoutputFile=target/mvn-dependency-list.log -B -DskipTests clean dependency:list install

# Run the app by dynamically finding the JAR file in the target directory
CMD ["sh", "-c", "java -jar target/*.jar"]
