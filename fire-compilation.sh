#!/usr/bin/env bash
set -e
sudo apt update
sudo apt install -y git cmake ninja-build build-essential pkg-config
sudo apt install -y libasound2-dev libjack-jackd2-dev libgtk-3-dev libwebkit2gtk-4.0-dev libx11-dev libxrandr-dev libxinerama-dev libxcursor-dev libfreetype6-dev libgl1-mesa-dev libglu1-mesa-dev lv2-dev
git clone --recursive "https://github.com/jerryuhoo/Fire.git"
cd Fire
cmake -S . -B Builds -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="-O3 -march=armv8.2-a+simd"
cmake -Wno-dev --build Builds -j$(nproc)
sudo mkdir -p /usr/lib/vst3
sudo mkdir -p /usr/lib/clap
sudo cp Builds/Fire_artefacts/Release/CLAP/Fire.clap /usr/lib/clap/
sudo cp -a Builds/Fire_artefacts/Release/VST3/Fire.vst3 /usr/lib/vst3/
cd ..
rm -rf Fire
