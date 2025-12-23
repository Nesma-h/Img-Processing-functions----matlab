function out = Exponential_noise(img, lambda)

    img = double(img);

    % Detect if Gray or RGB
    if ndims(img) == 2       % Gray Image
        [r, c] = size(img);
        noise = - (1/lambda) * log(1 - rand(r, c));
        out = img + noise;

    elseif ndims(img) == 3   % RGB Image
        out = zeros(size(img));
        for ch = 1:3
            [r, c] = size(img(:,:,ch));
            noise = - (1/lambda) * log(1 - rand(r, c));
            out(:,:,ch) = img(:,:,ch) + noise;
        end
    else
        error("Unsupported image type.");
    end

    % Clip
    out = uint8( max(0, min(255, out)) );
end
