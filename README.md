# infinality-debian-package

Really good looking font for your Debian.

## Pre-Installation

I'm not sure if it's safe or not, but for me, I always move my whole `/etc/fonts` folder to a safe place before execute the script.
```
mv /etc/fonts ~/etc_fonts.backup
```

## Installation
The installation it's pretty simple, since the script will do everything for you.

```bash
# Install the dependencies
sudo apt-get install -y devscripts debhelper

cd fontconfig-infinality/
dpkg-checkbuilddeps
# Install the listed dependencies

cd freetype-infinality/
dpkg-checkbuilddeps
# Install the listed dependencies

git submodule update
./build.sh
```