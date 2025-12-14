<img width="1024" height="559" alt="image" src="https://github.com/user-attachments/assets/5897e64f-2e97-48e8-a11e-f5d4956221f2" />

# Yara-Hunter
Herramienta de automatización forense desarrollada para el Trabajo Final de Máster. Este script permite escanear evidencias forenses (Discos montados o RAM) utilizando múltiples repositorios de reglas YARA de forma secuencial y automatizada.

## 🚀 Características
- Escaneo recursivo profundo.
- Gestión de errores (evita que el análisis se detenga por una regla rota).
- Generación automática de reportes.
- Autoinstalación de dependencias (YARA).

## 📋 Requisitos
- Linux (Kali Linux, Ubuntu, Debian).
- Permisos de root (sudo) si se requiere montar discos o instalar YARA.

## 🔧 Instalación y Uso
1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/nanobug8/Yara-Hunter.git 
   cd Yara-Hunter
2. **Dar permisos de ejecución:**
   ```bash
   chmod +x hunter.sh
4. **Ejecutar contra una evidencia:**
   ```bash
   ./hunter.sh /ruta/a/la/evidencia_montada
