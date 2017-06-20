function [ finalY, Y ] = ch5_adams_moulton( f, x0, y0, h, n )
    h =  h / n;
    X = x0 + [0:n] * h;
    Y = zeros(size(X));
    Y(1) = y0;
    
    for i = 1:n
        Y(i+1) = ch5_adams_moulton_one_step(f,X(i),Y(i),h);
    end
    finalY = Y(n+1);
end

function [ Y ] = ch5_adams_moulton_one_step( f, x0, y0, h )
    y1 = ch5_runge_kuttah_4th_order(f, x0, y0, -h, 1); 
    y2 = ch5_runge_kuttah_4th_order(f, x0, y0, -2*h, 1); 
    f0 = ch5_f(f, x0, y0); 
    f1 = ch5_f(f, x0-h, y1); 
    f2 = ch5_f(f, x0-2*h, y2); 
    yi1 = y0 + h * ( 23*f0 - 16 * f1 + 5*f2 ) / 12 ;
    fi1 = ch5_f(f, x0+h, yi1);
    Y = y0 + h*(5*fi1 + 8*f0 - f1)/12;
end