#!/bin/bash


if [ -d $HOME/opt/conda ];then exit 0;fi

wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"  -O $HOME/opt/conda.sh

cd $HOME/opt

bash conda.sh -b -p $HOME/opt/conda
rm conda.sh

