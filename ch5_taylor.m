function [ finalY, Y ] = ch5_taylor( f, x0, y0, h, n, tn )
    f = sym(f);
    h =  h / n;
    X = x0 + [0:n] * h;
    Y = zeros(size(X));
    Y(1) = y0;
    
    yf = sym('y');
    df = f;
    for i = 1:tn
        df = diff(df, 'x');
        yf = yf +  df * (h^i) / factorial(i);
    end
    for i = 1:n
        Y(i+1) = ch5_f(yf, X(i), Y(i));
    end
    finalY = Y(n+1);
end