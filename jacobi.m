function [ res ] = jacobi( A , B , init , n )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[m , n1] = size(A);
[mY,nY] = size(B);
if(m ~= n1)
    disp(' matrix A is not suitable');
end
if(nY > 1)
    disp('dimension of Y vector is not correct')
end
if(m ~= mY)
    disp('the dimensions does not match')
end


sizeB = size(B);
sizeB = sizeB(1);

for i = 1:n
   X = zeros(1 , sizeB); 
   for  j = 1:sizeB
       sum = 0;
       for k = 1:sizeB
           if k ~= j
              sum = sum - A(j , k)*init(k);  
           end
       X(j) = (1/A(j,j))*(B(j) - sum);
       end
   end
   init = X; 
   
end

res = X;


end


