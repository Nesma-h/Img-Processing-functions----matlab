function out = max_filter(img, k)
    if nargin < 2
        k = 3;
    end
    
    if size(img,3) == 3
        out = zeros(size(img),'uint8');
        for c = 1:3
            out(:,:,c) = ordfilt2(img(:,:,c),k*k,ones(k));
        end
    else
        out = ordfilt2(img,k*k,ones(k));
    end
end
