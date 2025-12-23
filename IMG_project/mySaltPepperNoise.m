function out = mySaltPepperNoise(img)
% Add Salt & Pepper Noise (from scratch)
% img : input image (gray or RGB)

    img = double(img);
    out = img;

    density = 0.05;   % 5% noisy pixels

    if ndims(img) == 2
        % -------- Gray Image --------
        [r, c] = size(img);
        totalPixels = r * c;
        noisyPixels = round(density * totalPixels);

        for k = 1:noisyPixels
            i = randi(r);
            j = randi(c);

            if rand < 0.5
                out(i,j) = 0;      % Pepper
            else
                out(i,j) = 255;    % Salt
            end
        end

    else
        % -------- RGB Image --------
        [r, c, ch] = size(img);
        totalPixels = r * c;
        noisyPixels = round(density * totalPixels);

        for k = 1:noisyPixels
            i = randi(r);
            j = randi(c);

            if rand < 0.5
                out(i,j,:) = 0;
            else
                out(i,j,:) = 255;
            end
        end
    end

    out = uint8(out);
end