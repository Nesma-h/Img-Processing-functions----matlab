function out = histequalization(img)

img = double(img);

if ismatrix(img)
    % ================= GRAY =================
    hist = zeros(1,256);

    for i = 1:numel(img)
        hist(img(i)+1) = hist(img(i)+1) + 1;
    end

    cdf = zeros(1,256);
    cdf(1) = hist(1);
    for i = 2:256
        cdf(i) = cdf(i-1) + hist(i);
    end
    cdf = cdf / numel(img);

    out = zeros(size(img));
    for i = 1:numel(img)
        out(i) = round(cdf(img(i)+1) * 255);
    end

else
    % ================= RGB =================
    out = zeros(size(img));

    for c = 1:3
        channel = img(:,:,c);

        hist = zeros(1,256);
        for i = 1:numel(channel)
            hist(channel(i)+1) = hist(channel(i)+1) + 1;
        end

        cdf = zeros(1,256);
        cdf(1) = hist(1);
        for i = 2:256
            cdf(i) = cdf(i-1) + hist(i);
        end
        cdf = cdf / numel(channel);

        eq = zeros(size(channel));
        for i = 1:numel(channel)
            eq(i) = round(cdf(channel(i)+1) * 255);
        end

        out(:,:,c) = eq;
    end
end

out = uint8(out);
end
