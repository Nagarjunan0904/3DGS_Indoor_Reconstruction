#!/bin/bash
export MAX_JOBS=2
export TORCH_CUDA_ARCH_LIST="8.0;8.6;9.0;12.0"
export CUDA_HOME=/usr/local/cuda-12.8

ns-train splatfacto \
    --data ~/gaussian_project/processed/ \
    --output-dir ~/gaussian_project/output/ \
    --max-num-iterations 30000 \
    --pipeline.model.num-random 100000 \
    --pipeline.model.random-init True \
    --pipeline.model.warmup-length 500 \
    --pipeline.model.densify-grad-thresh 0.0001 \
    --pipeline.model.use-scale-regularization True \
    --pipeline.model.cull-alpha-thresh 0.005 \
    --pipeline.model.stop-split-at 25000 \
    --pipeline.model.sh-degree 3 \
    --pipeline.model.max-gs-num 600000 \
    --viewer.quit-on-train-completion True \
    --pipeline.datamanager.cache-images disk \
    nerfstudio-data \
    --downscale-factor 2