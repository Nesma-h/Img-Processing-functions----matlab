clc;
clear;

% =====================
% ????? ?? ?????? ????? ?????? (inputImage)
% ?? GUI ????? inputImage = imread(... ?? ?????? ????????)
% =====================
inputImage = imread('image.jpg');  % ???? ????? ??? ???? ?? GUI

if size(inputImage,3) == 3
    inputImage = rgb2gray(inputImage);
end

inputImage = imresize(inputImage, [32 32]);
img = double(inputImage);  % ?????? ???????? ???? ????? ????? ??????

[M, N] = size(img);

% =====================
% ???? DFT
% =====================
F = zeros(M, N);

for u = 1:M
    for v = 1:N
        sumVal = 0;
        for x = 1:M
            for y = 1:N
                angle = -2*pi * ( ((u-1)*(x-1)/M) + ((v-1)*(y-1)/N) );
                sumVal = sumVal + img(x,y) * exp(1i * angle);
            end
        end
        F(u,v) = sumVal;
    end
end

% =====================
% ???? Inverse DFT
% =====================
img_back = zeros(M, N);

for x = 1:M
    for y = 1:N
        sumVal = 0;
        for u = 1:M
            for v = 1:N
                angle = 2*pi * ( ((u-1)*(x-1)/M) + ((v-1)*(y-1)/N) );
                sumVal = sumVal + F(u,v) * exp(1i * angle);
            end
        end
        img_back(x,y) = real(sumVal) / (M*N);
    end
end

% =====================
% ?????? img_back ???? ??? GUI
% =====================
% ????:
% axes(handles.axes1); imshow(img_back, []);
