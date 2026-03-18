# Installation Guide

## Prerequisites
- Windows 11
- WSL2 Ubuntu 22.04
- NVIDIA GPU (sm_70+)
- CUDA 12.8+ Windows driver
- 16GB+ RAM
- 50GB+ free disk

## Step 1 — WSL2 Setup
```bash
# PowerShell as Administrator
wsl --install -d Ubuntu-22.04
wsl --set-default-version 2
```

## Step 2 — CUDA Toolkit in WSL
```bash
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get install -y cuda-toolkit-12-8
echo 'export PATH=/usr/local/cuda-12.8/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.8/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc
```

## Step 3 — Miniconda
```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3
eval "$($HOME/miniconda3/bin/conda shell.bash hook)"
echo 'eval "$($HOME/miniconda3/bin/conda shell.bash hook)"' >> ~/.bashrc
source ~/.bashrc
conda create -n gaussian_env python=3.11 -y
conda activate gaussian_env
```

## Step 4 — PyTorch Nightly (sm_120)
```bash
pip install --pre torch torchvision torchaudio \
    --index-url https://download.pytorch.org/whl/nightly/cu128

# Verify sm_120
python -c "
import torch
caps = torch.cuda.get_arch_list()
print('sm_120 supported:', any('12' in c for c in caps))
"
```

## Step 5 — gsplat from Source
```bash
export TORCH_CUDA_ARCH_LIST="8.0;8.6;9.0;12.0"
export CUDA_HOME=/usr/local/cuda-12.8
pip install ninja numpy jaxtyping rich
cd ~
git clone https://github.com/nerfstudio-project/gsplat.git
cd gsplat
git checkout v1.5.3
git submodule update --init --recursive
pip install . --no-build-isolation
```

## Step 6 — COLMAP from Source
```bash
sudo apt-get install -y gcc-10 g++-10 \
    git ninja-build build-essential \
    libboost-program-options-dev libboost-graph-dev \
    libboost-system-dev libeigen3-dev \
    libfreeimage-dev libmetis-dev \
    libgoogle-glog-dev libsqlite3-dev \
    libglew-dev qtbase5-dev libqt5opengl5-dev \
    libcgal-dev libcurl4-openssl-dev \
    libssl-dev libceres-dev libopencv-dev \
    libopenimageio-dev libopenexr-dev

export CC=/usr/bin/gcc-10
export CXX=/usr/bin/g++-10
export CUDAHOSTCXX=/usr/bin/g++-10

cd ~
git clone https://github.com/colmap/colmap.git
cd colmap && mkdir build && cd build
cmake .. -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CUDA_ARCHITECTURES="80;86;90;120" \
    -DCUDA_ENABLED=ON \
    -DOpenEXR_DIR=/usr/lib/x86_64-linux-gnu/cmake/OpenEXR
ninja -j2
sudo ninja install
```

## Step 7 — Nerfstudio
```bash
conda activate gaussian_env
cd ~
git clone https://github.com/nerfstudio-project/nerfstudio.git
cd nerfstudio
pip install -e ".[dev]"

# Fix PyTorch checkpoint loading (nightly compatibility)
sed -i 's/torch.load(load_path, map_location="cpu")/torch.load(load_path, map_location="cpu", weights_only=False)/g' \
    /home/nagarjunan/nerfstudio/nerfstudio/utils/eval_utils.py
```