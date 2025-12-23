function out = min_filter(img, k)
    if nargin < 2
        k = 3; % default kernel size
    end
    
    if size(img,3) == 3   % RGB
        out = zeros(size(img),'uint8');
        for c = 1:3
            out(:,:,c) = ordfilt2(img(:,:,c),1,ones(k));
        end
    else                  % Gray
        out = ordfilt2(img,1,ones(k));
    end
end
