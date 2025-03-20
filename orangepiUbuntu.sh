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
titulo() {
    local texto="$1"
    local longitud=120  # Longitud total de la línea

    # Calcular la cantidad de '#' en los extremos
    local num_hash=$(( (longitud - ${#texto} - 4) / 2 ))  # 4 por los dos espacios antes y después del título

    # Ajustar si el título es demasiado largo
    if (( num_hash < 0 )); then
        num_hash=0
    fi

    # Generar los '#' en los extremos
    local hashes=$(printf '#%.0s' $(seq 1 $num_hash))

    # Construir la línea central asegurando que tenga exactamente 100 caracteres
    local titulo_formateado="${hashes}  ${texto}  ${hashes}"

    # Si la línea es menor a 100 caracteres, completar con un '#'
    while [ ${#titulo_formateado} -lt $longitud ]; do
        titulo_formateado+='#'
    done

    # Generar la línea superior e inferior
    local linea=$(printf '#%.0s' $(seq 1 $longitud))

    echo "$linea"
    echo "$titulo_formateado"
    echo "$linea"
}

# Ejemplo de uso:
# titulo "Hola"

echo
titulo "Start Reaper Tutorial Install from Luciano's tech this will take some time, so connect Ethernet Cable!"
echo
RENO=Renoise_3_4_4
SUN=2.1.1c
echo
titulo "First the common install for $(uname -m) bit"
echo
echo
titulo "Adding KXStudio Repository to the OS"
echo
cd
url="https://kx.studio/Repositories" ; \
curl -sSL "${url}" > p.html ; \
download=$(awk -F'"' '/kxstudio-repos_[0-9.]*_all.deb/ {print $2}' p.html) ; \
wget -c "${download}"
rm p.html
sudo dpkg -i kxstudio*.deb
rm kxstudio*.deb
sudo apt update
echo
titulo "KXStudio Repo Added"
echo
echo
titulo "Install Plugins"
echo
packages=(
    wget curl grep git xz-utils sed gawk p7zip-full unzip build-essential libcairo-dev libcairo2-dev
    libxkbcommon-x11-dev libxkbcommon-dev libxcb-cursor0 libxcb-cursor-dev libxcb-keysyms1-dev libxcb-util-dev libxcb-xinerama0
    libxrandr-dev libxinerama-dev libxinerama1 libxcursor-dev libasound2-dev libjack-jackd2-dev cmake libssl-dev clang 
    libgtk-3-dev libwebkit2gtk-4.1-0 libwebkit2gtk-4.1-dev libcurl4-openssl-dev alsa alsa-tools libfreetype6-dev  
    x11proto-xinerama-dev libgl1-mesa-dev qjackctl meterbridge jack-tools libxcursor1 libx11-dev libsndfile1-dev libsamplerate0-dev
    vitalium zynaddsubfx zynaddsubfx-dssi zynaddsubfx-lv2 zynaddsubfx-vst
    wah-plugins swh-lv2 swankyamp swankyamp-lv2 swankyamp-vst sorcer yoshimi
    carla carla-lv2 helm airwindows cardinal cardinal-lv2 cardinal-vst2 cardinal-vst3
    phasex lmms adlplug ams amsynth ardour drumkv1-lv2 fomp hydrogen padthv1-lv2
    zam-plugins wolf-spectrum wolf-shaper teragonaudio-plugins temper shiro-plugins
    tal-plugins pizmidi-plugins pitcheddelay oxefmsynth obxd mda-lv2 luftikus lufsmeter
    linuxsampler-vst juced-plugins klangfalter juce-opl jackass hybridreverb2 easyssp
    drumgizmo drowaudio-plugins dpf-plugins dpf-plugins-common dpf-plugins-dssi dpf-plugins-lv2
    dpf-plugins-vst distrho-plugin-ports dexed arctican-plugins vocproc tap-lv2 synthv1
    synthv1-lv2 zlfo so-synth-lv2 sherlock.lv2 samplv1 samplv1-lv2 rubberband-ladspa rubberband-lv2
    noise-repellent moony.lv2 mod-pitchshifter mod-distortion melmatcheq.lv2 lv2vocoder
    kxstudio-recommended-audio-plugins-lv2 infamous-plugins gxvoxtonebender gxplugins
    guitarix geonkick eq10q drmr caps-lv2 calf-plugins calf-ladspa bshapr bsequencer
    blop-lv2 bjumblr beatslash-lv2 abgate fabla wolpertinger iem-plugin-suite-vst
    cv-lfo-blender-lv2 dragonfly-reverb-lv2 dragonfly-reverb-vst avldrums.lv2 avldrums.lv2-data
    invada-studio-plugins-ladspa invada-studio-plugins-lv2 ir.lv2 amb-plugins autotalent blepvco blop 
    blop-lv2 bs2b-ladspa cmt csladspa fil-plugins mcp-plugins omins rev-plugins ste-plugins swh-plugins 
    tap-plugins vco-plugins vlevel a2jmidid gmidimonitor jack-keyboard jackd jackd2 japa jconvolver jkmeter 
    jmeters jnoise klick qjackrcd qmidiarp qtractor radium-compressor rotter fst-dev foo-yc20 
    freewheeling horgand muse nama gxtuner sox sweep terminatorx ghostess whysynth
)
echo
sudo apt install -y "${packages[@]}"
sudo apt-get install -y --fix-missing
echo
titulo "Install Reaper DAW for $(uname -m)"
cd
rm reaper*
rm -rf reaper_linux_aarch64
web="https://www.reaper.fm/download.php" && last=$(curl -s ${web} | grep -oE 'files/7.x/reaper[0-9]+_linux_aarch64\.tar\.xz') && down="https://www.reaper.fm/${last}" && wget "${down}"
echo
titulo "Untar"
echo
tar -Jxvf reaper*.tar.xz
echo
cd reaper_*
sudo ./install-reaper.sh --install /opt --integrate-desktop --usr-local-bin-symlink --quiet
echo
rm ../reaper*.tar.xz
rm -rf ../reaper_linux*
cd
echo
titulo "REAPER Installed"
echo
titulo "Open then close Reaper to get the new F}olders created in the first run"
echo
reaper &
sleep  10
sudo pkill reaper
echo
titulo "Adding Plugins Paths"
echo
sed -i 's!vstpath=!vstpath=$HOME/.vst;$HOME/.vst3;/lib/vst;/lib/vst3;/lib/lxvst;/usr/lib/vst;/usr/lib/vst3;/usr/lib/lxvst;/usr/local/lib/vst;/usr/local/lib/vst3;/usr/lib/lxvst;/lib/vst/carla.vst/;!' $HOME/.config/REAPER/reaper.ini
echo
sed -i 's!lv2path_linux=!lv2path_linux=/usr/lib/lv2;/usr/local/lib/lv2;$HOME/.lv2;/lib/lv2;/usr/modep/lv2;!' $HOME/.config/REAPER/reaper.ini
echo
sed -i '/^fxdenorm=1.*/i clap_path_linux-aarch64=/usr/local/lib/clap;/usr/lib/clap;$HOME/.clap;%CLAP_PATH%;/lib/clap;/usr/local/lib/clap;' $HOME/.config/REAPER/reaper.ini
echo
echo
titulo "Secuencer Megababy Nandy's Mod"
echo
wget "https://raw.githubusercontent.com/PIBSAS/reaper_tutorial_rpibsas/main/sequencer_megababy_nandy_mod" -P $HOME/.config/REAPER/Effects/midi/
echo
echo
titulo "Adding ZynthianOS Plugins"
echo
cd
git clone https://github.com/zynthian/zynthian-plugins.git
echo
cd zynthian-plugins
sudo cp -r * /usr/local/lib
cd
rm -rf zynthian-plugins
echo
titulo "ZynthianOS Plugins Installed"
echo
titulo "LSP Plugins"
echo
cd
url="https://github.com/lsp-plugins/lsp-plugins/releases/latest" ; \
latest_version=$(curl -sSL ${url} | grep -oP '\/lsp-plugins\/lsp-plugins\/releases\/tag\/\K[0-9.]+' | head -n 1 | tr -d '\n') ; \
wget "https://github.com/lsp-plugins/lsp-plugins/releases/download/${latest_version}/lsp-plugins-${latest_version}-Linux-aarch64.7z"
7za x lsp*.7z
cd lsp-plugins-*/
sudo cp -r VST2/* /usr/lib/vst/
sudo cp -r VST3/* /usr/lib/vst3/
sudo cp -r LV2/* /usr/lib/lv2/
sudo mkdir /usr/lib/ladspa /usr/lib/clap
sudo cp -r LADSPA/* /usr/lib/ladspa/
sudo cp -r CLAP/* /usr/lib/clap/
sudo cp -r JACK/* /
sudo cp -r GStreamer/* /
cd
rm -rf lsp*
echo
titulo "LSP Plugins Installed"
echo
titulo "X42 Plugins"
echo
titulo "X42 Compressor"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-compressor-v[0-9.]*-arm64.tar.gz\|x42-compressor-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-compressor-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42-compressor
yes | ./install-lv2.sh
rm -rf ../x42*
cd
echo
titulo "AVL Drums"
echo
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-avldrums-v[0-9.]*-arm64.tar.gz\|x42-avldrums-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-avldrums-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
cd
echo
titulo "General MIDI Synth"
echo
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-gmsynth-v[0-9.]*-arm64.tar.gz\|x42-gmsynth-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-gmsynth-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
cd
echo
titulo "MIDI Filter Collection"
echo
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-midifilter-v[0-9.]*-arm64.tar.gz\|x42-midifilter-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-midifilter-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
cd
echo
titulo "Rule Based MIDI Filter"
echo
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-midimap-v[0-9.]*-arm64.tar.gz\|x42-midimap-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-midimap-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
cd
echo
titulo "Step Sequencer"
echo
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-stepseq-8x8-v[0-9.]*-arm64.tar.gz\|x42-stepseq-8x8-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-stepseq-8x8-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
cd
echo
titulo "SetBfree"
echo
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'setBfree-v[0-9.]*-arm64.tar.gz\|setBfree-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}setBfree-v${latest_version}-arm64.tar.gz"
tar -xzvf set*.tar.gz
cd set*/
yes | ./install-lv2.sh
rm -rf ../set*
cd
echo
titulo "Digital Peak Limiter"
echo
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-limiter-v[0-9.]*-arm64.tar.gz\|x42-limiter-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-limiter-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
cd
echo
titulo "Auto Tune"
echo
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-autotune-v[0-9.]*-arm64.tar.gz\|x42-autotune-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-autotune-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
cd
echo
titulo "Zero Config Latency Convolver"
echo
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-zconvolver-v[0-9.]*-arm64.tar.gz\|x42-zconvolver-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-zconvolver-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
cd
echo
titulo "Phase Rotate"
echo
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-phaserotate-v[0-9.]*-arm64.tar.gz\|x42-phaserotate-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-phaserotate-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
cd
echo
titulo "Oscilloscope"
echo
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-scope-v[0-9.]*-arm64.tar.gz\|x42-scope-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-scope-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
cd
echo
titulo "Mixer Trigger Preprocessor"
echo
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-mixtrix-v[0-9.]*-arm64.tar.gz\|x42-mixtrix-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-mixtrix-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
cd
echo
titulo "Spectogram for Geeks"
echo
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-spectra-v[0-9.]*-arm64.tar.gz\|x42-spectra-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-spectra-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
cd
echo
titulo "Test Signal Generator"
echo
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-testsignal-v[0-9.]*-arm64.tar.gz\|x42-testsignal-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-testsignal-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
cd
echo
titulo "Delayline Artificial Latency"
echo
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-nodelay-v[0-9.]*-arm64.tar.gz\|x42-nodelay-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-nodelay-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
cd
echo
titulo "Balance"
echo
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-balance-v[0-9.]*-arm64.tar.gz\|x42-balance-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-balance-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
cd
echo
titulo "Stereo Routing"
echo
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-stereoroute-v[0-9.]*-arm64.tar.gz\|x42-stereoroute-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-stereoroute-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
cd
echo
titulo "X42 Plugins Installed"
echo
echo
titulo "ReaPack"
echo
cd
url="https://github.com/cfillion/reapack/releases/latest/" ; \
latest_version=$(curl -sSL ${url} | grep -o 'tag/v[0-9.]*' | head -n 1 | cut -d '/' -f 2 | sed 's/^v//') ; \
wget -c "https://github.com/cfillion/reapack/releases/download/v${latest_version}/reaper_reapack-aarch64.so"
cp reaper_reapack*.so $HOME/.config/REAPER/UserPlugins/
rm reaper_reapack*.so
echo
echo
titulo "SWS S&M Extension"
echo
cd $HOME/.config/REAPER/
url="https://www.sws-extension.org/download/pre-release/" ; \
html_content=$(curl -sSL "${url}") ; \
download=$(echo "$html_content" | grep -m 1 -oE '<a href="([^"]+\.tar\.xz)">sws-[0-9.]+-Linux-aarch64-[0-9a-f]+\.tar\.xz</a>' | sed -E 's/<a href="([^"]+)".*/\1/')  ; \
full_url="${url}${download}" ; \
wget -c "${full_url}"
tar -Jxvf sws*.tar.xz
rm sws*
cd
echo
titulo "DSP53600 Access Virus C"
echo
titulo "CLAP"
echo
cd
URL="https://futurenoize.com/dsp56300/builds/osirus/" ; \
latest_deb=$(curl -s "${url}" | grep -o 'DSP56300Emu-[0-9.]*-Linux_aarch64-Osirus-CLAP.deb' | head -n 1) ; \
wget "${URL}${latest_deb}"
URL="https://futurenoize.com/dsp56300/builds/osirus/" ; \
latest_deb=$(curl -s "${url}" | grep -o 'DSP56300Emu-[0-9.]*-Linux_aarch64-OsirusFX-CLAP.deb' | head -n 1) ; \
wget "${URL}${latest_deb}"
sudo dpkg -i DSP56300Emu*CLAP.deb
sudo dpkg -i DSP56300Emu*FX-CLAP.deb
rm DSP*.deb
echo
titulo "LV2"
echo
cd
URL="https://futurenoize.com/dsp56300/builds/osirus/" ; \
latest_deb=$(curl -s "${url}" | grep -o 'DSP56300Emu-[0-9.]*-Linux_aarch64-Osirus-LV2.deb' | head -n 1) ; \
wget "${URL}${latest_deb}"
URL="https://futurenoize.com/dsp56300/builds/osirus/" ; \
latest_deb=$(curl -s "${url}" | grep -o 'DSP56300Emu-[0-9.]*-Linux_aarch64-OsirusFX-LV2.deb' | head -n 1) ; \
wget "${URL}${latest_deb}"
sudo dpkg -i DSP56300Emu*LV2.deb
sudo dpkg -i DSP56300Emu*FX-LV2.deb
rm DSP*.deb
echo
titulo "VST2"
echo
cd
URL="https://futurenoize.com/dsp56300/builds/osirus/" ; \
latest_deb=$(curl -s "${url}" | grep -o 'DSP56300Emu-[0-9.]*-Linux_aarch64-Osirus-VST2.deb' | head -n 1) ; \
wget "${URL}${latest_deb}"
URL="https://futurenoize.com/dsp56300/builds/osirus/" ; \
latest_deb=$(curl -s "${url}" | grep -o 'DSP56300Emu-[0-9.]*-Linux_aarch64-OsirusFX-VST2.deb' | head -n 1) ; \
wget "${URL}${latest_deb}"
sudo dpkg -i DSP56300Emu*VST2.deb
sudo dpkg -i DSP56300Emu*FX-VST2.deb
rm DSP*.deb
echo
titulo "VST3"
echo
cd
URL="https://futurenoize.com/dsp56300/builds/osirus/" ; \
latest_deb=$(curl -s "${url}" | grep -o 'DSP56300Emu-[0-9.]*-Linux_aarch64-Osirus-VST3.deb' | head -n 1) ; \
wget "${URL}${latest_deb}"
URL="https://futurenoize.com/dsp56300/builds/osirus/" ; \
latest_deb=$(curl -s "${url}" | grep -o 'DSP56300Emu-[0-9.]*-Linux_aarch64-OsirusFX-VST3.deb' | head -n 1) ; \
wget "${URL}${latest_deb}"
sudo dpkg -i DSP56300Emu*VST3.deb
sudo dpkg -i DSP56300Emu*FX-VST3.deb
rm DSP*.deb
echo
cd
wget -c "https://raw.githubusercontent.com/PIBSAS/reaper_tutorial_rpibsas/main/Access Virus C (am29f040b_6v6).zip"
unzip "Access Virus C (am29f040b_6v6).zip"
rm "Access Virus C (am29f040b_6v6).zip"
sudo cp "Access Virus C (am29f040b_6v6).BIN" /usr/local/lib/vst/
cd
echo
titulo "DSP53600 Emulator Installed"
echo
titulo "Getting Samplicity Samples and save to Music Folder I will make one folder if you are not in English OS"
echo
curl -sSL https://raw.githubusercontent.com/PIBSAS/samp/main/get.sh | bash
echo
cd
mkdir Music/
mkdir Music/Bricasti
wget -c "https://cdn.samplicity.com/downloads/Samplicity%20-%20Bricasti%20IRs%20version%202023-10.zip"
unzip Sampli*.zip
rm Sampli*.zip
mv "Samplicity - Bricasti IRs version 2023-10"*/ Music/Bricasti/
echo
titulo "Samples Downloaded"
echo
titulo "Renoise DAW Demo"
echo
cd
wget $(curl -s https://www.renoise.com/download | grep -o 'https://files.renoise.com/demo/Renoise_[^"]*_Demo_Linux_arm64.tar.gz' | head -n 1)
tar -xvzf Renoise*arm64.tar.gz
rm Reno*.tar.gz
cd Renoise*arm64
sudo ./install.sh
echo
titulo "Renoise Demo installed"
echo
titulo "Bespoke DAW"
echo
echo 'deb http://download.opensuse.org/repositories/home:/bespokesynth/xUbuntu_22.04/ /' | sudo tee /etc/apt/sources.list.d/home:bespokesynth.list
curl -fsSL https://download.opensuse.org/repositories/home:bespokesynth/xUbuntu_22.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_bespokesynth.gpg > /dev/null
sudo apt update
sudo apt install bespokesynth
#echo 'deb http://download.opensuse.org/repositories/home:/bespokesynth/Raspbian_11/ /' | sudo tee /etc/apt/sources.list.d/home:bespokesynth.list
#curl -fsSL https://download.opensuse.org/repositories/home:bespokesynth/Raspbian_11/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_bespokesynth.gpg > /dev/null
#sudo apt update
#sudo apt install -y bespokesynth
echo
titulo "SunVox"
echo
cd
wget -c https://warmplace.ru/soft/sunvox/sunvox-${SUN}.zip
unzip sunvox*.zip
rm sunvox*.zip
cd sunvox/sunvox/
rm -rf wince macos linux_x* linux_arm_a* windows_x*
titulo "You still have to do a desktop shortcut"
echo
echo
titulo "Surge XT This will take a lot of time"
echo
cd
git clone https://github.com/surge-synthesizer/surge.git
cd surge
git submodule update --init --recursive
cmake -Bignore/s13clang -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++
cmake --build ignore/s13clang --target surge-xt_Standalone --parallel 3
echo
cd
cd surge
cd ignore
cd s13clang
echo
sudo make install
echo
titulo "Surge XT Plugins installed"
echo
titulo "Compille and Install Stochas"
echo
cd
echo
git clone https://github.com/surge-synthesizer/stochas.git
echo
cd stochas/
echo
git submodule update --depth 1 --init --recursive
echo
export SVER=`cat VERSION`
export GH=`git log -1 --format=%h`
echo "Version ${SVER} hash ${GH}"
echo
sed -i '66 a\#include <utility>' lib/JUCE/modules/juce_core/system/juce_StandardHeader.h
echo
cmake -Bbuild -DSTOCHAS_VERSION=${SVER}
echo
cmake --build build --config Release
echo
cd build
echo
sudo make install
echo
mkdir $HOME/.clap
echo
mkdir $HOME/.vst3
cp -rf $HOME/stochas/build/stochas_artefacts/VST3/Stochas.vst3 $HOME/.vst3
echo
cp -rf $HOME/stochas/build/stochas_artefacts/CLAP/Stochas.clap $HOME/.clap
echo
sudo cp -rf $HOME/stochas/build/stochas_artefacts/Standalone/Stochas /usr/local/bin
rm -rf $HOME/stochas
cd
echo
titulo "Stochas Installed"
echo
echo
titulo "Ninjas 2 Standalone"
echo
titulo "Compile Ninjas 2 Plugins"
echo
cd
git clone --recursive https://github.com/rghvdberg/ninjas2.git
echo
cd ninjas2
echo
make all CXXFLAGS='-mtune=native' CFLAGS='-mtune=native' CPPFLAGS='-mtune=native'
echo
sudo make install
echo
rm -rf ../ninjas2
cd
echo
titulo "Ninjas 2 Installed"
echo
titulo "Finished install on $(uname -m) bits OS, check tutorial for Tukan plugins"
echo
titulo "Now Reboot to take effects changes"
echo
sudo reboot
echo
