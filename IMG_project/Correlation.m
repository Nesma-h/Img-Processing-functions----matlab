function out = Correlation(img, kernel)
    
    img = double(img);       
    [H, W] = size(img);      
    [m, n] = size(kernel);   
        pad_h = floor(m/2);
    pad_w = floor(n/2);
    
    padded = zeros(H + 2*pad_h, W + 2*pad_w);
    padded(pad_h+1:end-pad_h, pad_w+1:end-pad_w) = img;
    
    out = zeros(H, W);
    
    for i = 1:H
        for j = 1:W
            region = padded(i:i+m-1, j:j+n-1);   
            out(i,j) = sum(sum(region .* kernel));  
        end
    end
    
    out(out>255) = 255;
    out(out<0) = 0;
    out = uint8(out);
end
