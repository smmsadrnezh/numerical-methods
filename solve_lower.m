function [ x ] = solve_lower( a,b )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    n = size(a,1);
    x = zeros(n,1);
    x(1) = b(1)/a(1,1);
    for i=2:n
       x(i) = b(i);
       x(i) = x(i) - dot ( a(i,1:i-1),x(1:i-1,1));
       x(i) = x(i)/a(i,i);
    end
   
end

