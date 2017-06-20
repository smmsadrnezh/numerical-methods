function [ F ] = ch5_f( f, x0, y0 )
    F = subs( f, {'x','y'} , {x0 , y0} ) ;
end