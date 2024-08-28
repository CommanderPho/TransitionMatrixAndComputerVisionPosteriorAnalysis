function [BW, maskedImage, blurredImg] = fn_segimg_replay_connect(X, sigma, radius, decomposition)
%segmentImage Segment image using auto-generated code from Image Segmenter app
%  [BW,MASKEDIMAGE] = segmentImage(X) segments image X using auto-generated
%  code from the Image Segmenter app. The final segmentation is returned in
%  BW, and a masked image is returned in MASKEDIMAGE.

% Auto-generated by imageSegmenter app on 21-Aug-2024
%----------------------------------------------------

% Apply Gaussian blur with a specified sigma (standard deviation)
blurredImg = imgaussfilt(X, sigma);

% Adjust data to span data range.
blurredImg = imadjust(blurredImg);

% Auto clustering
s = rng;
rng('default');
L = imsegkmeans(single(blurredImg),2,'NumAttempts',2);
rng(s);
BW = L == 2;

% Ensure high-probability is the forground (== 1), if not invert mask
n_light_elements = sum(BW, 'all');
total_n_elements = prod(size(BW), 'all');

if ((n_light_elements / total_n_elements) > 0.5)
    % if there are more light (forground) elements than dark (background)
    % elements, invert the mask
    BW = imcomplement(BW); % invert the mask
end

% Dilate mask with disk
% radius = 4;
% decomposition = 6;
se = strel('disk', radius, decomposition);
BW = imdilate(BW, se);

% Close mask with disk
% radius = 4;
% decomposition = 6;
se = strel('disk', radius, decomposition);
BW = imclose(BW, se);

% Create masked image.
maskedImage = blurredImg;
maskedImage(~BW) = 0;

end

