Many of these steps depend on previous steps being installed.

#### 1. sklearn

```
sudo apt-get install gfortran libopenblas-dev liblapack-dev
```

This will now work:
```
sudo apt-get install virtualenv
virtualenv .
. bin/activate

pip install numpy
pip install scipy
pip install scikit-learn
```

#### 2. torch

```
sudo apt-get install libssl-dev

sudo curl -sk https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash \
    2> torch_install_deps.err | tee torch_install_deps.out

git clone https://github.com/torch/distro.git ~/torch --recursive \
    2> torch_git_clone.err | tee torch_git_clone.out

cd torch; echo yes | ./install.sh 2> ../torch_install.err | tee ../torch_install.out
```

#### 3. luarocks

```
sudo apt-get install luarocks

# These are needed for itorch.
luarocks install lbase64
luarocks install luacrypto
luarocks install uuid
luarocks install lzmq
```

#### 4. cuda

```
# Alternatively, search for [nvidia cuda] and download the right one.
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1410/x86_64/cuda-repo-ubuntu1410_7.0-28_amd64.deb
thunar cuda-repo-ubuntu1410_7.0-28_amd64.deb
sudo apt-get update
sudo apt-get install cuda

# A reboot is now required.
sudo shutdown -r now

# Now, we can install cuda + torch.
luarocks install cutorch
```

#### 5. char-rnn

```
# These are explicitly required in char-rnn's README.
luarocks install nngraph
luarocks install optim

# This one is assumed.
luarocks install cunn

git clone https://github.com/karpathy/char-rnn
```

#### 6. learning_to_execute

```
git clone https://github.com/wojciechz/learning_to_execute/
```
