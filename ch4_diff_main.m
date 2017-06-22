function goosale = ch4_diff_main(f, x, deg, oh, h, mantissa)

old = digits;
digits(mantissa);

F = @(t, x) eval(strrep(t, 'ln', 'log'));

if oh == 2
    if deg == 1
        F(f, x+h)
        goosale = (F(f, x+h) - F(f, x-h))./(2.*h);
    elseif deg == 2
        goosale = (F(f, x+h) - 2.*F(f, x) + F(f, x-h))./(h.^2);
    elseif deg == 3
        goosale = (F(f, x+(2.*h)) - 2.*(F(f, x+h)) + 2.*(F(f, x-h)) - F(f, x-(2.*h)))./(2.*(h.^3));
    elseif deg == 4
        goosale = (F(f, x+(2.*h)) - 4.*(F(f, x+h)) + 6.*(F(f, x)) - 4.*(F(f, x-h)) + F(f, x-(2.*h)))./(h.^4);
    else
    end
elseif oh == 4
    if deg == 1
        goosale = (-F(f, x+(2.*h)) + 8.*(F(f, x+h)) - 8.*(F(f, x-h)) + F(f, x-(2.*h)))./(12.*(h));
    elseif deg == 2
        goosale = (-F(f, x+(2.*h)) + 16.*(F(f, x+h)) - 30.*(F(f, x)) + 16.*(F(f, x-h)) - F(f, x-(2.*h)))./(12.*(h.^2));
    elseif deg == 3
        goosale = (-F(f, x+(3.*h)) + 8.*F(f, x+(2.*h)) - 13.*(F(f, x+h)) + 13.*(F(f, x-h)) - 8.*(F(f, x-(2.*h))) + F(f, x-(3.*h)))./(8.*(h.^3));
    elseif deg == 4
        goosale = (-F(f, x+(3.*h)) + 12.*F(f, x+(2.*h)) - 39.*(F(f, x+h)) + 56.*(F(f, x)) - 39.*(F(f, x-h)) + 12.*F(f, x-(2.*h)) - F(f, x-(3.*h)))./(6.*(h.^4));
    else
    end
end

digits(old);

end