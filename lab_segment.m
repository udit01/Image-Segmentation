function [  ] = lab_segment( image_name , numColors)

%%Color-Based Segmentation Using the L*a*b* Color Space

fabric = imread(image_name);
load regioncoordinates;
nColors = numColors; %Two Tshirts + 1 background

sample_regions = false([size(fabric,1) size(fabric,2) nColors]);

for count = 1:nColors
  sample_regions(:,:,count) = roipoly(fabric, region_coordinates(:,1,count),...
                                      region_coordinates(:,2,count));
                                  
  %figure , imshow(sample_regions(:,:,count)),title('sample region for ...');
end

%imshow(sample_regions(:,:,2)),title('sample region for ...');

lab_fabric = rgb2lab(fabric);


%Calculate the mean 'a*' and 'b*' value for each area that you extracted with roipoly. These values serve as your color markers in 'a*b*' space.
a = lab_fabric(:,:,2);
b = lab_fabric(:,:,3);
color_markers = zeros([nColors, 2]);

for count = 1:nColors
  color_markers(count,1) = mean2(a(sample_regions(:,:,count)));
  color_markers(count,2) = mean2(b(sample_regions(:,:,count)));
end

%fprintf('[%0.3f,%0.3f] \n',color_markers(2,1),color_markers(2,2));

%Each color marker now has an 'a*' and a 'b*' value. You can classify each pixel in the lab_fabric image by calculating the Euclidean distance between that pixel and each color marker. The smallest distance will tell you that the pixel most closely matches that color marker. For example, if the distance between a pixel and the red color marker is the smallest, then the pixel would be labeled as a red pixel.
%Create an array that contains your color labels, i.e., 0 = background, 1 = red, 2 = green, 3 = purple, 4 = magenta, and 5 = yellow.
color_labels = 0:nColors-1;

a = double(a);
b = double(b);
distance = zeros([size(a), nColors]);

for count = 1:nColors
  distance(:,:,count) = ( (a - color_markers(count,1)).^2 + ...
                      (b - color_markers(count,2)).^2 ).^0.5;
end

[~, label] = min(distance,[],3);
label = color_labels(label);
clear distance;

rgb_label = repmat(label,[1 1 3]);



%%%% For original image map , 
% segmented_images = zeros([size(fabric), nColors],'uint8');
% for count = 1:nColors
%   
%   color = fabric;
%   color(rgb_label ~= color_labels(count)) = 0;
%   segmented_images(:,:,:,count) = color;
% end 

%%% For 1 HOT map , we only need a greyscale image
segmented_images = zeros([size(fabric,1), size(fabric,2) , nColors],'uint8');
for count = 1:nColors
  mask = zeros(size(fabric)) ;
  mask(rgb_label ~= color_labels(count)) = 255;
  segmented_images(:,:,count) = mask(:, :, 1) ;
end 


%x = input(prompt);
[filepath,name,ext] = fileparts(image_name);


for count= 1:nColors
    %figure, imshow(segmented_images(:, :, :, count)), title(count);
    imwrite( segmented_images(:, :,  count), strcat(filepath, '/',  name, '_mask', int2str(count), ext) );
end


end

