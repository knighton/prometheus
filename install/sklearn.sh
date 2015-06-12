#!/bin/sh

sudo apt-get install gfortran libopenblas-dev liblapack-dev

sudo apt-get install virtualenv
virtualenv .
. bin/activate

pip install numpy
pip install scipy
pip install scikit-learn
