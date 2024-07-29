#!/bin/bash

# Lee la variable de entorno GITHUB_USER
GITHUB_USER="${GITHUB_USER}"

# Verifica si GITHUB_USER está vacío
if [ -z "$GITHUB_USER" ]; then
    echo "La variable GITHUB_USER está vacía. Por favor, establezca el valor y vuelva a intentarlo."
    exit 1
fi

# Consulta la API de GitHub y guarda la respuesta en una variable
response=$(curl -s "https://api.github.com/users/$GITHUB_USER")

# Extrae los datos necesarios del JSON
user_name=$(echo "$response" | jq -r '.login')
user_id=$(echo "$response" | jq -r '.id')
created_at=$(echo "$response" | jq -r '.created_at')

# Verifica si se obtuvieron los datos correctamente
if [ "$user_name" = "null" ] || [ "$user_id" = "null" ]; then
    echo "No se pudo obtener la información del usuario $GITHUB_USER. Por favor, verifique el nombre de usuario e intente de nuevo."
    exit 1
fi

# Imprime el mensaje con los datos del usuario
echo "Hola $user_name. User ID: $user_id. Cuenta fue creada el: $created_at."

# Crea la carpeta de fecha si no existe
folder_date=$(date +%Y-%m-%d)
mkdir -p "/tmp/$folder_date"

# Escribe el mensaje en el log file
echo "Hola $user_name. User ID: $user_id. Cuenta fue creada el: $created_at." >> "/tmp/$folder_date/saludos.log"

# Añade un cronjob para ejecutar este script cada 5 minutos si aún no está configurado
(crontab -l 2>/dev/null | grep -q "github_user_info.sh") || (crontab -l 2>/dev/null; echo "*/5 * * * * actividad2_201313861.sh") | crontab -