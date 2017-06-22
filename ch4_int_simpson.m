function goosale = ch4_int_simpson(f, a, b, h, mantissa)

n = round(((b-a)/h) + 1);

if rem(n-1,2) == 0
    goosale = ch4_int_simp13(f,a,b,h, mantissa);
elseif rem(n-1, 3) == 0
    goosale = ch4_int_simp38(f,a,b,h, mantissa);
else
    goosale = ch4_int_customsimp(f,a,b,h, mantissa);

end