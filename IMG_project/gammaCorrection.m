function out = gammaCorrection(img, gamma)

img = double(img) / 255;
out = img .^ gamma;

out = uint8(out * 255);
end
