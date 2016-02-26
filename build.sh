#!/bin/bash

delete_build () {
  # delete old build folder
  if [[ -d build ]]; then
    rm -rf build/
  fi
}

cd freetype-infinality/

delete_build
./build.sh
sudo dpkg -i *.deb

cd ../fontconfig-infinality

delete_build
./build.sh
sudo dpkg -i *.deb