function [ fimage ] = dilation(img, s)
    % التأكد إن الصورة رمادي أو binary
    if size(img,3) == 3
        img = rgb2gray(img);
    end

    % تحويل الصورة إلى binary لو مش binary
    if ~islogical(img)
        img = imbinarize(img);
    end

    [H, W] = size(img);
    [m, n] = size(s);

    fimage = zeros(H, W);
    row = (m-1)/2;
    col = (n-1)/2;

    % عمل padding للصورة
    img2 = zeros(H + row*2, W + col*2);
    img2(row+1:row+H, col+1:col+W) = img;

    % تطبيق عملية dilation
    for i = row+1:H+row
        for j = col+1:W+col
            patch = img2(i-row:i+row, j-col:j+col);  % الجزء المحيط بالنواة
            res2 = patch & s;                       % AND بين الباتش والنواة
            if sum(res2(:)) >= 1
                fimage(i-row, j-col) = 1;
            else
                fimage(i-row, j-col) = 0;
            end
        end
    end
end
