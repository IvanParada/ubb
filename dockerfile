# Selecciona la imagen base de Flutter
FROM mobiledevops/flutter-sdk-image:latest

#Se establece usuario root para ejecutar operaciones
USER root

# Crear el directorio de la aplicación y establecerlo como directorio de trabajo
RUN mkdir /app
WORKDIR /app

# Agregar excepción para el directorio .flutter-sdk
RUN git config --global --add safe.directory /home/mobiledevops/.flutter-sdk

# Copiar el proyecto al directorio de trabajo
COPY . /app

# Obtener dependencias
RUN flutter pub get

# Ejecutar proyecto
CMD ["flutter", "run", "--release", "--working-directory=/app/ubb"]