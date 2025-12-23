function out = mean_filter(img)

img = double(img);

[m, n, d] = size(img);
out = zeros(m, n, d);
if d == 3
    
    for c = 1:3
        % padding ????
        A_p = zeros(m+2, n+2);
        A_p(2:m+1, 2:n+1) = img(:,:,c);
        
        for i = 1:m
            for j = 1:n
                s = 0;
                
                for x = -1:1
                    for y = -1:1
                        s = s + A_p(i+1+x, j+1+y);
                    end
                end
                
                out(i,j,c) = s / 9;
            end
        end   
    end

% ?? ?????? Gray
else
    
    A_p = zeros(m+2, n+2);
    A_p(2:m+1, 2:n+1) = img;
    
    for i = 1:m
        for j = 1:n
            s = 0;
            
            for x = -1:1
                for y = -1:1
                    s = s + A_p(i+1+x, j+1+y);
                end
            end
            
            out(i,j) = s / 9;
        end
    end
    
end

out = uint8(out);
end