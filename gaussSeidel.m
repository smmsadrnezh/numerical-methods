function [ res ] = gaussSeidel( A , B , init , n )
[m , n1] = size(A);
[mY,nY] = size(B);
[mi,ni] = size(init');
if(m ~= n1)
    disp(' matrix A is not suitable');
end
if(nY > 1)
    disp('dimension of Y vector is not correct')
end
if(m ~= mY)
    disp('the dimensions does not match')
end
if(ni > 1)
    disp('dimension of init vector is not correct')
end
if(m ~= mi)
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
              sum = sum - A(j , k)*init(k) ; 
           end
       end
       X(j) = (1/A(j,j))*(B(j) - sum);
       init(j) = X(j);
   end
   init = X;
end
 
res = X;


end

