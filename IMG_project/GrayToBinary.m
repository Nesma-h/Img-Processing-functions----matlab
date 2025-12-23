function [ binary] = GrayToBinary( gray,threshold )
    [x y]=size(gray);
    binary=zeros(x,y);
    
    for i=1:x
        for j=1:y
            if(gray(i,j)>threshold)
                binary(i,j)=1;
            else
                binary(i,j)=0;
            end
        end
    end
    
    binary=logical(binary)  ;      


end

