# Proyecto de Universidad - Sistema de Control de Acceso con Raspberry Pi y Lector de NFC PN532

Este proyecto tiene como objetivo desarrollar un sistema de lectura de tarjetas NFC utilizando una Raspberry Pi 4 y un lector de NFC PN532. Este sistema permite la lectura de UIDs de usuarios mediante tarjetas NFC.

## Requisitos

- Raspberry Pi 4 (u otra versión compatible)
- Lector de NFC PN532
- Tarjetas NFC compatibles
- Conexión a internet (para la instalación de paquetes y actualizaciones)
- Teclado, ratón y monitor (para la configuración inicial)
- Cableado adecuado para conectar el lector de NFC a la Raspberry Pi

## Instalación

1. **Configuración inicial de Raspberry Pi:**
   - Conecta tu Raspberry Pi a un monitor, teclado y ratón.
   - Sigue las instrucciones para configurar la Raspberry Pi según tus preferencias.
   - Asegúrate de tener una conexión a internet estable.

2. **Conexión del lector de NFC PN532:**
   - Conecta el lector de NFC PN532 a la Raspberry Pi utilizando el cableado adecuado.
   - Verifica que la conexión esté correctamente establecida.

3. **Instalación de dependencias:**
   - Abre una terminal en tu Raspberry Pi.
   - Ejecuta los siguientes comandos:
     ```bash
     sudo apt update
     sudo apt install libnfc6 i2ctools ruby-full
     sudo gem install nfc
     ```

4. **Configuración del proyecto:**
   - Clona este repositorio en tu Raspberry Pi:
     ```bash
     git clone https://github.com/Darkarneus/PBE/puzzle1/puzzle1.rb
     ```
   - Accede al directorio del proyecto:
     ```bash
     cd PBE/puzzle1/puzzle1.rb
     ```

## Uso

Una vez que hayas configurado y conectado todo correctamente, puedes ejecutar el programa principal del proyecto:

```bash
ruby puzzle1.rb
```
