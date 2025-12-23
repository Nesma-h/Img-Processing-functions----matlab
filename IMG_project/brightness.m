function out = brightness(img, value)
img = double(img);
out = img + value;

out(out > 255) = 255;
out(out < 0)   = 0;

out = uint8(out);
end
