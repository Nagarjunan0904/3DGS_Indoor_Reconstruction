#!/bin/bash
colmap feature_extractor \
    --database_path ~/gaussian_project/processed/colmap.db \
    --image_path ~/gaussian_project/input/ \
    --ImageReader.single_camera 1 \
    --FeatureExtraction.use_gpu 1 \
    --FeatureExtraction.num_threads 4 \
    --FeatureExtraction.max_image_size 1600 \
    --SiftExtraction.max_num_features 4096