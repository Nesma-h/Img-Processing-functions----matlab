function out = gaussianLPF(img, D0)
% gaussianLPF - Applies a Gaussian Low-Pass Filter
% Works for Grayscale and RGB images
%
% Syntax: out = gaussianLPF(img, D0)
% img  : Input image (grayscale or RGB)
% D0   : Cutoff frequency (standard deviation)
% out  : Filtered image

% Convert image to double
img = im2double(img);

% Check if RGB or Grayscale
if ndims(img) == 3
    out = zeros(size(img));
    for c = 1:size(img,3)
        out(:,:,c) = applyGLPF(img(:,:,c), D0);
    end
else
    out = applyGLPF(img, D0);
end

end
% -------------------------------
function out = applyGLPF(channel, D0)
% applyGLPF - Applies Gaussian LPF to a single channel

[M,N] = size(channel);

% Fourier Transform
F = fftshift(fft2(channel));

% Frequency Grid
[u,v] = meshgrid(-N/2:N/2-1, -M/2:M/2-1);
D = sqrt(u.^2 + v.^2);

% Gaussian LPF equation
H = exp(-(D.^2)/(2*(D0^2)));

% Apply filter and inverse FFT
out = real(ifft2(ifftshift(F .* H)));

end
