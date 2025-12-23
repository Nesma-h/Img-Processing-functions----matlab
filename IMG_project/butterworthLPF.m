function out = butterworthLPF(img, D0, n)
% Butterworth Low Pass Filter
% Works for Grayscale and RGB images

img = im2double(img);

% Check if RGB or Grayscale
if ndims(img) == 3
    out = zeros(size(img));
    for c = 1:size(img,3)
        out(:,:,c) = applyBLPF(img(:,:,c), D0, n);
    end
else
    out = applyBLPF(img, D0, n);
end
end
% -------------------------------
function out = applyBLPF(channel, D0, n)

[M,N] = size(channel);

% Fourier Transform
F = fftshift(fft2(channel));

% Frequency Grid
[u,v] = meshgrid(-N/2:N/2-1, -M/2:M/2-1);
D = sqrt(u.^2 + v.^2);

% Butterworth LPF equation
H = 1 ./ (1 + (D./D0).^(2*n));

% Apply filter and inverse FFT
out = real(ifft2(ifftshift(F .* H)));
end
