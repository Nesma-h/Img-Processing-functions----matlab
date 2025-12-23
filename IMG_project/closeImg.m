function [ fimage ] = closeImg(img, s)
    % التأكد إن الصورة رمادي أو binary
    if size(img,3) == 3
        img = rgb2gray(img);
    end

    % تحويل الصورة إلى binary لو مش binary
    if ~islogical(img)
        img = imbinarize(img);
    end

    % تطبيق Dilation
    fimage = dilation(img, s);

    % تطبيق Erosion على النتيجة
    fimage = erosion(fimage, s);

    % دلوقتي fimage جاهزة لأي GUI أو عرض
    % مثال: axes(handles.axes1); imshow(fimage);
end
