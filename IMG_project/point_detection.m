function out = point_detection(img)

img = double(img);
if ndims(img) == 3
    img = rgb2gray(uint8(img));
    img = double(img);
end

kernel = [-1 -1 -1; -1 8 -1; -1 -1 -1];
[m,n] = size(img);
out = zeros(m,n);

A_p = zeros(m+2,n+2);
A_p(2:m+1,2:n+1) = img;

for i = 1:m
    for j = 1:n
        s = 0;
        for x = 1:3
            for y = 1:3
                s = s + A_p(i+x-1,j+y-1) * kernel(x,y);
            end
        end
        out(i,j) = s;
    end
end

out = uint8(out);
end