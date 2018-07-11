# Problem Statement

I have this kinds of images:


Key Point: I have texture-less, mostly monochromatic T-shirts, which is of great importance in using color based segmentation & thresholding.

Dataset comprises of 350[2-3 Tshirts] + 2000[5-6Tshirts]
D1 + D2

For each image, I would like to generate N masks, one each for every T shirt, and 1 for BG. 

I will choose a HSV thresholds of max and min therefore 6 values for each mask(each T shirt color)  to be generated.

But before all this, I came across Otsu's method and Image quantization , so should check that too.

# Approaches

I have tried different algorithms and this is my survey repository, to store the results I was getting and finally getting the required output.

# Current Directory structure [excluding files]

```
.
├── 2TC         # 2 T-shirt images
├── 2TD         # 2 T-shirt images 
├── 2TP         # 2 T-shirt
├── 3T          # 3 T-shirt images
├── capture     # 6 T-shirt images [Noisy]
└── samples     # Samples from the above folders
```

# Splitting image into masks using L * A * B color space
It works best in case of clean and distinct color distributions.

On Matlab  command prompt:
```
% Image Path is the path to your image, Num Regions is the number of regions you need to split in
> lab_segment( <image_path> , <num_regions>)

```

# Hurdles
1. How to evaluate accuracy/ generalizability of this method ?
2. This data will actually go into a segmentation neural network to train, then why am I using Neural net again ?
[Because I'm hoping that with batch normalization, the neural network will generalize enough to overcome the color specificness and heruristics ? ]
