#!/bin/bash
TIMESTAMP=$(ls -t ~/gaussian_project/output/processed/splatfacto/ | head -1)
ns-export gaussian-splat \
    --load-config ~/gaussian_project/output/processed/splatfacto/${TIMESTAMP}/config.yml \
    --output-dir ~/gaussian_project/exports/splat_final/
echo "Exported to: ~/gaussian_project/exports/splat_final/splat.ply"