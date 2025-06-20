# Usa una imagen de Maven con JDK 21
FROM maven:3.9.6-eclipse-temurin-21

WORKDIR /app
COPY . ./
RUN chmod +x ./mvnw
RUN ./mvnw clean install -DskipTests -B

# Imagen de runtime con Java 21
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=0 /app/target/*.jar app.jar
CMD ["java", "-jar", "app.jar"]
