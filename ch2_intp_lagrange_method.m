function P = ch2_intp_lagrange_method(X,Y, mantissa)

old_digits = digits;
digits(mantissa);

if size(X,1) > 1 || size(Y,1) > 1 || size(X,2) ~= size(Y,2)
  error('dude, both inputs must be equal-length vectors')
end

N = length(X);
pvals = zeros(N,N);

for i = 1:N
  pp = poly(X( (1:N) ~= i));
  pvals(i,:) = pp ./ polyval(pp, X(i));
end

P = Y*pvals;

ch2_draw_polynomial(P, X, Y)

digits(old_digits);
%symbolic form of polynomial
poly2sym(P)

end