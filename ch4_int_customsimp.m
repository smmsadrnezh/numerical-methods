function goosale = ch4_int_customsimp(f, a, b, h, mantissa)

n = round(((b-a)/h) + 1);

a1 = a;
a2 = a1;
b1 = a2;
b2 = b;

done = false;
while !done 
    a2 = a2+ (3.*h);
    b1 = a2;
    if rem(round(((b2-a2)/h)),2) == 0
        done = true;
    else
        continue;
end

goosale = ch4_int_simp38(f,a1,b1,h, mantissa) + ch4_int_simp13(f,a2,b2,h, mantissa);

end