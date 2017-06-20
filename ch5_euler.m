function [ finalY, Y ] = ch5_euler( f, x0, y0, h, n)
    h =  h / n;
    X = x0 + [0:n] * h;
    Y = zeros(size(X));
    Y(1) = y0;
    
    for i = 1:n
        Y(i+1) = ch5_taylor(f,X(i),Y(i),h, 1, 1);
    end
    finalY = Y(n+1);
end