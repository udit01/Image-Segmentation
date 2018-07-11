function [  ] = threshQ( im_name, num_thresh )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%%
%For grey-scale images

%image = imread(im_name);
%thresh =  multithresh(image, num_thresh);
%seg_I = imquantize(image, thresh);

%RGB = label2rgb(seg_I);
%figure; imshow(RGB); axis off; title('RGB segmented image');
%%
%For RGB
image = imread(im_name);
figure; imshow(image); axis off; title(im_name);


threshRGB =  multithresh(image, num_thresh);
threshPlanes = zeros(3, num_thresh);

for i = 1:3
    threshPlanes(i,:) = multithresh(image(:,:,i), num_thresh) ;
end

value = [0 threshRGB(2:end) 255];
quantRGB = imquantize(image, threshRGB, value);

quantPlane = zeros( size(image) );

for i=1:3
    value = [0 threshPlanes(i, 2:end) 255];
    quantPlane(:, :, i) = imquantize( image(:,:,i), threshPlanes(i, :), value);    
end

quantPlane = uint8(quantPlane);

figure; imshowpair(quantRGB,quantPlane,'montage') ; axis off ;
title('Full RGB Image Quantization    |    Plane-by-Plane Quantization');


end

