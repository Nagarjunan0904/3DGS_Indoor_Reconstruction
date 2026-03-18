#!/bin/bash
mkdir -p ~/gaussian_project/processed/sparse
colmap mapper \
    --database_path ~/gaussian_project/processed/colmap.db \
    --image_path ~/gaussian_project/input/ \
    --output_path ~/gaussian_project/processed/sparse \
    --Mapper.num_threads 8 \
    --Mapper.init_min_tri_angle 4 \
    --Mapper.multiple_models 0 \
    --Mapper.extract_colors 1