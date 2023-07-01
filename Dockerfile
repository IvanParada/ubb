# Selecciona la imagen base de Flutter
FROM flutter:stable

# Copia los archivos de la aplicación al contenedor
COPY . /app

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Instala las dependencias de la aplicación
RUN flutter pub get

CMD ["flutter", "run", "--release"] //--release: ejecuta en modo compilacion, no debug, genera una version optimizada de la app.
