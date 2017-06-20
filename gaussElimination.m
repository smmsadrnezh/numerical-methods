function [res] = gaussElimination(A,B)

[m , n] = size(A);
[mY,nY] = size(B);
if(m ~= n)
    disp(' matrix A is not suitable');
end
if(nY > 1)
    disp('dimension of Y vector is not correct')
end
if(m ~= mY)
    disp('the dimensions does not match')
end
C = zeros(m , n+1);
%augmented matrix ro tashkil dadam
for i = 1:n
    C(: , i) = A(: , i);
end
C(: , n+1) = B;

%inja bala mosalasish kardam
for i = 1:n-1
    for j = i+1:m
        C(j , :) = C(j , :) - C(i,:)*C(j,i)/C(i,i);
    end
end


X = zeros(m , 1);
B = C(: , n+1);
for i = 1:n
   A(:,i) = C(: , i); 
end


%inja X ra be das avordam :D
X(m) = B(m)/A(m,m);
for i = m-1:-1:1
    for j = i+1:m
       X(i) = X(i) + A(i,j)*X(j) ;
    end
    X(i) = B(i) - X(i);
    X(i) = X(i)/A(i,i);
end

res = X;
end