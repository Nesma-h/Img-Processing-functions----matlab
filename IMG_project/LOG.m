function out = LOG(img, c)
% LOG - Logarithmic Transformation for contrast enhancement
%   out = LOG(img, c)
%   img : Input image (grayscale or RGB, uint8 or double)
%   c   : Constant multiplier (typically 1 to 50, default suggested 30)
%   out : Enhanced image (uint8)

if nargin < 2
    c = 30;  
end

img = im2double(img);
if ndims(img) == 3
    out = zeros(size(img));
    for ch = 1:3
        channel = img(:,:,ch);
        transformed = c * log(1 + channel);     % log transformation
        out(:,:,ch) = transformed;
    end
else
    out = c * log(1 + img);
end

% Normalization ?????? [0,1] ?? ????? ?? uint8
out = mat2gray(out);        
% out = out - min(out(:));
% out = out / max(out(:));

out = im2uint8(out);

end
