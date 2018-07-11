function [  ] = segmentCapture( fname )
%To generate masks of 'capture' dataset [noisy]
% 
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
    
    [blm blOv] = blMask(image);
    imwrite( blm, strcat(filepath, '/',  name, '_mask_bl',  ext) );
    [dgm dgOv] = dgMask(image);
    imwrite( dgm, strcat(filepath, '/',  name, '_mask_dg',  ext) );
    [dpm dpOv] = dpMask(image);
    imwrite( dpm, strcat(filepath, '/',  name, '_mask_dp',  ext) );
    [pum puOv] = puMask(image);
    imwrite( pum, strcat(filepath, '/',  name, '_mask_pu',  ext) );
    [lbm lbOv] = lbMask(image);
    imwrite( lbm, strcat(filepath, '/',  name, '_mask_lb',  ext) );
    [dbm dbOv] = dbMask(image);
    imwrite( dbm, strcat(filepath, '/',  name, '_mask_db',  ext) );
    
end


end

