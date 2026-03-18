#!/bin/bash
colmap sequential_matcher \
    --database_path ~/gaussian_project/processed/colmap.db \
    --SequentialMatching.overlap 20 \
    --SequentialMatching.quadratic_overlap 1 \
    --SequentialMatching.loop_detection 1 \
    --SequentialMatching.loop_detection_period 10 \
    --SequentialMatching.loop_detection_num_images 50 \
    --FeatureMatching.use_gpu 1 \
    --FeatureMatching.max_num_matches 16384