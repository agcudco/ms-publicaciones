# Etapa de compilación con Maven y JDK 21
FROM maven:3.9.6-eclipse-temurin-21 AS build

WORKDIR /app
COPY . .

RUN chmod +x mvnw && ./mvnw clean install -DskipTests -B

# Etapa de runtime con JRE 21
FROM eclipse-temurin:21-jre

WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

CMD ["java", "-jar", "app.jar"]
