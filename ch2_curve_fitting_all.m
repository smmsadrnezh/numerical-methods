function  ch2_curve_fitting_all(X, Y, mantissa)

func_curve_1 = @(x, a, b) (a).*(exp(b.*x));
func_curve_2 = @(x, a, b) (a.*(log(x))) + b;
func_curve_3 = @(x, a, b) ((a)./(x)) + b;
func_curve_4 = @(x, a, b) (1)./((a.*x)+b);

old = digits;
digits(mantissa);

[a_1, b_1, error_1] = ch2_curve_fitting_1(X, Y, mantissa);
le = error_1;
meth = 1;
[a_2, b_2, error_2] = ch2_curve_fitting_2(X, Y, mantissa);
if le > error_2
   le = error_2;
   meth = 2;
end
[a_3, b_3, error_3] = ch2_curve_fitting_3(X, Y, mantissa);
if le > error_3
   le = error_3;
   meth = 3;
end
[a_4, b_4, error_4] = ch2_curve_fitting_4(X, Y, mantissa);
if le > error_4
   le = error_4;
   meth = 4;
end
[polynomial_coeff_5, error_5] = ch2_curve_fitting_5(X, Y, mantissa, 2);
if le > error_5
   le = error_5;
   meth = 5;
end

if meth == 1
    Calc_X = [min(X):0.1:max(X)];
    Calc_Y = func_curve_1(Calc_X, a_1, b_1);
    plot(Calc_X, Calc_Y,'b',X,Y,'or')
elseif meth == 2
    Calc_X = [min(X):0.1:max(X)];
    Calc_Y = func_curve_2(Calc_X, a_2, b_2);
    plot(Calc_X, Calc_Y,'b',X,Y,'or')
elseif meth == 3
    Calc_X = [min(X):0.1:max(X)];
    Calc_Y = func_curve_3(Calc_X, a_3, b_3);
    plot(Calc_X, Calc_Y,'b',X,Y,'or')
elseif meth == 4
    Calc_X = [min(X):0.1:max(X)];
    Calc_Y = func_curve_4(Calc_X, a_4, b_4);
    plot(Calc_X, Calc_Y,'b',X,Y,'or')
elseif meth == 5
    Calc_X = [min(X):0.1:max(X)];
    plot(Calc_X, polyval(polynomial_coeff_5,Calc_X),'b',X,Y,'or')
end

digits(old);

end