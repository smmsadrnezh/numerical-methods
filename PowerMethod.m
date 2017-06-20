function [ eigenvector, eigenvalue] = PowerMethod( A, X0, step )

for i = 1:step
    Y0 = A*X0;
    m = size(Y0, 1);
    max = Y0(1);
    for j = 2:m
        if abs(Y0(j)) > abs(max)
            max = Y0(j)
        end
    end
    X0 = Y0/max;    
end

eigenvalue = max;
eigenvector = X0;

end