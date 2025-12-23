function out = butterworthHPF(img, D0, n)
% butterworthHPF - Applies a Butterworth High-Pass Filter
% Works for Grayscale and RGB images
%
% Syntax: out = butterworthHPF(img, D0, n)
% img  : Input image (grayscale or RGB)
% D0   : Cutoff frequency
% n    : Filter order
% out  : Filtered image

% Convert image to double
img = im2double(img);

% Check if RGB or Grayscale
if ndims(img) == 3
    out = zeros(size(img));
    for c = 1:size(img,3)
        out(:,:,c) = applyBHPF(img(:,:,c), D0, n);
    end
else
    out = applyBHPF(img, D0, n);
end

end

% -------------------------------
function out = applyBHPF(channel, D0, n)
% applyBHPF - Applies Butterworth HPF to a single channel

[M,N] = size(channel);

% Fourier Transform
F = fftshift(fft2(channel));

% Frequency Grid
[u,v] = meshgrid(-N/2:N/2-1, -M/2:M/2-1);
D = sqrt(u.^2 + v.^2);

% Butterworth HPF equation
H = 1 ./ (1 + (D0./D).^(2*n)); 
H(D==0) = 0; % ???? ?????? ??? ??? ??? ??????

% Apply filter and inverse FFT
out = real(ifft2(ifftshift(F .* H)));

end
