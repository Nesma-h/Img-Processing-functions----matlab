function out = idealLPF(img, D0)
% idealLPF - Ideal Low Pass Filter in Frequency Domain
%   out = idealLPF(img, D0)
%   img : Input image (grayscale or RGB, uint8 or double)
%   D0  : Cutoff frequency (positive scalar)

img = im2double(img);  % ???? ???? double [0,1]

[M, N, ~] = size(img);

if ndims(img) == 3  % RGB
    out = zeros(size(img));
    for c = 1:3
        out(:,:,c) = applyIdealLPF(img(:,:,c), D0, M, N);
    end
else  % Grayscale
    out = applyIdealLPF(img, D0, M, N);
end

% ????? ?? ?????? ?? ?????? [0,1]
out = max(0, min(1, out));

end

% ==============================================================
function filtered = applyIdealLPF(channel, D0, M, N)
    % Fourier Transform + shift
    F = fftshift(fft2(channel));
    
    % ???????? ?????? ??????? (???? ?? even ? odd dimensions)
    [u, v] = meshgrid(-floor(N/2):floor((N-1)/2), -floor(M/2):floor((M-1)/2));
    D = sqrt(u.^2 + v.^2);
    
    % Ideal Low Pass Filter
    H = double(D <= D0);
    
    % Apply filter
    G = F .* H;
    
    % Inverse FFT
    filtered = real(ifft2(ifftshift(G)));
end
