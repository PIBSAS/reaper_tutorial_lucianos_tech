#! /bin/bash
#########################################################################################################################
#################################/////RASPBERRY PI BUENOS AIRES/////#####################################################
#########################################################################################################################
echo
echo "Start Reaper Tutorial Install from Raspberry Pi Buenos Aires this will take some time, so connect Ethernet Cable!"
echo
ARCH=64
#Versions
REAPER=682
KX=11.1.0
LSP=1.2.10
X42=0.6.5
CMAKE=3.27.4
REAPACK=1.2.4.3
DSP=1.2.30
echo
echo "First the common install for Pi OS $ARCH bit"
echo
echo
echo "########################################"
echo "##### Install Reaper DAW for armhf #####"
echo "########################################"
cd
rm reaper*.tar.xz
rm -rf reaper_linux_aarch64
wget -c https://www.reaper.fm/files/6.x/reaper${REAPER}_linux_aarch64.tar.xz
echo
echo "Untar"
echo
tar -Jxvf reaper*.tar.xz
echo
cd reaper_linux_aarch64
sudo ./install-reaper.sh --install /opt --integrate-desktop --usr-local-bin-symlink --quiet
echo
rm ../reaper*.tar.xz
rm -rf ../reaper_linux_aarch64
echo
echo "REAPER Installed"
echo
echo "Open then close Reaper to get the new Folders created in the first run"
echo
reaper &
sleep  10
sudo pkill reaper
echo
echo
echo "##########################################"
echo "## Adding KXStudio Repository to the OS ##"
echo "##########################################"
cd
wget -c https://launchpad.net/~kxstudio-debian/+archive/ubuntu/kxstudio/+files/kxstudio-repos_${KX}_all.deb
sudo dpkg -i kxstudio*.deb
rm kxstudio-repos_${KX}_all.deb
sudo apt update
echo
echo "KXStudio Repo Added"
echo
echo
echo "#####################################"
echo "########## Install Plugins ##########"
echo "#####################################"
echo
sudo apt install -y vitalium zynaddsubfx zynaddsubfx-dssi zynaddsubfx-lv2 zynaddsubfx-vst wah-plugins swh-lv2 swankyamp swankyamp-lv2 swankyamp-vst sorcer yoshimi carla carla-lv2 helm airwindows cardinal cardinal-lv2 cardinal-vst2 cardinal-vst3 phasex lmms adlplug ams amsynth ardour drumkv1-lv2 fomp hydrogen padthv1-lv2 zam-plugins wolf-spectrum wolf-shaper teragonaudio-plugins temper shiro-plugins tal-plugins pizmidi-plugins pitcheddelay oxefmsynth obxd mda-lv2 luftikus lsp-plugins-vst lufsmeter linuxsampler-vst juced-plugins klangfalter juce-opl jackass hybridreverb2 easyssp drumgizmo drowaudio-plugins dpf-plugins distrho-plugin-ports dexed arctican-plugins vocproc tap-lv2 synthv1-lv2 zlfo so-synth-lv2 sherlock.lv2 samplv1-lv2 rubberband-lv2 noise-repellent moony.lv2 mod-pitchshifter mod-distortion melmatcheq.lv2 lv2vocoder kxstudio-recommended-audio-plugins-lv2 infamous-plugins gxvoxtonebender gxplugins guitarix-lv2 guitarix-ladspa geonkick eq10q drmr caps-lv2 calf-plugins bshapr bsequencer blop-lv2 bjumblr beatslash-lv2 avldrums.lv2 abgate fabla wolpertinger iem-plugin-suite-vst cv-lfo-blender-lv2
sudo apt install -y build-essential libcairo-dev libxkbcommon-x11-dev libxkbcommon-dev libxcb-cursor-dev libxcb-keysyms1-dev libxcb-util-dev libxrandr-dev libxinerama-dev libxcursor-dev libasound2-dev libjack-jackd2-dev cmake
echo
echo
echo
echo "##########################################"
echo "####### Adding ZynthianOS Plugins ########"
echo "##########################################"
echo
cd
git clone https://github.com/zynthian/zynthian-plugins.git
echo
cd zynthian-plugins
sudo cp -r * /usr/local/lib
cd
rm -rf zynthian-plugins
echo
echo "ZynthianOS Plugins Installed"
echo
echo
echo "#################################"
echo "########## LSP Plugins ##########"
echo "#################################"
echo
echo "################"
echo "##### VST2 #####"
echo "################"
echo
cd
wget -c https://sourceforge.net/projects/lsp-plugins/files/lsp-plugins/${LSP}/Linux-aarch64/lsp-plugins-vst2-${LSP}-Linux-aarch64.tar.gz
echo
tar -xzvf lsp-plugins-vst*.tar.gz
cd lsp-plugins-vst2-${LSP}-Linux-aarch64/
sudo cp -r usr/* /usr
echo
echo "VST2 Installed"
echo
echo
echo "###############"
echo "##### LV2 #####"
echo "###############"
echo
echo
cd
wget -c https://sourceforge.net/projects/lsp-plugins/files/lsp-plugins/${LSP}/Linux-aarch64/lsp-plugins-lv2-${LSP}-Linux-aarch64.tar.gz
echo
tar -xzvf lsp-plugins-lv2*.tar.gz
cd lsp-plugins-lv2-${LSP}-Linux-aarch64/
sudo cp -r usr/* /usr
echo
echo "LV2 Installed"
echo
echo
echo "################"
echo "##### JACK #####"
echo "################"
echo
echo
cd
wget -c https://sourceforge.net/projects/lsp-plugins/files/lsp-plugins/${LSP}/Linux-aarch64/lsp-plugins-jack-${LSP}-Linux-aarch64.tar.gz
echo
tar -xzvf lsp-plugins-jack*.tar.gz
cd lsp-plugins-jack-${LSP}-Linux-aarch64/
sudo cp -r usr/* /usr
echo
echo "JACK Installed"
echo
echo
echo "##################"
echo "##### LADSPA #####"
echo "##################"
echo
echo
cd
wget -c https://sourceforge.net/projects/lsp-plugins/files/lsp-plugins/${LSP}/Linux-aarch64/lsp-plugins-ladspa-${LSP}-Linux-aarch64.tar.gz
echo
tar -xzvf lsp-plugins-ladspa*.tar.gz
cd lsp-plugins-ladspa-${LSP}-Linux-aarch64/
sudo cp -r usr/* /usr
echo
echo "LADSPA Installed"
echo
echo
echo "################"
echo "##### CLAP #####"
echo "################"
echo
echo
cd
wget -c https://sourceforge.net/projects/lsp-plugins/files/lsp-plugins/${LSP}/Linux-aarch64/lsp-plugins-clap-${LSP}-Linux-aarch64.tar.gz
echo
tar -xzvf lsp-plugins-clap*.tar.gz
cd lsp-plugins-clap-${LSP}-Linux-aarch64/
sudo cp -r usr/* /usr
echo
echo "CLAP Installed"
echo
cd
rm -rf lsp*
echo
echo "LSP Installed"
echo
echo
echo
echo "#################################################"
echo "##### Surge XT This will take a lot of time #####"
echo "#################################################"
echo
cd
git clone https://github.com/surge-synthesizer/surge.git
cd surge
git submodule update --init --recursive
sudo apt install -y clang
cmake -Bignore/s13clang -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++
cmake --build ignore/s13clang --target surge-xt_Standalone --parallel 3
echo
cd
cd surge
cd ignore
cd s13clang
echo
sudo cmake --install .
echo
echo "Surge XT Plugins installed"
echo
echo
echo
echo "#######################"
echo "##### X42 Plugins #####"
echo "#######################"
echo
echo
cd
wget -c http://x42-plugins.com/x42/linux/x42-compressor-v${X42}-arm64.tar.gz
echo
tar -xzvf x42*.tar.gz
cd x42-compressor
yes | ./install-lv2.sh
rm -rf ../x42*
cd
echo
echo "X42 Installed"
echo
echo
echo "##########################################################"
echo "##### Compile and install CMake requiered by Stochas #####"
echo "##########################################################"
sudo apt update
sudo apt install -y libssl-dev
wget -c https://github.com/Kitware/CMake/releases/download/v${CMAKE}/cmake-${CMAKE}.tar.gz
tar -xf cmake*.tar.gz
cd cmake*/
./bootstrap
gmake
sudo make install
echo
echo "Clean"
echo
rm -rf $HOME/cmake*/
rm $HOME/cmake*.gz
echo
echo "CMAKE compiled"
echo
echo
echo "########################################"
echo "##### Compille and Install Stochas #####"
echo "########################################"
echo
echo
cd
sudo apt update
echo
sudo apt-get install -y git build-essential libgtk-3-dev libwebkit2gtk-4.0 libwebkit2gtk-4.0-dev libcurl4-openssl-dev alsa-tools libasound2-dev libjack-dev libfreetype6-dev libxinerama-dev libxcb-xinerama0 libxinerama1 x11proto-xinerama-dev libxrandr-dev libgl1-mesa-dev libxcursor-dev libxcursor1 libxcb-cursor-dev libxcb-cursor0
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
cmake -Bbuild -DSTOCHAS_VERSION=${SVER}
echo
cmake --build build --config Release
echo
mkdir $HOME/.vst3
cp -rf $HOME/stochas/build/stochas_artefacts/VST3/Stochas.vst3 $HOME/.vst3
rm -rf $HOME/stochas
cd
echo
echo "Stochas Installed"
echo
echo
echo "###############################"
echo "##### Ninjas 2 Standalone #####"
echo "###############################"
echo
sudo apt install -y libjack-jackd2-dev
echo
echo
echo "##########################################"
echo "######## Compile Ninjas 2 Plugins ########"
echo "##########################################"
echo
cd
sudo apt install -y libgl1-mesa-dev libx11-dev libsndfile1-dev libsamplerate0-dev
echo
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
echo "Ninjas 2 Installed"
echo
echo
echo "###################"
echo "##### ReaPack #####"
echo "###################"
echo
cd
wget -c https://github.com/cfillion/reapack/releases/download/v${REAPACK}/reaper_reapack-aarch64.so
cp reaper_reapack*.so $HOME/.config/REAPER/UserPlugins/
rm reaper_reapack*.so
echo
echo
echo "#############################"
echo "##### SWS S&M Extension #####"
echo "#############################"
echo
echo
cd $HOME/.config/REAPER/
wget -c https://sws-extension.org/download/featured/sws-2.12.1.3-Linux-aarch64.tar.xz
tar -Jxvf sws*.tar.xz
rm sws*
cd
echo
echo "###################################"
echo "##### DSP53600 Access Virus C #####"
echo "###################################"
echo
cd
wget -c https://futurenoize.com/dsp56300/builds/master/DSP56300Emu-${DSP}-Linux_aarch64-Osirus-VST2.deb
wget -c https://futurenoize.com/dsp56300/builds/master/DSP56300Emu-${DSP}-Linux_aarch64-OsirusFX-VST2.deb
sudo dpkg -i DSP56300Emu*VST2.deb
sudo dpkg -i DSP56300Emu*FX-VST2.deb
cd
wget -c "https://archive.org/download/access-virus-b-c-roms/Access%20Virus%20C%20%28am29f040b_6v6%29.zip/Access%20Virus%20C%20%28am29f040b_6v6%29.BIN"
sudo cp "Access Virus C (am29f040b_6v6).BIN" /usr/local/lib/vst/
rm "Access Virus C (am29f040b_6v6).BIN"
cd
echo
echo "DSP53600 Emulator Installed"
echo
echo
echo "####################################################################################################################"
echo "##### Getting Samplicity Samples and save to Music Folder I will make one folder if you are not  in English OS #####"
echo "####################################################################################################################"
mkdir Music
wget -c https://archive.org/download/Samplicity/Samplicity_M7_Main-02-Wave32bit-48Khz_v1.1.zip
unzip Sampli*.zip
rm Sampli*.zip
mv "Samplicity M7 Main - 02 - Wave, 32 bit, 48 Khz, v1.1"/ Music/
echo
echo "Samples Downloaded"
echo
echo "Finished install on $ARCH bits OS, check tutorial for Tukan plugins"
echo
echo "Now Reboot your Pi"
echo
