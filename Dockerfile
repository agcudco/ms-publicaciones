# Etapa 1: Compilación del proyecto
FROM eclipse-temurin:17-jdk AS builder

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el wrapper de Maven y configuración
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Da permisos de ejecución al wrapper
RUN chmod +x mvnw

# Descarga las dependencias sin compilar el código aún
RUN ./mvnw dependency:go-offline -B

# Copia el código fuente después del pom.xml para mantener caché eficiente
COPY src ./src

# Compila el proyecto sin correr los tests
RUN ./mvnw clean install -DskipTests -B

# Etapa 2: Imagen final más liviana, solo con el JAR
FROM eclipse-temurin:17-jre

# Establece el directorio de trabajo en la imagen final
WORKDIR /app

# Copia el artefacto JAR desde la etapa anterior
COPY --from=builder /app/target/*.jar app.jar

# Expone el puerto (ajuste según su app, por defecto 8080)
EXPOSE 8080

# Comando de arranque del contenedor
ENTRYPOINT ["java", "-jar", "app.jar"]
