function [ gray ] = rgbtogray( rgb , opt )
[x y z]= size(rgb);
gray=zeros(x,y);
gray=double(gray);
for i=1:x
    for j=1:y
        if opt==1
        gray(i,j)=(rgb(i,j,1)+rgb(i,j,2)+rgb(i,j,3))/3;
        end
        
        if opt==2
             gray(i,j)=(rgb(i,j,1)*0.7+rgb(i,j,2)*0.2+rgb(i,j,3))*0.3;
        end
        if opt==3
            gray(i,j)=rgb(i,j,1);
        end
        
        if opt==4
            gray(i,j)=rgb(i,j,2);
        end
        
        if opt==5
            gray(i,j)=rgb(i,j,3);
        end
            
            
            
    end
end
gray=uint8(gray);

        
         


end

