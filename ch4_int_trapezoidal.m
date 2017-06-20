function goosale = ch4_int_trapezoidal(f, a, b, h, mantissa)

old = digits;
digits(mantissa);

n = round(((b-a)/h) + 1);

trapezoidal_result = 0;

F = @(t, x) eval(strrep(t, 'ln', 'log'));

t = a:h:b;
for i=1:n
    if i == 1 || i == n
        trapezoidal_result = trapezoidal_result + ((h./2).*(F(f,t(i))))
    else
        trapezoidal_result = trapezoidal_result + ((h./2).*(2.*(F(f,t(i)))))
    end
end

goosale = trapezoidal_result;

digits(old);

end