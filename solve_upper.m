function [ x ] = solve_upper( a,b )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    n = size(a,1);
    x = zeros(n,1);
    x(n) = b(n)/a(n,n);
    for i=n-1:-1:1
       x(i) = b(i);
       x(i) = x(i) - dot( a(i,i+1:n),x(i+1:n,1));
       x(i) = x(i)/a(i,i);
    end
   
end

