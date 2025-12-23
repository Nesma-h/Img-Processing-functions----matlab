function out = negative(img)
if islogical(img) % Binary
    out = ~img;
else
    img = double(img);
    out = 255 - img;
    out = uint8(out);
end
end
