#!/bin/bash

# Script para instalar automáticamente los drivers del chipset RTL8812AU/21AU
# en sistemas Debian/Kali Linux para adaptadores como el TP-Link Archer T2U Plus.

# Detiene el script si un comando falla
set -e

# 1. Verificar si se ejecuta como root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Por favor, ejecuta este script como root o con sudo."
  exit
fi

# 2. Actualizar el sistema e instalar dependencias
echo "⚙️  Actualizando el sistema e instalando dependencias necesarias..."
apt update
apt full-upgrade -y
apt install -y build-essential libelf-dev linux-headers-$(uname -r) dkms git

# 3. Clonar el repositorio del controlador
echo "⚙️  Clonando el repositorio del controlador desde GitHub..."
# Si la carpeta ya existe, la eliminamos para empezar de cero
rm -rf rtl8812au
git clone https://github.com/aircrack-ng/rtl8812au.git

# 4. Compilar e instalar el controlador
echo "⚙️  Compilando e instalando el controlador..."
cd rtl8812au
make
make install

# 5. Mensaje final
echo ""
echo "✅ ¡Instalación completada!"
echo "Para asegurar que los cambios se apliquen correctamente, por favor:"
echo "1. Desconecta y vuelve a conectar tu adaptador USB."
echo "2. O reinicia tu sistema con 'sudo reboot'."