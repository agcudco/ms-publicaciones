# Stage 1: compilación con Maven + JDK 21
FROM maven:3.9.4-jdk-21-slim AS build

WORKDIR /app
COPY . .

# Si usa mvnw, asegúrese de que sea compatible con JDK 21
RUN chmod +x mvnw \
 && ./mvnw clean install -DskipTests -B

# Stage 2: runtime con JRE 21
FROM eclipse-temurin:21-jre-focal

WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

CMD ["java", "-jar", "app.jar"]
