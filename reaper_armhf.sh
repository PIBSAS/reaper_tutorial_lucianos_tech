#! /bin/bash
#########################################################################################################################
#################################/////LUCIANO'S TECH/////#####################################################
#########################################################################################################################
# Repositorio: Reaper Tutorial 2025
# Por: Raspberry Pi Buenos Aires ("https://sites.google.com/view/lucianostech/)
# License: http://creativecommons.org/licenses/by-sa/4.0/
#########################################################################################################################
#########################################################################################################################
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
titulo "Start Reaper Tutorial Install from Luciano's tech this will take some time, so connect Ethernet Cable!"
titulo "Requirements for $(uname -m)"
sudo apt install -y wget curl grep git xz-utils sed gawk p7zip-full
titulo "Install Reaper DAW for $(uname -m)"
sudo apt install -y wget curl grep git xz-utils
cd
rm -rf reaper*
web="https://www.reaper.fm/download.php" && last=$(curl -s ${web} | grep -oE 'files/7.x/reaper[0-9]+_linux_armv7l\.tar\.xz') && down="https://www.reaper.fm/${last}" && wget "${down}"
titulo "Untar"
tar -Jxvf reaper*.tar.xz
cd reaper_*
sudo ./install-reaper.sh --install /opt --integrate-desktop --usr-local-bin-symlink --quiet
rm ../reaper*.tar.xz
rm -rf ../reaper_linux*
titulo "REAPER Installed"
titulo "Open then close Reaper to get the new Folders created in the first run"
reaper &
sleep  10
sudo pkill reaper
titulo "Adding Plugins Paths"
sed -i 's!vstpath=!vstpath=$HOME/.vst;$HOME/.vst3;/lib/vst;/lib/vst3;/lib/lxvst;/usr/lib/vst;/usr/lib/vst3;/usr/lib/lxvst;/usr/local/lib/vst;/usr/local/lib/vst3;/usr/lib/lxvst;/lib/vst/carla.vst/;!' $HOME/.config/REAPER/reaper.ini
sed -i 's!lv2path_linux=!lv2path_linux=/usr/lib/lv2;/usr/local/lib/lv2;$HOME/.lv2;/lib/lv2;/usr/modep/lv2;!' $HOME/.config/REAPER/reaper.ini
sed -i '/^fxdenorm=1.*/i clap_path_linux-aarch64=/usr/local/lib/clap;/usr/lib/clap;$HOME/.clap;%CLAP_PATH%;/lib/clap;/usr/local/lib/clap;' $HOME/.config/REAPER/reaper.ini
titulo "First the common install for architecture OS"
titulo "ReaPack"
cd
url="https://github.com/cfillion/reapack/releases/latest/" ; \
latest_version=$(curl -sSL ${url} | grep -o 'tag/v[0-9.]*' | head -n 1 | cut -d '/' -f 2 | sed 's/^v//') ; \
wget -c "https://github.com/cfillion/reapack/releases/download/v${latest_version}/reaper_reapack-aarch64.so"
cp reaper_reapack*.so $HOME/.config/REAPER/UserPlugins/
rm reaper_reapack*.so
titulo "ReaPack Repositories Setup from Luciano's Tech"
bash <(curl -fsSL https://raw.githubusercontent.com/PIBSAS/reaper_tutorial_lucianos_tech/main/repos_reapack.sh)
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
titulo "Install Plugins"
sudo apt install -y vitalium zynaddsubfx zynaddsubfx-dssi zynaddsubfx-lv2 zynaddsubfx-vst wah-plugins swh-lv2 swankyamp swankyamp-lv2 swankyamp-vst sorcer yoshimi carla carla-lv2 helm airwindows cardinal cardinal-lv2 cardinal-vst2 cardinal-vst3 phasex lmms petri-foo adlplug ams amsynth ardour drumkv1-lv2 fomp hydrogen padthv1-lv2 zam-plugins wolf-spectrum wolf-shaper teragonaudio-plugins temper shiro-plugins tal-plugins pizmidi-plugins pitcheddelay oxefmsynth obxd mda-lv2 luftikus lufsmeter linuxsampler-vst juced-plugins klangfalter juce-opl jackass hybridreverb2 easyssp drumgizmo drowaudio-plugins dpf-plugins dpf-plugins-common dpf-plugins-dssi dpf-plugins-lv2 dpf-plugins-vst distrho-plugin-ports dexed arctican-plugins vocproc tap-lv2 synthv1 synthv1-lv2 zlfo so-synth-lv2 sherlock.lv2 samplv1 samplv1-lv2 rubberband-lv2 noise-repellent moony.lv2 mod-pitchshifter mod-distortion melmatcheq.lv2 lv2vocoder kxstudio-recommended-audio-plugins-lv2 infamous-plugins gxvoxtonebender gxplugins guitarix geonkick eq10q drmr caps-lv2 calf-plugins calf-ladspa bshapr bsequencer blop-lv2 bjumblr beatslash-lv2 avldrums.lv2 abgate fabla wolpertinger
titulo "Sequencer Megababy Nandy's Mod"
wget https://raw.githubusercontent.com/PIBSAS/reaper_tutorial_lucianos_tech/main/sequencer_megababy_nandy_mod -P $HOME/.config/REAPER/Effects/midi/
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
wget "https://github.com/lsp-plugins/lsp-plugins/releases/download/${latest_version}/lsp-plugins-${latest_version}-Linux-arm32.7z"
7za x lsp*.7z
cd lsp-plugins-*/
sudo cp -r VST2/* /usr/lib/vst/
sudo cp -r VST3/* /usr/lib/vst3/
sudo cp -r LV2/* /usr/lib/lv2/
#sudo mkdir /usr/lib/ladspa /usr/lib/clap
if [ ! -d "/usr/lib/ladspa" ]; then
    sudo mkdir "/usr/lib/ladspa"
fi

if [ ! -d "/usr/lib/clap" ]; then
    sudo mkdir "/usr/lib/clap"
fi
sudo cp -r LADSPA/* /usr/lib/ladspa/
sudo cp -r CLAP/* /usr/lib/clap/
sudo cp -r JACK/* /
sudo cp -r GStreamer/* /
cd
rm -rf lsp*
titulo "LSP Plugins Installed"
titulo "Surge 1.8.1"
sudo apt remove surge
sudo apt autoremove -y
if [ -d "$HOME/surge" ]; then
    rm -rf "$HOME/surge"
fi
git clone -b release/1.8.1 https://github.com/surge-synthesizer/surge
cd surge
git submodule update --init --recursive
sudo apt-get update
sudo apt-get install -y libgtk-3-dev
sudo apt-get install -y libwebkit2gtk-4.0
sudo apt-get install -y libwebkit2gtk-4.0-dev
sudo apt-get install -y libcurl4-openssl-dev
sudo apt-get install -y alsa
sudo apt-get install -y alsa-tools
sudo apt-get install -y libasound2-dev
sudo apt-get install -y libjack-dev
sudo apt-get install -y libfreetype6-dev
sudo apt-get install -y libxinerama-dev
sudo apt-get install -y libxcb-xinerama0
sudo apt-get install -y libxinerama1
sudo apt-get install -y x11proto-xinerama-dev
sudo apt-get install -y libxrandr-dev
sudo apt-get install -y libgl1-mesa-dev
sudo apt-get install -y libxcursor-dev
sudo apt-get install -y libxcursor1
sudo apt-get install -y libxcb-cursor-dev
sudo apt-get install -y libxcb-cursor0
sudo apt-get install -y --fix-missing
sudo apt install -y build-essential libcairo-dev libxkbcommon-x11-dev libxkbcommon-dev libxcb-cursor-dev libxcb-keysyms1-dev libxcb-util-dev libxrandr-dev libxinerama-dev libxcursor-dev libasound2-dev libjack-jackd2-dev
cd
cd surge
./build-linux.sh build
sudo ./build-linux.sh install
rm -rf "$HOME/stochas"
titulo "Surge Installed"
titulo "X42 Plugins"
titulo "X42 Compressor"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-compressor-v[0-9.]*-armhf.tar.gz\|x42-compressor-v[0-9.]*-[0-9]*-armhf.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-compressor-v${latest_version}-armhf.tar.gz"
tar -xzvf x42*.tar.gz
cd x42-compressor
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "AVL Drums"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-avldrums-v[0-9.]*-armhf.tar.gz\|x42-avldrums-v[0-9.]*-[0-9]*-armhf.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-avldrums-v${latest_version}-armhf.tar.gz"
tar -xzvf x42*.tar.gz
cd x42-compressor
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "General MIDI Synth"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-gmsynth-v[0-9.]*-armhf.tar.gz\|x42-gmsynth-v[0-9.]*-[0-9]*-armhf.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-gmsynth-v${latest_version}-armhf.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "MIDI Filter Collection"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-midifilter-v[0-9.]*-armhf.tar.gz\|x42-midifilter-v[0-9.]*-[0-9]*-armhf.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-midifilter-v${latest_version}-armhf.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Rule Based MIDI Filter"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-midimap-v[0-9.]*-armhf.tar.gz\|x42-midimap-v[0-9.]*-[0-9]*-armhf.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-midimap-v${latest_version}-armhf.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.s
rm -rf ../x42*
titulo "Step Sequencer"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-stepseq-8x8-v[0-9.]*-armhf.tar.gz\|x42-stepseq-8x8-v[0-9.]*-[0-9]*-armhf.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-stepseq-8x8-v${latest_version}-armhf.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "SetBfree"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'setBfree-v[0-9.]*-armhf.tar.gz\|setBfree-v[0-9.]*-[0-9]*-armhf.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}setBfree-v${latest_version}-armhf.tar.gz"
tar -xzvf set*.tar.gz
cd set*/
yes | ./install-lv2.sh
rm -rf ../set*
titulo "Digital Peak Limiter"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-limiter-v[0-9.]*-armhf.tar.gz\|x42-limiter-v[0-9.]*-[0-9]*-armhf.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-limiter-v${latest_version}-armhf.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Auto Tune"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-autotune-v[0-9.]*-armhf.tar.gz\|x42-autotune-v[0-9.]*-[0-9]*-armhf.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-autotune-v${latest_version}-armhf.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Zero Config Latency Convolver"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-zconvolver-v[0-9.]*-armhf.tar.gz\|x42-zconvolver-v[0-9.]*-[0-9]*-armhf.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-zconvolver-v${latest_version}-armhf.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Phase Rotate"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-phaserotate-v[0-9.]*-armhf.tar.gz\|x42-phaserotate-v[0-9.]*-[0-9]*-armhf.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-phaserotate-v${latest_version}-armhf.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Oscilloscope"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-scope-v[0-9.]*-armhf.tar.gz\|x42-scope-v[0-9.]*-[0-9]*-armhf.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-scope-v${latest_version}-armhf.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Mixer Trigger Preprocessor"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-mixtrix-v[0-9.]*-armhf.tar.gz\|x42-mixtrix-v[0-9.]*-[0-9]*-armhf.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-mixtrix-v${latest_version}-armhf.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Spectogram for Geeks"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-spectra-v[0-9.]*-armhf.tar.gz\|x42-spectra-v[0-9.]*-[0-9]*-armhf.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-spectra-v${latest_version}-armhf.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Test Signal Generator"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-testsignal-v[0-9.]*-armhf.tar.gz\|x42-testsignal-v[0-9.]*-[0-9]*-armhf.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-testsignal-v${latest_version}-armhf.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Delayline Artificial Latency"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-nodelay-v[0-9.]*-armhf.tar.gz\|x42-nodelay-v[0-9.]*-[0-9]*-armhf.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-nodelay-v${latest_version}-armhf.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Balance"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-balance-v[0-9.]*-armhf.tar.gz\|x42-balance-v[0-9.]*-[0-9]*-armhf.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-balance-v${latest_version}-armhf.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "Stereo Routing"
cd
url="https://x42-plugins.com/x42/linux/"
latest_version=$(curl -sSL ${url} | grep -o 'x42-stereoroute-v[0-9.]*-armhf.tar.gz\|x42-stereoroute-v[0-9.]*-[0-9]*-armhf.tar.gz' | grep -oP 'v\K[0-9.]*(-[0-9]+)?' | sort -V | tail -n 1)
wget -c "${url}x42-stereoroute-v${latest_version}-armhf.tar.gz"
tar -xzvf x42*.tar.gz
cd x42*/
yes | ./install-lv2.sh
rm -rf ../x42*
titulo "X42 Plugins Installed"
titulo "Compile and install CMake requiered by Stochas"
sudo apt update
sudo apt install -y libssl-dev
url="https://github.com/Kitware/CMake/releases/latest/" ; \
CMAKE=$(curl -sSL ${url} | grep -o 'tag/v[0-9.]*' | head -n 1 | cut -d '/' -f 2 | sed 's/^v//') ; \
wget -c "https://github.com/Kitware/CMake/releases/download/v${CMAKE}/cmake-${CMAKE}.tar.gz"
tar -xf cmake*.tar.gz
cd cmake*/
./bootstrap
gmake
sudo make install
rm -rf $HOME/cmake*/
rm $HOME/cmake*.gz
titulo "CMake compiled"
titulo "Compile and Install Stochas"
cd
if [ -d "$HOME/stochas" ]; then
    rm -rf "$HOME/stochas"
fi
sudo apt update
sudo apt-get install -y git build-essential libgtk-3-dev libwebkit2gtk-4.0 libwebkit2gtk-4.0-dev libcurl4-openssl-dev alsa-tools libasound2-dev libjack-dev libfreetype6-dev libxinerama-dev libxcb-xinerama0 libxinerama1 x11proto-xinerama-dev libxrandr-dev libgl1-mesa-dev libxcursor-dev libxcursor1 libxcb-cursor-dev libxcb-cursor0
git clone https://github.com/surge-synthesizer/stochas.git
cd stochas/
git submodule update --init --recursive --depth=1
#git submodule update --depth 1 --init --recursive
#export SVER=`cat VERSION`
#export GH=`git log -1 --format=%h`
export SVER=$(<VERSION)
export GH=$(git rev-parse --short HEAD)
echo "Version ${SVER} hash ${GH}"
#cmake -Bbuild -DSTOCHAS_VERSION=${SVER}
#cmake --build build --config Release
cmake -Bbuild -DSTOCHAS_VERSION=${SVER} -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release
cp -rf $HOME/stochas/build/stochas_artefacts/VST3/* $HOME/.vst3
rm -rf $HOME/stochas
titulo "Stochas Installed"
titulo "Ninjas 2 Standalone"
sudo apt install -y libjack-dev
titulo "Compile Ninjas 2 Plugins"
cd
if [ -d "$HOME/ninjas2" ]; then
    rm -rf "$HOME/ninjas2"
fi
sudo apt install -y libgl1-mesa-dev libx11-dev libsndfile1-dev libsamplerate0-dev
git clone --recursive https://github.com/rghvdberg/ninjas2.git
cd ninjas2
make -j$(nproc) all CXXFLAGS='-march=native' CFLAGS='-march=native' CPPFLAGS='-march=native'
sudo make install -j$(nproc)
rm -rf "$HOME/ninjas2"
titulo "Ninjas 2 Installed"
titulo "SWS S&M Extension"
cd $HOME/.config/REAPER/
url="https://www.sws-extension.org/download/pre-release/" ; \
html_content=$(curl -sSL "${url}") \
download=$(echo "$html_content" | grep -m 1 -oE '<a href="([^"]+\.tar\.xz)">sws-[0-9.]+-Linux-armv7l-[0-9a-f]+\.tar\.xz</a>' | sed -E 's/<a href="([^"]+)".*/\1/')  ; \
full_url="${url}${download}" ; \
wget -c "${full_url}"
tar -Jxvf sws*.tar.xz
rm sws*
titulo "SWS S&M Extension Installed"
titulo "Adding PatchboxOS Repo"
cd
curl https://blokas.io/apt-setup.sh | sh
titulo "Installing MODEP PiSound"
sudo apt update
sudo apt install -y pisound pisound-btn pisound-ctl pisound-ctl-scripts-common pisound-ctl-scripts-puredata pisound-ctl-scripts-system modep modep-browsepy modep-btn-scripts modep-common modep-ctl-scripts modep-demo-content modep-fluidsynth modep-lv2-amsynth modep-lv2-artyfx modep-lv2-bolliedelay modep-lv2-calf modep-lv2-caps modep-lv2-dpf-plugins modep-lv2-fat1 modep-lv2-fil4 modep-lv2-fluidplug modep-lv2-fomp modep-lv2-freaked modep-lv2-guitarix modep-lv2-gx-slowgear modep-lv2-gx-switchless-wah modep-lv2-infamousplugins modep-lv2-invada-studio modep-lv2-mclk modep-lv2-mda modep-lv2-midifilter modep-lv2-midigen modep-lv2-mod-distortion modep-lv2-mod-pitchshifter modep-lv2-mod-utilities modep-lv2-mtc modep-lv2-rkrlv2 modep-lv2-setbfree modep-lv2-shiroplugins modep-lv2-sooperlooper modep-lv2-stepseq modep-lv2-tap modep-lv2-tinygain modep-lv2-triceratops modep-lv2-tuna modep-lv2-xfade modep-lv2-zam-plugins modep-mod-host modep-mod-midi-merger modep-mod-ui modep-touchosc2midi
titulo "Installing PureData, Mec, ORAC"
sudo apt install puredata mec orac -y
titulo "Getting Samplicity Samples and save to Music Folder. I will make one folder if you are not on English OS"
cd
curl -sSL https://raw.githubusercontent.com/PIBSAS/samp/main/get.sh | bash
cd
mkdir Music/
mkdir Music/Bricasti
wget -c "https://cdn.samplicity.com/downloads/Samplicity%20-%20Bricasti%20IRs%20version%202023-10.zip"
unzip Sampli*.zip
rm Sampli*.zip
mv "Samplicity - Bricasti IRs version 2023-10"*/ Music/Bricasti/
titulo "Samples Downloaded"
titulo "Renoise Demo"
cd
wget $(curl -s https://www.renoise.com/download | grep -o 'https://files.renoise.com/demo/Renoise_[^"]*_Demo_Linux_armhf.tar.gz' | head -n 1)
tar -xvzf Renoise*armhf.tar.gz
rm Reno*.tar.gz
cd Renoise*armhf
sudo ./install.sh
titulo "Finished install on $(uname -m) OS, check tutorial for Tukan plugins"
titulo "Reboot the Pi"
sudo reboot
