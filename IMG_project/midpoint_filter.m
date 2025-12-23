function out = midpoint_filter(img, k)
    if nargin < 2
        k = 3;
    end
    
    if size(img,3) == 3
        out = zeros(size(img),'uint8');
        for c = 1:3
            minImg = ordfilt2(img(:,:,c),1,ones(k));
            maxImg = ordfilt2(img(:,:,c),k*k,ones(k));
            out(:,:,c) = uint8((double(minImg) + double(maxImg))/2);
        end
    else
        minImg = ordfilt2(img,1,ones(k));
        maxImg = ordfilt2(img,k*k,ones(k));
        out = uint8((double(minImg) + double(maxImg))/2);
    end
end
