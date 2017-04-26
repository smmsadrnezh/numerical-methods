function [ ] = plotTheGraph( equation , points  , a , b)

[row col] =  size(points);
y = zeros(row , col);
x = points;
fplot (equation , [a b] , 'b');
hold on
scatter(x , y , 'r');
[ysize h] = size(y);
[xsize h] = size(x);
scatter(x , y , 'r');
scatter(x(xsize) , y(ysize) , 'b');
hold off
grid on







end

