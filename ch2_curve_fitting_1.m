function [a, b, error] = ch2_curve_fitting_1(X, Y, mantissa, point_to_see, draw)

get_a_0 = @(x, y) ((sum(y) .* sum((x.^2))) - (sum(x) .* sum((x.*y)) ))./((length(x).*sum((x.^2))) - (sum(x).^2));
get_a_1 = @(x, y) (length(x).*sum((x.*y)) - (sum(x).*sum(y)))./((length(x).*sum((x.^2))) - (sum(x).^2));
func_Y = @(y) log(y);
func_curve = @(x, a, b) (a).*(exp(b.*x));

old = digits;
digits(mantissa);

a = exp(get_a_0(X, func_Y(Y)));
b = get_a_1(X, func_Y(Y));
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