#! /bin/bash
#########################################################################################################################
############################################/////LUCIANO'S TECH/////#####################################################
#########################################################################################################################
# Repositorio: Reaper Tutorial 2025
# Por: Luciano's Tech ("https://sites.google.com/view/lucianostech/)
# Script for Orange Pi 5 Pluss with Ubuntu
# License: http://creativecommons.org/licenses/by-sa/4.0/
#########################################################################################################################
#########################################################################################################################
USUARIO=$(whoami)
SUDOERS_TEMP_FILE="/etc/sudoers.d/temp_nopasswd"
echo "$USUARIO ALL=(ALL) NOPASSWD: ALL" | sudo tee "$SUDOERS_TEMP_FILE" > /dev/null
titulo() {
    local texto="$1"
    local longitud=120
    local num_hash=$(( (longitud - ${#texto} - 4) / 2 ))
    
    if (( num_hash < 0 )); then
        num_hash=0
    fi

    local hashes=$(printf '#%.0s' $(seq 1 $num_hash))
    local titulo_formateado="${hashes}  ${texto}  ${hashes}"

    while [ ${#titulo_formateado} -lt $longitud ]; do
        titulo_formateado+='#'
    done

    local linea=$(printf '#%.0s' $(seq 1 $longitud))
    echo
    echo "$linea"
    echo "$titulo_formateado"
    echo "$linea"
    echo
}
titulo "Adding temp sudoers so the script dont ask you for password again"
titulo "Stochas Compile"
cd
git clone --depth=1 https://github.com/surge-synthesizer/stochas.git
cd stochas/
git submodule update --init --recursive --depth=1
export SVER=$(<VERSION)
export GH=$(git rev-parse --short HEAD)
echo "Version ${SVER} hash ${GH}"
grep -q "#include <utility>" lib/JUCE/modules/juce_core/system/juce_StandardHeader.h || \
    sed -i '66 a\#include <utility>' lib/JUCE/modules/juce_core/system/juce_StandardHeader.h
cmake -Bbuild -DSTOCHAS_VERSION=${SVER} -DCMAKE_BUILD_TYPE=Release -GNinja
cmake --build build
cd build
sudo make install -j$(nproc)
mkdir $HOME/.clap
mkdir $HOME/.vst3
cp -rf $HOME/stochas/build/stochas_artefacts/VST3/Stochas.vst3 $HOME/.vst3
cp -rf $HOME/stochas/build/stochas_artefacts/CLAP/Stochas.clap $HOME/.clap
sudo cp -rf $HOME/stochas/build/stochas_artefacts/Standalone/Stochas /usr/local/bin
rm -rf $HOME/stochas
titulo "Stochas Installed"
titulo "Finished install on $(uname -m) bits OS, check tutorial for Tukan plugins"
titulo "Reverting sudoers temp file, please make sure reboot..."
sudo rm -f "$SUDOERS_TEMP_FILE"
titulo "Now Reboot to take effects changes"
