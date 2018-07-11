function [  ] = segment( fname )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here


fid = fopen(fname);

% Read all lines & collect in cell array
txt = textscan(fid,'%s','delimiter','\n'); 
% Convert string to numerical value

% Call your function
image_paths = txt{1};
for k  = 1:length(image_paths)
    image_name = image_paths{k};
    disp(image_name);
    [filepath,name,ext] = fileparts(image_name);
    image = imread(image_name);
    [gMask gOver] = greenMask(image);
    imwrite( gMask, strcat(filepath, '/',  name, '_mask_tg',  ext) );
    [wMask wOver] = whiteMask(image);
    imwrite( wMask, strcat(filepath, '/',  name, '_mask_tw',  ext) );
    % Uncomment when you want pink mask as well
    [pMask pOver] = pinkMask(image);
    imwrite( pMask, strcat(filepath, '/',  name, '_mask_tp',  ext) );
end


end

