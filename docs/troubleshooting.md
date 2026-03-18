# Troubleshooting Guide

## Issue 1: sm_120 CUDA Error
```
RuntimeError: CUDA error: no kernel image available
```
**Fix:** Reinstall PyTorch nightly cu128
```bash
pip uninstall torch torchvision torchaudio -y
pip install --pre torch torchvision torchaudio \
    --index-url https://download.pytorch.org/whl/nightly/cu128
```

## Issue 2: COLMAP Vocab Tree Crash
```
Failed to read faiss index. Legacy flann-based index.
```
**Fix:** Remove --vocab_tree_path flag.
COLMAP 3.12+ auto-downloads FAISS format tree.

## Issue 3: gsplat Killed During Training
```
gsplat: Setting up CUDA... Killed
```
**Fix:** Limit parallel compile jobs
```bash
export MAX_JOBS=2
```

## Issue 4: COLMAP GCC Error on Ubuntu 22.04
```
#error -- unsupported GNU version
```
**Fix:** Use GCC-10
```bash
sudo apt-get install gcc-10 g++-10
export CC=/usr/bin/gcc-10
export CXX=/usr/bin/g++-10
export CUDAHOSTCXX=/usr/bin/g++-10
```

## Issue 5: Nerfstudio Checkpoint Load Error
```
_pickle.UnpicklingError: Weights only load failed
```
**Fix:** Patch eval_utils.py
```bash
sed -i 's/torch.load(load_path, map_location="cpu")/torch.load(load_path, map_location="cpu", weights_only=False)/g' \
    ~/nerfstudio/nerfstudio/utils/eval_utils.py
```

## Issue 6: Windows Auto-Restart Kills Training
**Fix:** Disable auto-restart in PowerShell (Admin)
```powershell
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoRebootWithLoggedOnUsers /t REG_DWORD /d 1 /f
```

## Issue 7: OpenEXR Not Found in COLMAP cmake
```
Could not find OpenEXR
```
**Fix:**
```bash
cmake .. -DOpenEXR_DIR=/usr/lib/x86_64-linux-gnu/cmake/OpenEXR
```