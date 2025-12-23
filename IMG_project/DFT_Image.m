clc;
clear;

% =========================
% img ???? ???? ????? ??????
% =========================

% ?? ?????? ????? ?????? ?????
if size(img,3) == 3
    img = rgb2gray(img);
end

% ???? ?????? ?????
img = imresize(img, [32 32]);

img = double(img);

[M, N] = size(img);

F = zeros(M, N);

% ===== 2D DFT =====
for u = 1:M
    for v = 1:N
        sumVal = 0;
        for x = 1:M
            for y = 1:N
                angle = -2*pi * ( ...
                    ((u-1)*(x-1)/M) + ((v-1)*(y-1)/N) );
                sumVal = sumVal + img(x,y) * exp(1i * angle);
            end
        end
        F(u,v) = sumVal;
    end
end

% ===== Centering (??? fftshift) =====
F_centered = zeros(M, N);
for u = 1:M
    for v = 1:N
        new_u = mod(u + M/2 - 1, M) + 1;
        new_v = mod(v + N/2 - 1, N) + 1;
        F_centered(new_u, new_v) = F(u,v);
    end
end

% Magnitude Spectrum
Mag = log(1 + abs(F_centered));

imshow(Mag, []);
title('2D DFT (Centered)');
