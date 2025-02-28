#!/usr/bin/nash
mkdir -p ~/bin

sudo apt update
sudo apt install libinput-tools xdotool wmctrl

# i3 lock
sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./build.sh
cp ./i3lock ~/bin/i3lock
sudo ln -s ~/bin/i3lock /usr/bin/i3lock
cd

# libinput-gestures setup
git clone https://github.com/bulletmark/libinput-gestures.git
cd libinput-gestures
sudo make install
sudo gpasswd -a $USER input
libinput-gestures-setup autostart

