#!/bin/bash

wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh -O $HOME/opt/conda.sh

cd $HOME/opt

bash conda.sh -b -p $HOME/opt/conda

