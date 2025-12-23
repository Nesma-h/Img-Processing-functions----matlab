function out = idealHPF(img, D0)
% idealHPF - Ideal High Pass Filter
img = im2double(img);
[M, N, C] = size(img);

if C == 3
    out = zeros(size(img));
    for c = 1:3
        out(:,:,c) = applyIdealHPF(img(:,:,c), D0, M, N);
    end
else
    out = applyIdealHPF(img, D0, M, N);
end
out = max(0, min(1, out));
% out = mat2gray(out);  % ?? ????? ???? ?????? ????
end

function filtered = applyIdealHPF(channel, D0, M, N)
    F = fftshift(fft2(channel));
    
    % ???????? ???? ????? (????? ?? even ? odd)
    [u, v] = meshgrid(-floor(N/2):floor((N-1)/2), -floor(M/2):floor((M-1)/2));
    D = sqrt(u.^2 + v.^2);
    
    % Ideal High Pass: ???? ???????? ??????? ???
    H = double(D > D0);
    
    G = F .* H;
    
    filtered = real(ifft2(ifftshift(G)));
end