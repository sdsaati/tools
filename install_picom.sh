#!/bin/bash
# this script will install all dependancies and picom itself
# after this, you can find picom at /usr/local/bin/picom

sudo apt install -y libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson

sudo apt install -y cmake

sudo apt install -y libpcre2\*


sudo apt install -y libxcb-xinerama0-dev

cd ./picom

meson setup --buildtype=release . build

ninja -C build

sudo ninja -C build install
