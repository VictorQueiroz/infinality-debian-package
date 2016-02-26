#!/bin/bash

pkgver=2.6.2
patchrel=2015.12.05
folder=$PWD/../fontconfig-ultimate/freetype
patches_dir="${folder}"
ext_folder=freetype-${pkgver}

download () {
  if ! [[ -e $ext_folder.tar.bz2 ]]; then
    wget http://downloads.sourceforge.net/sourceforge/freetype/freetype-${pkgver}.tar.bz2
  fi
}

patch_freetype () {
  # patching
  patches=("01-freetype-${pkgver}-enable-valid.patch"
           "02-upstream-${patchrel}.patch"
           "03-infinality-${pkgver}-${patchrel}.patch")

  for patch in "${patches[@]}"; do
    patch -Np1 -i ${patches_dir}/"${patch}"
  done
}

download

if ! [[ -d build ]]; then
  mkdir build
fi
cd build

if ! [[ -d $ext_folder ]]; then
  tar jxvf ../$ext_folder.tar.bz2
fi

# copy necessary files
cp -v $folder/infinality-settings.sh $ext_folder/infinality-settings.sh
chmod +x $ext_folder/infinality-settings.sh

cp -v $folder/generic_settings/infinality-settings.sh $ext_folder/freetype-infinality.sh
chmod +x $ext_folder/freetype-infinality.sh

if [[ -d $ext_folder/debian ]]; then
  rm -rv $ext_folder/debian
fi
cp -rv ../debian $ext_folder/debian

cd $ext_folder

#patch
patch_freetype

debuild -us -uc -b
cp ../*.deb ../..