# Pipeline Overview

## End-to-End Flow
```
📱 Smartphone Video
    OnePlus 11R 5G, 4K 60fps, 10 minutes
         ↓
🎞️ Frame Extraction (ffmpeg)
    - 2fps extraction with blur filter
    - 1,206 frames @ 1920x1080
    - mpdecimate removes duplicates
         ↓
🔍 Feature Detection (COLMAP SIFT)
    - Max 4,096 features per image
    - GPU accelerated (RTX 5070 sm_120)
    - Single camera model (same lens throughout)
         ↓
🔗 Feature Matching (COLMAP Sequential)
    - overlap=20 neighbors per frame
    - Loop detection every 10th frame
    - FAISS vocab tree 256K words
    - Max 16,384 matches per pair
         ↓
📐 Structure-from-Motion (COLMAP Mapper)
    - Incremental reconstruction
    - 1,199 / 1,206 cameras registered (99.4%)
    - 294,245 sparse 3D points
    - Mean reprojection error: 0.567px
         ↓
🗺️ Camera Pose Estimation
    - transforms.json (nerfstudio format)
    - All camera intrinsics + extrinsics saved
    - Downscaled image pyramids generated
         ↓
🌐 Gaussian Splatting (nerfstudio splatfacto)
    - 30,000 training iterations
    - 100,000 random Gaussians for textureless walls
    - Scale regularization prevents artifacts
    - Densification stops at step 25,000
         ↓
💾 Export (splat.ply)
    - 917,370 Gaussians
    - Viewable in superspl.at/editor
    - ~200MB PLY file
```

## Key Files Explained

| File | Purpose |
|------|---------|
| `colmap.db` | SQLite database with all features and matches |
| `cameras.bin` | Camera intrinsic parameters |
| `images.bin` | Camera extrinsic poses (position + rotation) |
| `points3D.bin` | Sparse 3D point cloud |
| `transforms.json` | Nerfstudio camera format |
| `sparse_pc.ply` | Sparse point cloud visualization |
| `splat.ply` | Final Gaussian Splat output |