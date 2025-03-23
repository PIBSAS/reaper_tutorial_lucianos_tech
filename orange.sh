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
titulo "Adding temp sudoers so the script dont ask you for password again, when script ends, will revert this step"
titulo "Start Reaper Tutorial Install from Luciano's tech this will take some time, so connect Ethernet Cable!"
RENO=Renoise_3_4_4
SUN=2.1.1c
titulo "First the common install for $(uname -m) bit"
titulo "Adding KXStudio Repository to the OS"
cd
url="https://kx.studio/Repositories" ; \
curl -sSL "${url}" > p.html ; \
download=$(awk -F'"' '/kxstudio-repos_[0-9.]*_all.deb/ {print $2}' p.html) ; \
wget -c "${download}"
rm p.html
sudo dpkg -i kxstudio*.deb
rm kxstudio*.deb
sudo apt update
titulo "KXStudio Repo Added"
titulo "Install Plugins and Dependecies"
echo "jackd jackd/tweak_rt_limits boolean true" | sudo debconf-set-selections
sudo apt remove --purge clang -y
sudo apt update
packages=(
    wget curl grep git xz-utils sed gawk p7zip-full unzip build-essential libcairo-dev libcairo2-dev ninja-build
    libxkbcommon-x11-dev libxkbcommon-dev libxcb-cursor0 libxcb-cursor-dev libxcb-keysyms1-dev libxcb-util-dev libxcb-xinerama0
    libxrandr-dev libxinerama-dev libxinerama1 libxcursor-dev libasound2-dev cmake libssl-dev clang libstdc++-12-dev llvm
    libgtk-3-dev libwebkit2gtk-4.1-0 libwebkit2gtk-4.1-dev libcurl4-openssl-dev alsa-base alsa-tools libfreetype6-dev  
    x11proto-xinerama-dev libgl1-mesa-dev qjackctl meterbridge libxcursor1 libx11-dev libsndfile1-dev libsamplerate0-dev
    vitalium zynaddsubfx zynaddsubfx-dssi zynaddsubfx-lv2 zynaddsubfx-vst
    wah-plugins swh-lv2 swankyamp swankyamp-lv2 swankyamp-vst sorcer yoshimi
    carla carla-lv2 helm airwindows cardinal cardinal-lv2 cardinal-vst2 cardinal-vst3
    phasex lmms adlplug ams amsynth ardour drumkv1-lv2 fomp hydrogen padthv1-lv2
    zam-plugins wolf-spectrum wolf-shaper teragonaudio-plugins temper shiro-plugins
    tal-plugins pizmidi-plugins pitcheddelay oxefmsynth obxd mda-lv2 luftikus lufsmeter
    linuxsampler-vst juced-plugins klangfalter juce-opl hybridreverb2 easyssp
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
    tap-plugins vco-plugins vlevel a2jmidid gmidimonitor klick radium-compressor rotter fst-dev foo-yc20 
    freewheeling horgand muse nama gxtuner sox sweep terminatorx ghostess whysynth jack-tools jack-keyboard
    jackd2 qjackrcd qmidiarp qtractor japa jconvolver jkmeter jmeters jnoise jackass libjack-jackd2-dev
)
sudo apt install -y "${packages[@]}"
sudo apt-get install -y --fix-missing
titulo "Install Reaper DAW for $(uname -m)"
cd
rm reaper*
rm -rf reaper_linux_aarch64
web="https://www.reaper.fm/download.php" && last=$(curl -s ${web} | grep -oE 'files/7.x/reaper[0-9]+_linux_aarch64\.tar\.xz') && down="https://www.reaper.fm/${last}" && wget "${down}"
titulo "Untar"
tar -Jxvf reaper*.tar.xz
cd reaper_*
sudo ./install-reaper.sh --install /opt --integrate-desktop --usr-local-bin-symlink --quiet
rm ../reaper*.tar.xz
rm -rf ../reaper_linux*
cd
titulo "REAPER Installed"
titulo "Open then close Reaper to get the new F}olders created in the first run"
reaper &
sleep  10
sudo pkill reaper
titulo "Adding Plugins Paths"
sed -i 's!vstpath=!vstpath=$HOME/.vst;$HOME/.vst3;/lib/vst;/lib/vst3;/lib/lxvst;/usr/lib/vst;/usr/lib/vst3;/usr/lib/lxvst;/usr/local/lib/vst;/usr/local/lib/vst3;/usr/lib/lxvst;/lib/vst/carla.vst/;!' $HOME/.config/REAPER/reaper.ini
echo
sed -i 's!lv2path_linux=!lv2path_linux=/usr/lib/lv2;/usr/local/lib/lv2;$HOME/.lv2;/lib/lv2;/usr/modep/lv2;!' $HOME/.config/REAPER/reaper.ini
echo
sed -i '/^fxdenorm=1.*/i clap_path_linux-aarch64=/usr/local/lib/clap;/usr/lib/clap;$HOME/.clap;%CLAP_PATH%;/lib/clap;/usr/local/lib/clap;' $HOME/.config/REAPER/reaper.ini
echo
titulo "Sequencer Megababy Nandy's Mod"
wget "https://raw.githubusercontent.com/PIBSAS/reaper_tutorial_lucianos_tech/main/sequencer_megababy_nandy_mod" -P $HOME/.config/REAPER/Effects/midi/
titulo "Adding ZynthianOS Plugins"
cd
git clone https://github.com/zynthian/zynthian-plugins.git
cd zynthian-plugins
sudo cp -r * /usr/local/lib
cd
rm -rf zynthian-plugins
titulo "ZynthianOS Plugins Installed"
titulo "LSP Plugins"
url="https://github.com/lsp-plugins/lsp-plugins/releases/latest" ; \
latest_version=$(curl -sSL ${url} | grep -oP '\/lsp-plugins\/lsp-plugins\/releases\/tag\/\K[0-9.]+' | head -n 1 | tr -d '\n') ; \
wget "https://github.com/lsp-plugins/lsp-plugins/releases/download/${latest_version}/lsp-plugins-${latest_version}-Linux-aarch64.7z"
7za x lsp*.7z
cd lsp-plugins-*/
sudo cp -r VST2/* /usr/lib/vst/
sudo cp -r VST3/* /usr/lib/vst3/
sudo cp -r LV2/* /usr/lib/lv2/
sudo cp -r LADSPA/* /usr/lib/ladspa/
sudo cp -r CLAP/* /usr/lib/clap/
sudo cp -r JACK/* /
sudo cp -r GStreamer/* /
cd
rm -rf lsp*
titulo "LSP Plugins Installed"
titulo "X42 Plugins"
titulo "X42 Compressor"
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-compressor-v[0-9.]*-arm64.tar.gz\|x42-compressor-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-compressor-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42-compressor
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "AVL Drums"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-avldrums-v[0-9.]*-arm64.tar.gz\|x42-avldrums-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-avldrums-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "General MIDI Synth"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-gmsynth-v[0-9.]*-arm64.tar.gz\|x42-gmsynth-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-gmsynth-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "MIDI Filter Collection"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-midifilter-v[0-9.]*-arm64.tar.gz\|x42-midifilter-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-midifilter-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Rule Based MIDI Filter"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-midimap-v[0-9.]*-arm64.tar.gz\|x42-midimap-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-midimap-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Step Sequencer"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-stepseq-8x8-v[0-9.]*-arm64.tar.gz\|x42-stepseq-8x8-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-stepseq-8x8-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "SetBfree"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'setBfree-v[0-9.]*-arm64.tar.gz\|setBfree-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}setBfree-v${latest_version}-arm64.tar.gz"
tar -xzvf set*.tar.gz
cd set*/
yes | ./install-lv2.sh
rm -rf ../set*
titulo "Digital Peak Limiter"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-limiter-v[0-9.]*-arm64.tar.gz\|x42-limiter-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-limiter-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Auto Tune"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-autotune-v[0-9.]*-arm64.tar.gz\|x42-autotune-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-autotune-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Zero Config Latency Convolver"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-zconvolver-v[0-9.]*-arm64.tar.gz\|x42-zconvolver-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-zconvolver-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Phase Rotate"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-phaserotate-v[0-9.]*-arm64.tar.gz\|x42-phaserotate-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-phaserotate-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Oscilloscope"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-scope-v[0-9.]*-arm64.tar.gz\|x42-scope-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-scope-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Mixer Trigger Preprocessor"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-mixtrix-v[0-9.]*-arm64.tar.gz\|x42-mixtrix-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-mixtrix-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Spectogram for Geeks"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-spectra-v[0-9.]*-arm64.tar.gz\|x42-spectra-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-spectra-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Test Signal Generator"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-testsignal-v[0-9.]*-arm64.tar.gz\|x42-testsignal-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-testsignal-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Delayline Artificial Latency"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-nodelay-v[0-9.]*-arm64.tar.gz\|x42-nodelay-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-nodelay-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Balance"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-balance-v[0-9.]*-arm64.tar.gz\|x42-balance-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-balance-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Stereo Routing"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-stereoroute-v[0-9.]*-arm64.tar.gz\|x42-stereoroute-v[0-9.]*-[0-9]*-arm64.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-stereoroute-v${latest_version}-arm64.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "X42 Plugins Installed"
titulo "ReaPack"
cd
url="https://github.com/cfillion/reapack/releases/latest/" ; \
latest_version=$(curl -sSL ${url} | grep -o 'tag/v[0-9.]*' | head -n 1 | cut -d '/' -f 2 | sed 's/^v//') ; \
wget -c "https://github.com/cfillion/reapack/releases/download/v${latest_version}/reaper_reapack-aarch64.so"
cp reaper_reapack*.so $HOME/.config/REAPER/UserPlugins/
rm reaper_reapack*.so
titulo "SWS S&M Extension"
cd $HOME/.config/REAPER/
url="https://www.sws-extension.org/download/pre-release/" ; \
html_content=$(curl -sSL "${url}") ; \
download=$(echo "$html_content" | grep -m 1 -oE '<a href="([^"]+\.tar\.xz)">sws-[0-9.]+-Linux-aarch64-[0-9a-f]+\.tar\.xz</a>' | sed -E 's/<a href="([^"]+)".*/\1/')  ; \
full_url="${url}${download}" ; \
wget -c "${full_url}"
tar -Jxvf sws*.tar.xz
rm sws*
titulo "DSP53600 Access Virus C"
titulo "CLAP"
cd
URL="https://dsp56300.com/builds/osirus/"
latest_deb=$(curl -s "${URL}" | grep -o 'DSP56300Emu-[0-9.]*-Linux_aarch64-Osirus-CLAP.deb' | head -n 1)
wget "${URL}${latest_deb}"
URL="https://dsp56300.com/builds/osirus/" ; \
latest_deb=$(curl -s "${URL}" | grep -o 'DSP56300Emu-[0-9.]*-Linux_aarch64-OsirusFX-CLAP.deb' | head -n 1) ; \
wget "${URL}${latest_deb}"
sudo dpkg -i DSP56300Emu*CLAP.deb
sudo dpkg -i DSP56300Emu*FX-CLAP.deb
rm DSP*.deb
titulo "LV2"
URL="https://dsp56300.com/builds/osirus/" ; \
latest_deb=$(curl -s "${URL}" | grep -o 'DSP56300Emu-[0-9.]*-Linux_aarch64-Osirus-LV2.deb' | head -n 1) ; \
wget "${URL}${latest_deb}"
URL="https://dsp56300.com/builds/osirus/" ; \
latest_deb=$(curl -s "${URL}" | grep -o 'DSP56300Emu-[0-9.]*-Linux_aarch64-OsirusFX-LV2.deb' | head -n 1) ; \
wget "${URL}${latest_deb}"
sudo dpkg -i DSP56300Emu*LV2.deb
sudo dpkg -i DSP56300Emu*FX-LV2.deb
rm DSP*.deb
titulo "VST2"
URL="https://dsp56300.com/builds/osirus/" ; \
latest_deb=$(curl -s "${URL}" | grep -o 'DSP56300Emu-[0-9.]*-Linux_aarch64-Osirus-VST2.deb' | head -n 1) ; \
wget "${URL}${latest_deb}"
URL="https://dsp56300.com/builds/osirus/" ; \
latest_deb=$(curl -s "${URL}" | grep -o 'DSP56300Emu-[0-9.]*-Linux_aarch64-OsirusFX-VST2.deb' | head -n 1) ; \
wget "${URL}${latest_deb}"
sudo dpkg -i DSP56300Emu*VST2.deb
sudo dpkg -i DSP56300Emu*FX-VST2.deb
rm DSP*.deb
titulo "VST3"
URL="https://dsp56300.com/builds/osirus/" ; \
latest_deb=$(curl -s "${URL}" | grep -o 'DSP56300Emu-[0-9.]*-Linux_aarch64-Osirus-VST3.deb' | head -n 1) ; \
wget "${URL}${latest_deb}"
URL="https://dsp56300.com/builds/osirus/" ; \
latest_deb=$(curl -s "${URL}" | grep -o 'DSP56300Emu-[0-9.]*-Linux_aarch64-OsirusFX-VST3.deb' | head -n 1) ; \
wget "${URL}${latest_deb}"
sudo dpkg -i DSP56300Emu*VST3.deb
sudo dpkg -i DSP56300Emu*FX-VST3.deb
rm DSP*.deb
wget -c "https://raw.githubusercontent.com/PIBSAS/reaper_tutorial_lucianos_tech/main/Access Virus C (am29f040b_6v6).zip"
unzip "Access Virus C (am29f040b_6v6).zip"
rm "Access Virus C (am29f040b_6v6).zip"
sudo cp "Access Virus C (am29f040b_6v6).BIN" /usr/local/lib/vst/
titulo "DSP53600 Emulator Installed"
titulo "Getting Samplicity Samples and save to Music Folder I will make one folder if you are not in English OS"
cd
curl -sSL https://raw.githubusercontent.com/PIBSAS/samp/main/get.sh | bash
cd
if [ ! -d "$HOME/Music/" ]; then
    mkdir "$HOME/Music/"
