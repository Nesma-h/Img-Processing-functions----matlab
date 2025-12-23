function out = pointSharpen(img)

if size(img,3) == 3
    img = rgb2gray(img);
end
img = double(img);

% ---------- Kernel ----------
P = [-1 -1 -1;
     -1  8 -1;
     -1 -1 -1];

[m,n] = size(img);
out = zeros(m,n);

% ---------- Padding (replicate) ----------
A_p = zeros(m+2, n+2);

A_p(2:m+1, 2:n+1) = img;

A_p(1,2:n+1)   = img(1,:);
A_p(m+2,2:n+1) = img(m,:);
A_p(2:m+1,1)   = img(:,1);
A_p(2:m+1,n+2) = img(:,n);

A_p(1,1)       = img(1,1);
A_p(1,n+2)     = img(1,n);
A_p(m+2,1)     = img(m,1);
A_p(m+2,n+2)   = img(m,n);

% ---------- Convolution ???? ----------
for i = 1:m
    for j = 1:n
        s = 0;
        for x = 1:3
            for y = 1:3
                s = s + A_p(i+x-1, j+y-1) * P(x,y);
            end
        end
        out(i,j) = s;
    end
end

out = uint8(out);
end
