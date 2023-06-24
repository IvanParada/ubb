# Selecciona la imagen base de Flutter
FROM cirrusci/flutter:3.10.4

# Copia los archivos de la aplicación al contenedor
COPY . /app

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Instala las dependencias de la aplicación
RUN flutter pub get

# Expone el puerto si es necesario
# EXPOSE puerto

# Especifica el comando predeterminado para ejecutar la aplicación
CMD ["flutter", "run"]
