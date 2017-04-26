function ch2_draw_polynomial(polynomial_coeff, X, Y)

domain = min(X) : 0.01 : max(X);
plot(domain,polyval(polynomial_coeff,domain),X,Y,'or')
grid

end
