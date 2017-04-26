function [ res ] = find_the_roots( equation , x0 , x1 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

ans = [];
bulzano_interval = 1/10;
eps = 1/10000;
x = x0+eps:bulzano_interval:x1;
[row col] = size(x);
counter = 0;
for i = 1:col-1
    f0 = subs(equation, x(i));
    f1 = subs(equation,x(i+1));
    if f0*f1 < 0
        counter = counter + 1;
        ans = [ans;[x(i) x(i+1)]]   
    end
end
res = [[counter 0];ans];   
    


end

