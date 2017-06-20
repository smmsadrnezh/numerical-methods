function ch2_draw_polynomial(polynomial_coeff, X, Y)

domain = min(X) : 0.01 : max(X);
values = polyval(polynomial_coeff,domain);
plot(domain,values,X,Y,'or')
grid

end
