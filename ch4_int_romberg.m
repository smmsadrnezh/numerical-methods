function goosale = ch4_int_romberg(f, a, b, h, mantissa)

old = digits;
digits(mantissa);

n = round(((b-a)/h) + 1);

F = @(t, x) eval(strrep(t, 'ln', 'log'));

romberg_result = zeros(n,n);

h_r = (b-a)./(2.^(0:n-1));
romberg_result(1,1) = (b - a) * (F(f,a) + F(f,b)) / 2;
halfh = h/2;

for j = 2:n
    subtotal = 0;
    for i = 1:2^(j-2)
        subtotal = subtotal + F(f, a + (2 * i - 1) * h_r(j));
    end
    romberg_result(j,1) = romberg_result(j-1,1) / 2 + h_r(j) * subtotal;
    for k = 2:j
        romberg_result(j,k) = (4^(k-1) * romberg_result(j,k-1) - romberg_result(j-1,k-1)) / (4^(k-1) - 1);
    end
end

romberg_result

goosale = romberg_result(n,n);

digits(old);

end