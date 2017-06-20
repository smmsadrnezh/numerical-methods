function [ finalY, Y ] = ch5_modified_euler( f, x0, y0, h, n )
    h =  h / n;
    X = x0 + [0:n] * h;
    Y = zeros(size(X));
    Y(1) = y0;
    
    for i = 1:n
        Y(i+1) = ch5_modified_euler_one_step(f,X(i),Y(i),h);
    end
    finalY = Y(n+1);
end

function [ Y ] = ch5_modified_euler_one_step( f, x0, y0, h )
    y1 = ch5_euler(f,x0,y0,h, 1); 
    dy1 = ch5_f( f, x0 + h, y1) ;
    dy = ch5_f( f, x0, y0);
    Y = y0 + h *(dy + dy1) / 2;
end