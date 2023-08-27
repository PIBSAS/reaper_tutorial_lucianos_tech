#! /bin/bash
echo "Start Reaper Tutorial Install from Raspberry Pi Buenos Aires this will take some time, so connect Ethernet Cable!"
ver=682
cd
rm reaper*.tar.xz
rm -rf reaper_linux_aarch64
wget -c https://www.reaper.fm/files/6.x/reaper${ver}_linux_aarch64.tar.xz
tar -Jxvf reaper*.tar.xz
cd reaper_linux_aarch64
sudo ./install-reaper.sh --install /opt --integrate-desktop --usr-local-bin-symlink --quiet
rm ../reaper*.tar.xz
rm -rf ../reaper_linux_armv7l
ver=11.1.0
cd
wget -c https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_${ver}_all.deb
sudo dpkg -i kxstudio*.deb
rm kxstudio-repos_${ver}_all.deb
sudo apt update
sudo apt install -y vitalium zynaddsubfx zynaddsubfx-dssi zynaddsubfx-lv2 zynaddsubfx-vst wah-plugins swh-lv2 swankyamp swankyamp-lv2 swankyamp-vst sorcer yoshimi carla carla-lv2 helm airwindows cardinal cardinal-lv2 cardinal-vst2 cardinal-vst3 phasex lmms petri-foo adlplug ams amsynth ardour drumkv1-lv2 fomp hydrogen padthv1-lv2 zam-plugins wolf-spectrum wolf-shaper teragonaudio-plugins temper shiro-plugins tal-plugins pizmidi-plugins pitcheddelay oxefmsynth obxd mda-lv2 luftikus lsp-plugins-vst lufsmeter linuxsampler-vst juced-plugins klangfalter juce-opl jackass hybridreverb2 easyssp drumgizmo drowaudio-plugins dpf-plugins distrho-plugin-ports dexed arctican-plugins vocproc tap-lv2 synthv1-lv2 zlfo so-synth-lv2 sherlock.lv2 samplv1-lv2 rubberband-lv2 noise-repellent moony.lv2 mod-pitchshifter mod-distortion melmatcheq.lv2 lv2vocoder kxstudio-recommended-audio-plugins-lv2 infamous-plugins gxvoxtonebender gxplugins gxplugins-data guitarix-lv2 guitarix-ladspa geonkick eq10q drmr caps-lv2 calf-plugins bshapr bsequencer blop-lv2 bjumblr beatslash-lv2 avldrums.lv2 abgate fabla wolpertinger
cd
git clone https://github.com/zynthian/zynthian-plugins.git
cd zynthian-plugins
sudo mv * /usr/local/lib
cd
rm -rf zynthian-plugins
ver=1.2.10
cd
wget -c https://sourceforge.net/projects/lsp-plugins/files/lsp-plugins/$ver/Linux-armv7a/lsp-plugins-vst2-$ver-Linux-arm32.tar.gz
tar -xzvf lsp-plugins-vst*.tar.gz
cd lsp-plugins-vst2-$ver-Linux-arm32/
sudo cp -r usr/* /usr
cd
wget -c https://sourceforge.net/projects/lsp-plugins/files/lsp-plugins/$ver/Linux-armv7a/lsp-plugins-lv2-$ver-Linux-arm32.tar.gz
tar -xzvf lsp-plugins-lv2*.tar.gz
cd lsp-plugins-lv2-$ver-Linux-arm32/
sudo cp -r usr/* /usr
cd
wget -c https://sourceforge.net/projects/lsp-plugins/files/lsp-plugins/$ver/Linux-armv7a/lsp-plugins-jack-$ver-Linux-arm32.tar.gz
tar -xzvf lsp-plugins-jack*.tar.gz
cd lsp-plugins-jack-$ver-Linux-arm32/
sudo cp -r usr/* /usr
cd
wget -c https://sourceforge.net/projects/lsp-plugins/files/lsp-plugins/$ver/Linux-armv7a/lsp-plugins-ladspa-$ver-Linux-arm32.tar.gz
tar -xzvf lsp-plugins-ladspa*.tar.gz
cd lsp-plugins-ladspa-$ver-Linux-arm32/
sudo cp -r usr/* /usr
cd
wget -c https://sourceforge.net/projects/lsp-plugins/files/lsp-plugins/$ver/Linux-armv7a/lsp-plugins-clap-$ver-Linux-arm32.tar.gz
tar -xzvf lsp-plugins-clap*.tar.gz
cd lsp-plugins-clap-$ver-Linux-arm32/
sudo cp -r usr/* /usr
cd
rm -rf lsp*
ver=0.6.5
cd
wget -c http://x42-plugins.com/x42/linux/x42-compressor-v$ver-armhf.tar.gz
tar -xzvf x42*.tar.gz
cd x42-compressor
./install-lv2.sh
rm -rf ../x42*
cd
ver=3.27.4
sudo apt update
sudo apt install -y libssl-dev
wget -c https://github.com/Kitware/CMake/releases/download/v$ver/cmake-$ver.tar.gz
tar -xf cmake*.tar.gz
cd cmake*/
./bootstrap
gmake
sudo make install
rm -rf $HOME/cmake*/
rm $HOME/cmake*.gz
cd
sudo apt update
sudo apt-get install -y git build-essential libgtk-3-dev libwebkit2gtk-4.0 libwebkit2gtk-4.0-dev libcurl4-openssl-dev alsa-tools libasound2-dev libjack-dev libfreetype6-dev libxinerama-dev libxcb-xinerama0 libxinerama1 x11proto-xinerama-dev libxrandr-dev libgl1-mesa-dev libxcursor-dev libxcursor1 libxcb-cursor-dev libxcb-cursor0
git clone https://github.com/surge-synthesizer/stochas.git
cd stochas/
git submodule update --depth 1 --init --recursive
export SVER=`cat VERSION`
export GH=`git log -1 --format=%h`
echo "Version ${SVER} hash ${GH}"
cmake -Bbuild -DSTOCHAS_VERSION=${SVER}
cmake --build build --config Release
cp -rf $HOME/stochas/build/stochas_artefacts/VST3/Stochas.vst3 $HOME/.vst3
rm -rf $HOME/stochas
cd
sudo apt install -y libjack-dev
sudo apt install -y libgl1-mesa-dev libx11-dev libsndfile1-dev libsamplerate0-dev
git clone --recursive https://github.com/rghvdberg/ninjas2.git
cd ninjas2
make all CXXFLAGS='-mtune=native' CFLAGS='-mtune=native' CPPFLAGS='-mtune=native'
sudo make install
rm -rf ../ninjas2
cd
ver=1.2.4.3
wget -c https://github.com/cfillion/reapack/releases/download/v$ver/reaper_reapack-armv7l.so
mv reaper_reapack*.so $HOME/.config/REAPER/UserPlugins/
cd $HOME/.config/REAPER/
wget -c https://sws-extension.org/download/featured/sws-2.12.1.3-Linux-armv7l.tar.xz
tar -Jxvf sws*.tar.xz
rm sws*
cd
wget -c https://archive.org/download/Samplicity/Samplicity_M7_Main-02-Wave32bit-48Khz_v1.1.zip
unzip Sampli*.zip
rm Sampli*.zip
mv Samplicity_M7_Main-02-Wave32bit-48Khz_v1.1 Music/
ver=1.2.30
cd
wget -c https://futurenoize.com/dsp56300/builds/master/DSP56300Emu-$ver-Linux_aarch64-Osirus-VST2.deb
wget -c https://futurenoize.com/dsp56300/builds/master/DSP56300Emu-$ver-Linux_aarch64-OsirusFX-VST2.deb
sudo dpkg -i DSP56300Emu*VST2.deb
sudo dpkg -i DSP56300Emu*FX-VST2.deb
cd
wget -c https://archive.org/download/access-virus-b-c-roms/Access%20Virus%20B%20%28am29f040b_4v9%29.zip/Access%20Virus%20B%20%28am29f040b_4v9%29.BIN
sudo cp Access\ Virus\ B\ \(am29f040b_4v9\).BIN /usr/local/lib/vst/
curl https://blokas.io/apt-setup.sh | sh
sudo apt update
sudo apt install pisound-ctl modep-ctl-scripts modep-btn-scripts modep-touchos2midi modep -y
sudo apt install puredata mec orac -y
echo "End of Script, reboot then continue setting up from Reaper DAW GUI"
