function goosale = ch4_int_simp38(f, a, b, h, mantissa)

old = digits;
digits(mantissa);

n = round(((b-a)/h) + 1);

F = @(t, x) eval(strrep(t, 'ln', 'log'));

simpson_result = 0;

t = a:h:b+h;
for i=1:n
    if i == 1 || i == n
        simpson_result = simpson_result + (((3.*h)./8)*(F(f,t(i))))
    elseif rem((i-1),3) == 0
        simpson_result = simpson_result + (((3.*h)./8).*(2.*(F(f,t(i)))))
    else
        simpson_result = simpson_result + (((3.*h)./8).*(3.*(F(f,t(i)))))
    end
end

goosale = simpson_result;

digits(mantissa);

end