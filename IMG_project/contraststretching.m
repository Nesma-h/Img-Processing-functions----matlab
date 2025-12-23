function out = contraststretching(img, new_min, new_max)

    if nargin < 3
        new_min = 0;
        new_max = 255;
    end

    img = double(img);

    if ismatrix(img) == 2
        % ===== Gray =====
        old_min = min(img(:));
        old_max = max(img(:));
        out = ((img - old_min) / (old_max - old_min)) * (new_max - new_min) + new_min;

    elseif ndims(img) == 3 && size(img,3) == 3
        % ===== RGB =====
        out = zeros(size(img));
        for c = 1:3
            channel = img(:,:,c);
            old_min = min(channel(:));
            old_max = max(channel(:));
            out(:,:,c) = ((channel - old_min) / (old_max - old_min)) * (new_max - new_min) + new_min;
        end
    else
        error('Unsupported image format');
    end

    out = uint8(out);
end
