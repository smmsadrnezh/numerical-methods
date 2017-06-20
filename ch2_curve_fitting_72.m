function [a, b, error] = ch2_curve_fitting_72(X, Y, mantissa, point_to_see, draw)

get_a_0 = @(x, y) ((sum(y) .* sum((x.^2))) - (sum(x) .* sum((x.*y)) ))./((length(x).*sum((x.^2))) - (sum(x).^2));
get_a_1 = @(x, y) (length(x).*sum((x.*y)) - (sum(x).*sum(y)))./((length(x).*sum((x.^2))) - (sum(x).^2));
func_X = @(x) x.*cos(x);
func_curve = @(x, a, b) a*func_X(x) + b;

old = digits;
digits(mantissa);

b = get_a_0(func_X(X), Y);
a = get_a_1(func_X(X), Y);
error = ch2_calculate_rmse(Y, func_curve(X, a, b));

if nargin > 3
    disp( sprintf( 'The value of the polynomial at %d is:', point_to_see) )
    disp(func_curve(point_to_see, a, b))
end

if nargin > 4
    Calc_X = [min(X):0.1:max(X)];
    Calc_Y = func_curve(Calc_X, a, b);
    plot(Calc_X, Calc_Y,'b',X,Y,'or')
end

digits(old);

end
