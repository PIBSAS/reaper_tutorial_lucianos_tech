#!/bin/bash

# Ruta al archivo de configuración de ReaPack
REAPACK_INI="$HOME/.config/REAPER/reapack.ini"

# Lista de repositorios a agregar (nombre y URL)
declare -a REPOS=(
  "Zaibuyidao Scripts|https://github.com/zaibuyidao/ReaScripts/raw/master/index.xml"
  "Suzuki Scripts|https://github.com/Suzuki-Re/Suzuki-Scripts/raw/master/index.xml"
  "Yannick ReaScripts|https://github.com/Yaunick/Yannick-ReaScripts/raw/master/index.xml"
  "McArthur Scripts|https://github.com/Arthur-McArthur/ReaScripts/raw/master/index.xml"
  "ACendan Scripts|https://acendan.github.io/reascripts/index.xml"
  "AlbertoV5-ReaperTools|https://github.com/AlbertoV5/ReaperTools/raw/master/index.xml"
  "AmelianceSkyMusic Scripts|https://github.com/AmelianceSkyMusic/ASM_Reaper_scripts/raw/master/index.xml"
  "Archie ReaScripts|https://github.com/ArchieScript/Archie_ReaScripts/raw/master/index.xml"
  "AudioKinetic Scripts|https://github.com/Audiokinetic/Reaper-Tools/raw/main/index.xml"
  "Beaunus Scripts|https://github.com/beaunus/REAPER-ReaScripts/raw/master/index.xml"
  "bfut Scripts|https://github.com/bfut/ReaScripts/raw/main/index.xml"
  "BinbinHfr Scripts|https://github.com/DaveInDev/Binbinhfr-Scripts/raw/master/index.xml"
  "BirdBird JSFX|https://github.com/Bird-Bird/JSFX/raw/main/index.xml"
  "BirdBird Scripts|https://github.com/Bird-Bird/ReaScript/raw/master/index.xml"
  "Tukan Studio Scripts|https://github.com/TukanStudios/TUKAN_STUDIOS_PLUGINS/raw/main/index2.xml"
)

# Función para agregar un repositorio
add_repo() {
  local REPO_NAME=$1
  local REPO_URL=$2

  # Verificar si el repositorio ya existe (por nombre o URL)
  if grep -q "$REPO_URL" "$REAPACK_INI" || grep -q "$REPO_NAME" "$REAPACK_INI"; then
    echo "El repositorio '$REPO_NAME' o su URL ya existe. No se agregará."
    return
  fi

  # Buscar el índice más grande de remoteN
  MAX_REMOTE_INDEX=$(grep -Po '^remote\K\d+' "$REAPACK_INI" | sort -n | tail -n 1)

  # Calcular el nuevo índice
  NEW_REMOTE_INDEX=$((MAX_REMOTE_INDEX + 1))

  # Crear la nueva línea del repositorio
  NEW_REMOTE="remote$NEW_REMOTE_INDEX=$REPO_NAME|$REPO_URL|1|2"

  # Agregar el nuevo repositorio justo después del último remoteN
  sed -i "/^remote$MAX_REMOTE_INDEX/ a $NEW_REMOTE" "$REAPACK_INI"

  # Actualizar el tamaño de los repositorios
  sed -i "s/^size=[0-9]\+$/size=$((NEW_REMOTE_INDEX + 1))/" "$REAPACK_INI"

  echo "Repositorio '$REPO_NAME' agregado correctamente."
}

# Iterar sobre cada repositorio y agregarlo si no existe
for REPO in "${REPOS[@]}"; do
  REPO_NAME=$(echo $REPO | cut -d'|' -f1)
  REPO_URL=$(echo $REPO | cut -d'|' -f2)
  add_repo "$REPO_NAME" "$REPO_URL"
done

echo "Proceso de adición de repositorios completado."
