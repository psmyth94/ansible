#!/bin/bash

set -e
sudo yum update -y

sudo yum install -y \
  ninja-build \
  cmake \
  unzip \
  curl \
  git \
  gcc \
  gcc-c++ \
  make \
  tar \
  wget \
  libtool \
  autoconf \
  automake \
  pkgconfig \
  gettext

mkdir -p ~/src
cd ~/src

git clone https://github.com/neovim/neovim.git
cd neovim

git checkout master

make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

echo "Neovim version:"
nvim --version
