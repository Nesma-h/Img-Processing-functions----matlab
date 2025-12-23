function out = line_detection(img,type)

img = double(img);

if ndims(img) == 3
    img = rgb2gray(uint8(img));
    img = double(img);
end

switch type
    case 'H'
        k = [-1 -1 -1; 2 2 2; -1 -1 -1];
    case 'V'
        k = [-1 2 -1; -1 2 -1; -1 2 -1];
    case 'DL'
        k = [-1 -1 2; -1 2 -1; 2 -1 -1];
    case 'DR'
        k = [2 -1 -1; -1 2 -1; -1 -1 2];
end

[m,n] = size(img);
out = zeros(m,n);

A_p = zeros(m+2,n+2);
A_p(2:m+1,2:n+1) = img;

for i = 1:m
    for j = 1:n
        s = 0;
        for x = 1:3
            for y = 1:3
                s = s + A_p(i+x-1,j+y-1) * k(x,y);
            end
        end
        out(i,j) = s;
    end
end

out = uint8(out);
end