#!/bin/sh
#
# run as your user, not root.

# ------------------------------------------------------------------------------
# torch.

sudo apt-get install libssl-dev

sudo curl -sk https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash 2> torch_install_deps.err | tee torch_install_deps.out

git clone https://github.com/torch/distro.git ~/torch --recursive 2> torch_git_clone.err | tee torch_git_clone.out

cd torch; echo yes | ./install.sh 2> ../torch_install.err | tee ../torch_install.out

# ------------------------------------------------------------------------------
# luarocks.

sudo apt-get install luarocks

# these are needed for itorch:
luarocks install lbase64 
luarocks install luacrypto
luarocks install uuid
luarocks install lzmq

# ------------------------------------------------------------------------------
# install cuda.

# alternatively, search for [nvidia cuda] and download the right one.
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1410/x86_64/cuda-repo-ubuntu1410_7.0-28_amd64.deb 
thunar cuda-repo-ubuntu1410_7.0-28_amd64.deb
sudo apt-get update
sudo apt-get install cuda

# a reboot is now required.  i rebooted here.  but maybe you can do the rest of
# this file and then reboot.  (haven't tried that.)

# now, we can install cuda + torch.
luarocks install cutorch

# ------------------------------------------------------------------------------
# char-rnn:

# these are explicitly required in char-rnn's README:
luarocks install nngraph
luarocks install optim

# these are required too but not mentioned:
luarocks install cunn

sudo apt-get install https://github.com/karpathy/char-rnn

sudo shutdown -r now
