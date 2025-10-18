#!/bin/bash
#########################################################################################################################
#################################/////LUCIANO'S TECH/////#####################################################
#########################################################################################################################
# Repositorio: Reaper Tutorial 2025
# Por: Raspberry Pi Buenos Aires ("https://sites.google.com/view/lucianostech/)
# License: http://creativecommons.org/licenses/by-sa/4.0/
#########################################################################################################################
#########################################################################################################################
REAPACK_INI="$HOME/.config/REAPER/reapack.ini"

declare -a REPOS=(
  "ACendan Scripts|https://acendan.github.io/reascripts/index.xml"
  "AlbertoV5 Reaper Tools|https://github.com/AlbertoV5/ReaperTools/raw/master/index.xml"
  "AmelianceSkyMusic script|https://github.com/AmelianceSkyMusic/ASM_Reaper_scripts/raw/master/index.xml"
  "Archie ReaScripts|https://github.com/ArchieScript/Archie_ReaScripts/raw/master/index.xml"
  "Audiokinetic|https://github.com/Audiokinetic/Reaper-Tools/raw/main/index.xml"
  "Beaunus Scripts|https://github.com/beaunus/REAPER-ReaScripts/raw/master/index.xml"
  "Bfut ReaScripts|https://github.com/bfut/ReaScripts/raw/main/index.xml"
  "BinbinHfr Scripts|https://github.com/DaveInDev/Binbinhfr-Scripts/raw/master/index.xml"
  "BirdBird JSFX|https://github.com/Bird-Bird/JSFX/raw/main/index.xml"
  "BirdBird ReaScript Testi|https://github.com/Bird-Bird/ReaScript_Testing/raw/main/index.xml"
  "BirdBird Scripts|https://github.com/Bird-Bird/ReaScript/raw/master/index.xml"
  "BSmith96 Scripts|https://github.com/bsmith96/Reaper-Scripts/raw/master/index.xml"
  "Chmaha airwindows JSFX P|https://github.com/chmaha/airwindows-JSFX-ports/raw/main/index.xml"
  "Chmaha Scripts|https://github.com/chmaha/ReaClassical/raw/main/index.xml"
  "Chokehold JSFX|https://github.com/chkhld/jsfx/raw/main/index.xml"
  "Chtammik_Reaper_Scripts|https://github.com/chtammik/chtammik_Reaper_Scripts/raw/master/index.xml"
  "Claudiohbsantos Scripts|https://github.com/Claudiohbsantos/Claudiohbsantos-Scripts/raw/master/index.xml"
  "Daniel Lumertz Scripts|https://github.com/daniellumertz/DanielLumertz-Scripts/raw/master/index.xml"
  "Dfk REAPER Scripts|https://github.com/Dafarkias/REAPER-Lua-Scripts-/raw/master/index.xml"
  "Erriez|https://github.com/Erriez/erriez-reaper-jsfx/raw/master/index.xml"
  "EUGENE27771 ReaScripts|https://github.com/EUGEN27771/ReaScripts/raw/master/index.xml"
  "Fernsehmüll Scripts|https://github.com/fernsehmuell/reaper_scripts/raw/master/index.xml"
  "FTC Tools|https://github.com/iliaspoulakis/Reaper-Tools/raw/master/index.xml"
  "FX Device|https://github.com/BryanChi/BryanChi-FX-Devices/raw/main/index.xml"
  "Geraints JSFX|https://geraintluff.github.io/jsfx/index.xml"
  "Helgoboss Projects|https://github.com/helgoboss/reaper-packages/raw/master/index.xml"
  "IX|https://github.com/IXix/JSFX/raw/master/index.xml"
  "Joabe Lopes Multitrack S|https://github.com/joabeslopes/Reaper-scripts-multitrack-show/raw/main/index.xml"
  "JRENG|https://github.com/jrengmusic/ReaScript/raw/master/index.xml"
  "Juan Rs Reaperism|https://raw.githubusercontent.com/juanriccio/Reaperism/master/index.xml"
  "Kawa Script2|https://bitbucket.org/kawaCat/kawascript2/raw/master/index.xml"
  "Kawa Scripts|https://bitbucket.org/kawaCat/reascript-m2bpack/raw/master/index.xml"
  "Leandro Facchinetti|https://github.com/leafac/reaper/raw/main/index.xml"
  "LKC Tools|https://github.com/nikolalkc/LKC-Tools/raw/master/index.xml"
  "McArthur Scripts|https://github.com/Arthur-McArthur/ReaScripts/raw/master/index.xml"
  "Me2beats Scripts|https://github.com/me2beats/reapack/raw/master/index.xml"
  "Mespotine Scripts And Ex|https://github.com/mespotine/Mespotine-Scripts/raw/main/Mespotine_Scripts.xml"
  "Mrlimbic scripts|https://github.com/mrlimbic/reascripts/raw/master/index.xml"
  "N0ne scripts|https://github.com/n0ner/Reaper/raw/master/index.xml"
  "Neutronic Scripts|https://github.com/Neutronic/ReaScripts/raw/master/index.xml"
  "Nofish ReaScripts|https://github.com/nofishonfriday/ReaScripts/raw/master/index.xml"
  "Outboarder Scripts|https://github.com/Outboarder/ReaScripts/raw/master/index.xml"
  "PeloReaper|https://github.com/pelori/PeloReaper/raw/master/index.xml"
  "Ply Scripts|https://ply.github.io/ReaScripts/index.xml"
  "Przemocs ReaScripts|https://github.com/przemoc/REAPER-ReaScripts/raw/master/index.xml"
  "Radio Toolkit|https://github.com/tomtjes/Radio-Toolkit/raw/master/index.xml"
  "RCJacH Scripts|https://github.com/RCJacH/ReaScripts/raw/master/index.xml"
  "ReaperWRB|https://bobobo-git.github.io/reaperwrb_2/index.xml"
  "Reaticulate|https://reaticulate.com/release.xml"
  "ReJJ|https://github.com/Justin-Johnson/ReJJ/raw/master/index.xml"
  "RobU Scripts|https://github.com/RobU23/ReaScripts/raw/master/index.xml"
  "Saike Tools|https://github.com/JoepVanlier/JSFX/raw/master/index.xml"
  "Lemerchand Scripts|https://github.com/lemerchand/lemerchand/raw/master/index.xml"
  "Sexan Scripts|https://github.com/GoranKovac/ReaScripts/raw/master/index.xml"
  "Sockmonkey72 Scripts|https://github.com/jeremybernstein/ReaScripts/raw/main/index.xml"
  "SonicAnomaly JSFX|https://github.com/Sonic-Anomaly/Sonic-Anomaly-JSFX/raw/master/index.xml"
  "Souk21 ReaPack|https://github.com/Souk21/REAPER-scripts-and-effects/raw/master/index.xml"
  "Stevie Scripts|https://github.com/StephanRoemer/ReaScripts/raw/master/index.xml"
  "StevieKeys JSFX|https://github.com/Steviekeys/StevieKeys_JSFX2/raw/master/index.xml"
  "Suzuki Scripts|https://github.com/Suzuki-Re/Suzuki-Scripts/raw/master/index.xml"
  "Tack Scripts|https://github.com/jtackaberry/reascripts/raw/master/index.xml"
  "Tilr|https://github.com/tiagolr/tilr_jsfx/raw/master/index.xml"
  "TJF Scripts|https://github.com/sonictim/TJF-Scripts/raw/master/index.xml"
  "Tormy Van Cool ReaPack S|https://github.com/tormyvancool/TormyVanCool_ReaPack_Scripts/raw/master/index.xml"
  "Tracker tools|https://github.com/JoepVanlier/Hackey-Trackey/raw/master/index.xml"
  "Tukan|https://github.com/TukanStudios/TUKAN_STUDIOS_PLUGINS/raw/main/index2.xml"
  "X-Raym MIDI Makey Makey|https://github.com/X-Raym/MIDI-Makey-Makey/raw/master/index.xml"
  "Yannick ReaScripts|https://github.com/Yaunick/Yannick-ReaScripts/raw/master/index.xml"
  "Zaibuyidao Scripts|https://github.com/zaibuyidao/ReaScripts/raw/master/index.xml"
)

