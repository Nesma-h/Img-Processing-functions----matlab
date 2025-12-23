function [] = Histogram(img)
    if ndims(img) == 3 && size(img,3) == 3
        img = rgb2gray(img); 
    end

    [h, w] = size(img); 
    hist = zeros(256,1);

    for i = 1:h
        for j = 1:w
            val = img(i,j) + 1; 
            hist(val) = hist(val) + 1;
        end
    end

    figure;
    bar(hist,'k'); 
    title('Histogram - Gray Image');
    xlabel('Pixel Value');
    ylabel('Count');
end
