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
titulo "Ninja 2"
cd
git clone --recursive https://github.com/rghvdberg/ninjas2.git
cd ninjas2
make -j$(nproc) all CXXFLAGS='-march=native' CFLAGS='-march=native' CPPFLAGS='-march=native'
sudo make install -j$(nproc)
rm -rf ../ninjas2
cd
titulo "Ninjas 2 Installed"
titulo "Finished install on $(uname -m) bits OS, check tutorial for Tukan plugins"
titulo "Reverting sudoers temp file, please make sure reboot..."
sudo rm -f "$SUDOERS_TEMP_FILE"
titulo "Now Reboot to take effects changes"
titulo "YOU HAVE TO TYPE reboot"
