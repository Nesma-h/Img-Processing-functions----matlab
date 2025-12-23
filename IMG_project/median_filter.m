function out = median_filter(img, k)
    if nargin < 2
        k = 3;
    end
    
    if size(img,3) == 3
        out = zeros(size(img),'uint8');
        for c = 1:3
            out(:,:,c) = medfilt2(img(:,:,c),[k k]);
        end
    else
        out = medfilt2(img,[k k]);
    end
end
