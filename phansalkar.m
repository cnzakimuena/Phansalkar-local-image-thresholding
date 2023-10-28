%PHANSALKAR local thresholding.
%   BW = PHANSALKAR(IMAGE) performs local thresholding of a two-dimensional 
%   array IMAGE with Phansalkar algorithm.
%      
%   BW = PHANSALKAR(IMAGE, [M N], THRESHOLD, PADDING) performs local 
%   thresholding with M-by-N neighbourhood (default is 15-by-15) and 
%   threshold THRESHOLD between 0 and 1. 
%   To deal with border pixels the image is padded with one of 
%   PADARRAY options (default is 'replicate').
%       
%   Example
%   -------
%       imshow(phansalkar(imread('eight.tif'), [150 150]));
%
%   See also PADARRAY, RGB2GRAY.

% Modified from the MATLAB implementation of the Sauvola algorithm which
% can be found here:
%   https://www.mathworks.com/matlabcentral/fileexchange/40266-sauvola-local-image-thresholding
% Contributed by Charles Belanger Nzakimuena (cnzakimuena@gmail.com)
% $Date: 2020/05/25 $

function output=phansalkar(image, varargin)
% Initialization
numvarargs = length(varargin);      % only want 3 optional inputs at most
if numvarargs > 3
    error('myfuns:somefun2Alt:TooManyInputs', ...
     'Possible parameters are: (image, [m n], threshold, padding)');
end
 
optargs = {[15 15] 0.25 'replicate'}; % set defaults
 
optargs(1:numvarargs) = varargin;   % use memorable variable names
[window, k, padding] = optargs{:};

if ndims(image) ~= 2
    error('The input image must be a two-dimensional array.');
end

% Convert to double
image = double(image);

% Mean value
mean = averagefilter(image, window, padding);

% Standard deviation
meanSquare = averagefilter(image.^2, window, padding);
deviation = (meanSquare - mean.^2).^0.5;

% Phansalkar
R = max(deviation(:));
p = 2;
q = 10;
threshold = mean.*(1 + k * ((deviation / R)-1));
% threshold = mean.*(1 + p*exp(-q*mean) + k * ((deviation / R)-1));

output = (image > threshold);
