#!/bin/bash

# Parte 1: Gestión de Usuarios

# 1. Creación de Usuarios
sudo useradd -m usuario1
sudo useradd -m usuario2
sudo useradd -m usuario3

# 2. Asignación de Contraseñas
echo "usuario1:password1" | sudo chpasswd
echo "usuario2:password2" | sudo chpasswd
echo "usuario3:password3" | sudo chpasswd

# 3. Información de Usuarios
echo "Información de usuario1:"
id usuario1

# 4. Eliminación de Usuarios (manteniendo el directorio principal)
sudo userdel usuario3 --remove-home --preserve-home

# Parte 2: Gestión de Grupos

# 1. Creación de Grupos
sudo groupadd grupo1
sudo groupadd grupo2

# 2. Agregar Usuarios a Grupos
sudo usermod -aG grupo1 usuario1
sudo usermod -aG grupo2 usuario2

# 3. Verificar Membresía
echo "Membresía de usuario1:"
groups usuario1

echo "Membresía de usuario2:"
groups usuario2

# 4. Eliminar Grupo
sudo groupdel grupo2

# Parte 3: Gestión de Permisos

# Cambiar a usuario1 para realizar las siguientes operaciones
su - usuario1 << 'EOF'

# 1. Creación de Archivos y Directorios
echo "Este es el contenido del archivo1" > ~/archivo1.txt
mkdir ~/directorio1
echo "Contenido de archivo2" > ~/directorio1/archivo2.txt

# 2. Verificar Permisos
echo "Permisos de archivo1.txt:"
ls -l ~/archivo1.txt

echo "Permisos de directorio1:"
ls -ld ~/directorio1

# 3. Modificar Permisos usando chmod con Modo Numérico
chmod 640 ~/archivo1.txt

# 4. Modificar Permisos usando chmod con Modo Simbólico
chmod u+x ~/directorio1/archivo2.txt

# 5. Cambiar el Grupo Propietario
sudo chgrp grupo1 ~/directorio1/archivo2.txt

# 6. Configurar Permisos de Directorio
chmod 740 ~/directorio1

EOF

# 7. Comprobación de Acceso
# Cambiar a usuario2 para realizar la comprobación de acceso
su - usuario2 << 'EOF'

# Intenta acceder al archivo1.txt
echo "Intento de acceso a archivo1.txt como usuario2:"
cat /home/usuario1/archivo1.txt || echo "Acceso denegado a archivo1.txt"

# Intenta acceder a directorio1/archivo2.txt
echo "Intento de acceso a directorio1/archivo2.txt como usuario2:"
cat /home/usuario1/directorio1/archivo2.txt || echo "Acceso denegado a directorio1/archivo2.txt"

EOF

# 8. Verificación Final
# Cambiar a usuario1 para verificar permisos y propietario
su - usuario1 << 'EOF'

echo "Verificación final de permisos y propietarios:"
ls -l ~/archivo1.txt
ls -l ~/directorio1/archivo2.txt
ls -ld ~/directorio1

EOF