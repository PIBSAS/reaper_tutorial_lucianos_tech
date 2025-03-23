#! /bin/bash
#########################################################################################################################
############################################/////LUCIANO'S TECH/////#####################################################
#########################################################################################################################
# Repositorio: Reaper Tutorial 2025
# Por: Luciano's Tech ("https://sites.google.com/view/lucianostech/)
# Script for Orange Pi 5 Pro with Ubuntu
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
sudo apt remove --purge clang -y && sudo apt update
paquetes=(
     build-essential cmake clang ninja-build llvm libstdc++-12-dev libcairo2-dev libxkbcommon-x11-dev libxkbcommon-dev libxcb-cursor-dev libxcb-keysyms1-dev
     libxcb-util-dev libxrandr-dev libxinerama-dev libxcursor-dev libasound2-dev libjack-jackd2-dev
     libgtk-3-dev libwebkit2gtk-4.1-0 libwebkit2gtk-4.1-dev libcurl4-openssl-dev alsa alsa-tools libasound2-dev
     libjack-dev libfreetype6-dev libxinerama-dev libxcb-xinerama0 libxinerama1 x11proto-xinerama-dev libxrandr-dev
     libgl1-mesa-dev libxcursor-dev libxcursor1 libxcb-cursor-dev libxcb-cursor0 qjackctl meterbridge jack-tools
)
sudo apt install -y "${paquetes[@]}"
sudo apt-get install -y --fix-missing
titulo "Surge XT and Surge XT Effects. This will take a lot of time"
cd
if [ -d "$HOME/surge" ]; then
    rm -rf "$HOME/surge"
fi
git clone --depth=1 https://github.com/surge-synthesizer/surge.git
cd surge
git submodule update --init --recursive
cmake -Bignore/s13clang -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++
cmake --build ignore/s13clang --target all --parallel $(nproc)
sudo cmake --install ignore/s13clang
rm -rf "$HOME/surge"
titulo "Surge XT Plugins installed"
titulo "Finished install on $(uname -m) bits OS, check tutorial for Tukan plugins"
titulo "Reverting sudoers temp file, please make sure reboot..."
sudo rm -f "$SUDOERS_TEMP_FILE"
titulo "Now Reboot to take effects changes"
titulo "YOU HAVE to TYPE reboot"
