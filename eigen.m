function [result] = eigen(A)
%calculating Eigen Values and Eigen Vectors of a given matrix
  
    
    
    [m,n] = size(A);
    syms landa;
    B = A - landa*eye(m);
    
    eigenValues = vpa(solve(det(B)));
    eigenVector = [];
    F = eye(length(A));
    for i = 1:length(eigenValues)
        k = eigenValues(i)
        eigenVector = [eigenVector, vpa(null(double(A - k * F)))];
    end
    result = [eigenValues,eigenVector];
end