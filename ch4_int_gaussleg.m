function goosale = ch4_int_gaussleg(f, a, b, h, mantissa)

old = digits;
digits(mantissa);
F = @(t, x) eval(strrep(t, 'ln', 'log'));

n = round(((b-a)/h) + 1);

[xs, w] = ch4_lgwt(n, a, b);

fu = zeros(n);

for i= 1:n
    fu(i) = F(f, xs(i))
end

goosale = sum(fu.*w)(1);

digits(old);

end