add_repo() {
  local REPO_NAME=$1
  local REPO_URL=$2

  if grep -q "$REPO_URL" "$REAPACK_INI" || grep -q "$REPO_NAME" "$REAPACK_INI"; then
    echo "El repositorio '$REPO_NAME' o su URL ya existe. No se agregará."
    return
  fi

  MAX_REMOTE_INDEX=$(grep -Po '^remote\K\d+' "$REAPACK_INI" | sort -n | tail -n 1)

  NEW_REMOTE_INDEX=$((MAX_REMOTE_INDEX + 1))

  NEW_REMOTE="remote$NEW_REMOTE_INDEX=$REPO_NAME|$REPO_URL|1|2"

  sed -i "/^remote$MAX_REMOTE_INDEX/ a $NEW_REMOTE" "$REAPACK_INI"

  sed -i "s/^size=[0-9]\+$/size=$((NEW_REMOTE_INDEX + 1))/" "$REAPACK_INI"

  echo "Repositorio '$REPO_NAME' agregado correctamente."
}

for REPO in "${REPOS[@]}"; do
  REPO_NAME=$(echo $REPO | cut -d'|' -f1)
  REPO_URL=$(echo $REPO | cut -d'|' -f2)
  add_repo "$REPO_NAME" "$REPO_URL"
done

echo "Proceso de adición de repositorios completado."
