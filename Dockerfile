# Asegúrate de estar en el directorio correcto (donde está mvnw)
WORKDIR /app

# Da permisos al wrapper
RUN chmod +x ./mvnw

# Crea la carpeta target por si no existe
RUN mkdir -p target

# Ejecuta el build
RUN ./mvnw -DoutputFile=target/mvn-dependency-list.log -B -DskipTests clean dependency:list install
