# Etapa 1: Construcción del proyecto
FROM eclipse-temurin:17-jdk AS builder

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos necesarios del wrapper y el pom
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Da permisos de ejecución al wrapper
RUN chmod +x mvnw

# Descarga las dependencias (sin compilar aún)
RUN ./mvnw dependency:go-offline

# Copia el código fuente (después del pom.xml para usar cache)
COPY src ./src

# Compila el proyecto sin correr los tests
RUN ./mvnw clean install -DskipTests -B -e

# Etapa 2: Imagen final con solo el artefacto
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copiamos el JAR desde la etapa anterior
COPY --from=builder /app/target/*.jar app.jar

# Puerto de escucha (opcional, depende de tu app)
EXPOSE 8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]
