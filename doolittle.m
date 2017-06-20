function [res] = doolittle(A,B)

%A = LU , inja L o U be das ooamd    
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

for j = 1:m
    L(j, j) = 1;
end  
for j = 1:m
    U(1, j) = A(1, j);
end   
for i = 2:m
    for j = 1:m
        for k = 1:(i - 1)
            sum = 0;
            if(k == 1)
                sum=0;
            else
                for p = 1:(k - 1)
                    sum = sum + L(i, p) * U(p, k);
                end
            end
            L(i, k) = (A(i, k) - sum) / U(k, k);
        end
        for k = i:m
            s = 0;
            for p = 1:i-1
                s = s + L(i, p) * U(p, k);
            end
            U(i, k) = A(i, k) - s;
        end
    end
end
disp(U)
disp(L)
disp(L*U)
%B = LY , inja Y be das oomad
Y = zeros(m , 1);
Y(1) = B(1)/L(1,1);
for i = 2:m
    for j = 1:i-1
       Y(i) = Y(i) + L(i,j)*Y(j) ;
    end
    Y(i) = B(i) - Y(i);
    Y(i) = Y(i)/L(i,i);
end
disp(Y)
% pas alan U o Y o darim pas X injoori be das miad UX = Y

X = zeros(m , 1);
X(m) = Y(m)/U(m,m);
for i = m-1:-1:1
    for j = i+1:m
       X(i) = X(i) + U(i,j)*X(j) ;
    end
    X(i) = Y(i) - X(i);
    X(i) = X(i)/U(i,i);
end
%X be dast oomad
res = X;
end