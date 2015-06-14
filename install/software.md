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

Don't install using apt-get.  Instead, get the latest from NVIDIA.

```
# Alternatively, search for [nvidia cuda] and download the right one.
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1410/x86_64/cuda-repo-ubuntu1410_7.0-28_amd64.deb
thunar cuda-repo-ubuntu1410_7.0-28_amd64.deb
sudo apt-get update
sudo apt-get install cuda

# Add their binaries to our path.
echo "export PATH=\$PATH:/usr/local/cuda-7.0/bin/" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/usr/local/cuda-7.0/targets/x86_64-linux/lib/" >> ~/.bashrc
source ~/.bashrc

# A reboot is now required.
sudo shutdown -r now

# Now, we can install cuda + torch.
luarocks install cutorch
```

NVIDIA kernel module version:

```
cat /proc/driver/nvidia/version 
```

Cuda version:

```
nvcc --version
```

Neat info:

```
nvidia-smi
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

#### 7. NVIDIA cuDNN

Go to https://developer.nvidia.com/cuDNN and click Download.  Registration is required.  Authorization takes about a day.  Once you have that file:

```
tar -xzvf cudnn-6.5-linux-x64-v2.tar.gz
cd cudnn-6.5-linux-x64-v2
sudo cp -a lib* /usr/local/cuda/lib64/
sudo cp -a cudnn.h /usr/local/cuda/include/
```

Now, install cuDNN with luarocks.

```
sudo luarocks install cudnn
```

#### 8. caffe

(from http://caffe.berkeleyvision.org/install_apt.html, http://caffe.berkeleyvision.org/installation.html)

```
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev \
    libopencv-dev libboost-all-dev libhdf5-serial-dev

sudo apt-get install libatlas-base-dev

sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev \
    protobuf-compiler

sudo apt-get install libboost-python-dev
```

Either download a release or clone from the repo.

As root:

```
cd
git clone https://github.com/BVLC/caffe
cd caffe
```

Create Makefile.config.

```
cp Makefile.config.example Makefile.config
```

Uncomment USE_CUDNN := 1 in Makefile.config.

Python installation.

```
cd python/
pip install -r requirements.txt
```

Add a line to your ~/.bashrc:

```
echo "export PYTHONPATH=/root/caffe/python:\$PYTHONPATH" >> ~/.bashrc
```

Make a fix specific to Ubuntu 15.04 (from https://groups.google.com/d/msg/caffe-users/cdyqjNpoFRY/yBI50gbfqR0J, https://ouxinyu.github.io/Blogs/20140723001.html):

```
ln /usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5* /usr/lib/x86_64-linux-gnu/
```

Modify the Makefile to add a line at :348

```
LIBRARY_DIRS += /usr/lib/x86_64-linux-gnu/hdf5/serial  # fix for ubuntu 15.04
```

Modify the Makefile to add a line at :355

```
INCLUDE_DIRS += /usr/include/hdf5/serial/  # fix for ubuntu 15.04
```

Now, we can build.

```
make all -j12
make test -j12
make runtest -j12
make pycaffe -j12
```

TODO: something about

```
make distribute
```
