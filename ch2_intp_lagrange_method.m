function P = ch2_intp_lagrange_method(X,Y, mantissa, point_to_see)

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

ch2_draw_polynomial(P, X, Y);
Polynomial_value = polyval(P,point_to_see);
disp( sprintf( 'The value of the polynomial at %d is:', point_to_see) )
disp(Polynomial_value)

digits(old_digits);
%symbolic form of polynomial
poly2sym(P)

end