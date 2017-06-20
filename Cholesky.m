function [ res ] = Cholesky( A, B )

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

n = size(A, 1);
if (det(A) == 0)
    disp('the input is not appropriate');
    return;
end

%A o B ro symmetric kardim :D
B = A'*B;
A = A'*A;
x = zeros(n, 1);
L = zeros(n, n);


%satre avale L ro doros kardim
L(1, 1) = sqrt(A(1, 1));
for j = 2:n
    L(1, j) = A(1, j) / L(1, 1);
    L(j, 1) = L(1, j);
end

for i = 2:n
    %in fore payini ghotre asliro doros mikone
    L(i, i) = A(i, i);
    for k = 1:i-1
        L(i, i) = L(i, i) - L(i,k) * L(k,i);
    end
    L(i, i) = sqrt(L(i, i));
    %inja miaim zire ghotre aslio too sootoone i doros mikonim
    for j = i+1:n
        L(i, j) = A(i, j);
        for k = 1:i-1
            L(i, j) = L(i, j) - L(i, k) * L(k, j);
        end
        L(i, j) = L(i, j) / L(i, i);
        L(j, i) = L(i, j);
    end
end


%inja miaim dobare matrico lower triangle mikonim
for i = 1:n
    for j = i+1:n
        L(i, j) = 0;
    end
end
U = L'

%B = LY , inja Y be das oomad
Y = zeros(n , 1);
Y(1) = B(1)/L(1,1);
for i = 2:n
    for j = 1:i-1
       Y(i) = Y(i) + L(i,j)*Y(j) ;
    end
    Y(i) = B(i) - Y(i);
    Y(i) = Y(i)/L(i,i);
end
disp(Y);


X = zeros(n , 1);
X(n) = Y(n)/U(n,n);
for i = n-1:-1:1
    for j = i+1:n
       X(i) = X(i) + U(i,j)*X(j) ;
    end
    X(i) = Y(i) - X(i);
    X(i) = X(i)/U(i,i);
end
%X be dast oomad
res = X;

end