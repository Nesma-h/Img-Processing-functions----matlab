function out = weight_filter(img)

img = double(img);

kernel = [1 2 1; 
          2 4 2; 
          1 2 1];

[m, n, d] = size(img);
out = zeros(m, n, d);

% ???? ????? ????? ??????? ????
ks = 0;
for a = 1:3
    for b = 1:3
        ks = ks + kernel(a,b);
    end
end

% ?? ?????? RGB
if d == 3
    for c = 1:3
        
        A_p = zeros(m+2, n+2);
        A_p(2:m+1, 2:n+1) = img(:,:,c);
        
        for i = 1:m
            for j = 1:n
                s = 0;
                
                for x = 1:3
                    for y = 1:3
                        s = s + A_p(i+x-1, j+y-1) * kernel(x,y);
                    end
                end
                
                out(i,j,c) = s / ks;
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
            
            for x = 1:3
                for y = 1:3
                    s = s + A_p(i+x-1, j+y-1) * kernel(x,y);
                end
            end
            
            out(i,j) = s / ks;
        end
    end  
end
out = uint8(out);
end