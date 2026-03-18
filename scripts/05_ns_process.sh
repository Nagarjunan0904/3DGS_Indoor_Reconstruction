#!/bin/bash
ns-process-data images \
    --data ~/gaussian_project/input/ \
    --output-dir ~/gaussian_project/processed/ \
    --skip-colmap \
    --colmap-model-path ~/gaussian_project/processed/sparse/0