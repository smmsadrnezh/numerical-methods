function [dFBackward, dFCentral, dFForward] = ch2_intp_newton_crbkfw(X, Y, mantissa)

old = digits;
digits(mantissa);
h=X(length(X))-X(length(X)-1);

syms s;
z=sym(zeros(length(X)-1,1));

n = length(X);

% inserting x into 1st column of DD-table inserting y into 2nd column of DD-table
DD(1:length(X),1) = X;
DD(1:length(Y),2) = Y;
 
% divided difference coefficients
for j = 1:n-1
    for k = 1:n-j % j goes from 1 to n-1
        DD(k,j+2) = (DD(k+1,j+1)-DD(k,j+1));
    end
end

for i=1:length(X)
    ss=1;
    for j=0:i-1
        ss=ss*(s-j);
    end
    z(i,1)=ss;
end

F_forward=Y(1);
for i=1:length(X)-1
    F_forward = F_forward +(z(i,1)/factorial(i))*DD(1,i+2);
end

% =========================== BACKWARD
for i=1:length(X)
    ss=1;
    for j=0:i-1
        ss=ss*(s+j);
    end
    z(i,1)=ss;
end

F_backward=Y(length(X));
for i=1:length(X)-1
    F_backward = F_backward + (z(i,1)/factorial(i))*DD(length(X),i+2);
    if i>1
        F_backward = F_backward + (z(i,1)/factorial(i))*DD(((length(X)-i)+1),i+2);
    end
end

% =========================== CENTRAL
for i=2:length(X)
    ss=1;
    for j= 0:2:i
        ss=ss*(s+j/2);
    end
    if i>2
        for j= 2:2:i-1
            ss=ss*(s-j/2);
        end
    end
    z(i,1)=ss;
end

% ========================== OK FFS

F_central=Y(int64(length(X)/2));
for i=1:length(X)-1
    F_central = F_central + (z(i,1)/factorial(i))*DD(ceil((length(X)-i)/2),i+2);
end

% =========================== mOO

syms x
func_f = matlabFunction(subs(F_forward, ((x-X(1))/h)));
func_b = matlabFunction(subs(F_backward, ((x-X(length(X)))/h)));
func_c = matlabFunction(subs(F_central, ((x-X(ceil(length(X)/2)))/h)));

domain = min(X) : 0.01 : max(X);

Y_f = func_f(domain);
Y_b = func_b(domain);
Y_c = func_c(domain);

plot(domain, Y_f, 'b', domain, Y_b, 'g', domain, Y_c, 'r', X, Y, 'or')
legend('forward', 'backward', 'central', 'points')

digits(old);

end