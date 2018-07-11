function [  ] = preprocess( fname, numMasks )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
% 
% 
% % % dir_names = [ '2TC', '2TD',  '2TP',  '3T' ] ;
% % % 
% % % %disp(rootdir);
% % % for i = 1:3 
% % % %    cd rootdir;
% % % %    path = strcat( rootdir, dir_names(i) );
% % %     disp(dir_names(i));
% % %     cd dir_names(i);
% % %     
% % %     image_names = dir ( '*.png' ) ;
% % %     for imn = image_names 
% % %         disp(imn);
% % %     end
% % % end
% % % 

fid = fopen(fname);

% Read all lines & collect in cell array
txt = textscan(fid,'%s','delimiter','\n'); 
% Convert string to numerical value

% Call your function
image_paths = txt{1};
for k  = 1:length(image_paths)
    image_name = image_paths{k};
    disp(image_name);
    lab_segment(image_name, numMasks);
end

