function [x] = cramer(A,Y)

    [mA,nA] = size(A);
    [mY,nY] = size(Y);
    if(mA ~= nA)
        disp(' matrix A is not suitable');
    end
    if(nY > 1)
        disp('dimension of Y vector is not correct')
    end
    if(mA ~= mY)
        disp('the dimensions does not match')
    end
    
    x = zeros(mA,1);
    detA = det(A);
    for i = 1:mA
       C = A;
       C(:,i) = Y;
       x(i) = det(C)/detA;
    end
end