#!/bin/bash

pkgver=2.11.94
ext_folder=fontconfig-${pkgver}

if ! [[ -e $ext_folder.tar.bz2 ]]; then
  wget http://www.freedesktop.org/software/fontconfig/release/$ext_folder.tar.bz2
fi

if ! [[ -d build ]]; then
  mkdir build
fi

cd build

if ! [[ -d $ext_folder ]]; then
  tar jxvf ../$ext_folder.tar.bz2
fi

# copy necessary folders
if [[ -d $ext_folder/build ]]; then
  rm -rv $ext_folder/build
fi

cp -rv ../debian/ $ext_folder/
cp -rv ../../fontconfig-ultimate/fontconfig_patches $ext_folder/fontconfig_patches

# patches
patches=$PWD/../../fontconfig-ultimate/fontconfig_patches_git

echo "Copying 'conf.d.infinality' folder"
if [[ -d $ext_folder/conf.d.infinality ]]; then
  rm -r $ext_folder/conf.d.infinality
fi
cp -rv $patches/../conf.d.infinality $ext_folder

# enter the source folder
cd $ext_folder

# patches
echo "Applying debian/patches/*.patch"
for f in $patches/*.patch; do
  patch -Np1 -i $f
done

# do the magic and create the .deb file
debuild -us -uc -b
cp ../*.deb ../..