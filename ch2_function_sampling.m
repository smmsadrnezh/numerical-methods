function [X_out, Y] = ch2_function_sampling(equation, X, mantissa, numofpoints)

old = digits;
digits(mantissa);

sample = @(X, equation) double(subs(equation, X));
X_out = X;
Y = double(sample(X, equation))
digits = old;

if nargin > 3
    X_out = linspace(min(X), max(X), numofpoints);
    Y = double(sample(X_out, equation));
end

end