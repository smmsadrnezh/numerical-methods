function P = ch2_intp_divided_differences(x,y, mantissa)

old_digits = digits;
digits(mantissa);

n = length(x);
 
if length(x) ~= length(y)
 error('X and Y must have the same dimension')
end
 
% inserting x into 1st column of DD-table inserting y into 2nd column of DD-table
DD(1:length(x),1) = x;
DD(1:length(y),2) = y;
 
% divided difference coefficients
for j = 1:n-1
    for k = 1:n-j % j goes from 1 to n-1
        DD(k,j+2) = (DD(k+1,j+1)-DD(k,j+1))/(DD(k+j,1)-DD(k,1));
    end
end

Prod = zeros(n-1,n);
p = conv(1,[1,-x(1)]); % creates a poly (x-x(1))
 
for i = 1:n-1
    Prod(i,(n-(length(p)-1)):n) = DD(1,i+2)*p;
    DD(1,i+2)*p
    p = conv(p,[1,-x(i+1)]);
end
 
P = sum(Prod,1);
P(1,n)=P(1,n)+y(1);
 
ch2_draw_polynomial(P, x, y)

digits(old_digits);
%polynomial in symbolic form
poly2sym(P)

end