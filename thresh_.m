function [  ] = thresh_( image_name , numColors)

%% Check Results Using the Metric Output Argument
%%
% Read image.

% Copyright 2015 The MathWorks, Inc.

I = imread(image_name);
%%
% Find all unique grayscale values in image.
uniqLevels = unique(I(:));  

disp(['Number of unique levels = ' int2str( length(uniqLevels) )]);
%%
% Compute a series of thresholds at monotonically increasing values of |N|.
Nvals = [1 2 4 8];
for i = 1:length(Nvals)
    [thresh, metric] = multithresh(I, Nvals(i) );
    disp(['N = ' int2str(Nvals(i)) '  |  metric = ' num2str(metric)]);
end
%%
% Apply the set of 8 threshold values to obtain a 9-level segmentation
% using |imquantize| .
seg_Neq8 = imquantize(I,thresh);
uniqLevels = unique( seg_Neq8(:) )   
%%
% Threshold the image using |seg_Neq8| as an input to |multithresh|. Set
% |N| equal to 8, which is 1 less than the number of levels in this
% segmented image. |multithresh| returns a |metric| value of 1.
[thresh, metric] = multithresh(seg_Neq8,8)
%%
% Threshold the image again, this time increasing the value of |N| by 1.
% This value now equals the number of levels in the image. Note how the
% input is degenerate because the number of levels in the image is too few
% for the number of requested thresholds. Hence, multithresh returns a
% |metric| value of 0.
%[thresh, metric] = multithresh(seg_Neq8,9)