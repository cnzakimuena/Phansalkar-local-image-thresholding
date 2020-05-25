
function call_phansalkar()

choroidIm = imread('norm.tif');
newIm = im2double(choroidIm);

%% *uncomment below for image resizing option*

% inputIm = imresize(inputIm, [304 304]);
% BW = phansalkar(inputIm, [15 15]); 

%% *automated window size adjustment based on input image size*

windowSize = round(size(newIm ,1)/(304/15));
BW = phansalkar(newIm, [windowSize windowSize]);
BW2 = imcomplement(BW);

figure; imshow([newIm BW2],[])
imwrite(BW2, 'norm_BW_MATLAB.tif')