function [  ] = threshQ( im_name, num_thresh )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
image = imread(im_name);
thresh =  multithresh(image, num_thresh);
seg_I = imquantize(image, thresh);

RGB = label2rgb(seg_I);

end

