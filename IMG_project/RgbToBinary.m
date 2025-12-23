function [ binary ] = RgbToBinary( rgb ,opt ,threshold )
[x y z]= size(rgb);
binary=zeros(x,y);

for i=1:x
    for j=1:y
        if opt==1
        gray=(rgb(i,j,1)+rgb(i,j,2)+rgb(i,j,3))/3;
        end
        
        if opt==2
             gray=(rgb(i,j,1)*0.7+rgb(i,j,2)*0.2+rgb(i,j,3))*0.3;
        end
        if opt==3
            gray=rgb(i,j,1);
        end
        
        if opt==4
            gray=rgb(i,j,2);
        end
        
        if opt==5
            gray=rgb(i,j,3);
        end
        
        if gray>threshold
            binary(i,j)=1;
        end
        if gray<=threshold
            binary(i,j)=0;
        end    
    end
end

binary=logical(binary);
        

end

