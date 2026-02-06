#! /bin/bash
set -euo pipefail

PAGE="https://www.houseofwhitetie.com/graphical_sends.html"
BASE="https://www.houseofwhitetie.com/reaper"

VERSION=$(
  curl -s "$PAGE" |
  grep -oE 'WT_Graphical_Sends_[0-9]+\.zip' |
  head -n1 |
  sed -E 's/WT_Graphical_Sends_([0-9]+)\.zip/\1/'
)

if [[ -z "$VERSION" ]]; then
  echo "No se pudo detectar la versión"
  exit 1
fi

FILE="WT_Graphical_Sends_${VERSION}.zip"
URL="${BASE}/${FILE}"

echo "Versión detectada: $VERSION"
echo "Descargando $URL"

curl -L -o "$FILE" "$URL"
unzip -o "$FILE"