fi
mkdir "$HOME/Music/Bricasti"
wget -c "https://cdn.samplicity.com/downloads/Samplicity%20-%20Bricasti%20IRs%20version%202023-10.zip"
unzip Sampli*.zip
rm Sampli*.zip
mv "Samplicity - Bricasti IRs version 2023-10"*/ Music/Bricasti/
titulo "Samples Downloaded"
titulo "Renoise DAW Demo"
cd
wget $(curl -s https://www.renoise.com/download | grep -o 'https://files.renoise.com/demo/Renoise_[^"]*_Demo_Linux_arm64.tar.gz' | head -n 1)
tar -xvzf Renoise*arm64.tar.gz
rm Reno*.tar.gz
cd Renoise*arm64
sudo ./install.sh
titulo "Renoise Demo installed"
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
titulo "Compille and Install Stochas"
cd
if [ -d "$HOME/stochas" ]; then
    rm -rf "$HOME/stochas"
fi
git clone --depth=1 https://github.com/surge-synthesizer/stochas.git
cd stochas/
git submodule update --init --recursive --depth=1
#export SVER=`cat VERSION`
#export GH=`git log -1 --format=%h`
export SVER=$(<VERSION)
export GH=$(git rev-parse --short HEAD)
echo "Version ${SVER} hash ${GH}"
#grep -q "#include <utility>" lib/JUCE/modules/juce_core/system/juce_StandardHeader.h || sed -i '66 a\#include <utility>' lib/JUCE/modules/juce_core/system/juce_StandardHeader.h
#sed -i '66 a\#include <utility>' lib/JUCE/modules/juce_core/system/juce_StandardHeader.h
#cmake -Bbuild -DSTOCHAS_VERSION=${SVER}
cmake -Bbuild -DSTOCHAS_VERSION=${SVER} -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release
cd build
sudo make install
if [ ! -d "$HOME/.clap" ]; then
    mkdir "$HOME/.clap"
fi

if [ ! -d "$HOME/.vst3" ]; then
    mkdir "$HOME/.vst3"
fi
#cp -rf $HOME/stochas/build/stochas_artefacts/VST3/Stochas.vst3 $HOME/.vst3
cp -rf $HOME/stochas/build/stochas_artefacts/VST3/* $HOME/.vst3
cp -rf $HOME/stochas/build/stochas_artefacts/CLAP/Stochas.clap $HOME/.clap
sudo cp -rf $HOME/stochas/build/stochas_artefacts/Standalone/Stochas /usr/local/bin
rm -rf $HOME/stochas
titulo "Stochas Installed"
titulo "Ninjas 2 Standalone"
titulo "Compile Ninjas 2 Plugins"
cd
if [ -d "$HOME/ninjas2" ]; then
    rm -rf "$HOME/ninjas2"
fi
git clone --recursive https://github.com/rghvdberg/ninjas2.git
cd ninjas2
make -j$(nproc) all CXXFLAGS='-march=native' CFLAGS='-march=native' CPPFLAGS='-march=native'
sudo make install -j$(nproc)
rm -rf "$HOME/ninjas2"
cd
titulo "Ninjas 2 Installed"
titulo "Finished install on $(uname -m) bits OS, check tutorial for Tukan plugins"
titulo "Reverting sudoers temp file, please make sure reboot..."
sudo rm -f "$SUDOERS_TEMP_FILE"
titulo "Now Reboot to take effects changes"
