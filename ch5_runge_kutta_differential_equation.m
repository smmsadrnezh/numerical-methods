function [ finalY, finalZ, Y, Z ] = ch5_runge_kutta_differential_equation( f, g, x0, y0, z0, h, n)
    h =  h / n;
    X = x0 + [0:n] * h;
    Y = zeros(size(X));
    Y(1) = y0;
    Z = zeros(size(X)); 
    Z(1) = z0;
    
    for i = 1:n
        [ Y(i+1), Z(i+1)]  = ch5_runge_kutta_differential_equation_one_step(f,g, X(i),Y(i), Z(i), h);
    end
    finalY = Y(n+1);
    finalZ = Z(n+1);
end

function [ Y, Z ] = ch5_runge_kutta_differential_equation_one_step( f, g, x0, y0, z0, h)
    kf1 = ch5_subs(f, x0 , y0, z0);
    kg1 = ch5_subs(g, x0 , y0, z0);
    
    kf2 = ch5_subs(f, x0 + h/2 , y0+h*kf1/2, z0+h*kg1/2);
    kg2 = ch5_subs(g, x0 + h/2 , y0+h*kf1/2, z0+h*kg1/2);
    
    kf3 = ch5_subs(f, x0 + h/2 , y0+h*kf2/2, z0+h*kg2/2);
    kg3 = ch5_subs(g, x0 + h/2 , y0+h*kf2/2, z0+h*kg2/2);
    
    kf4 = ch5_subs(f, x0 + h , y0+h*kf3, z0+h*kg3);
    kg4 = ch5_subs(g, x0 + h , y0+h*kf3, z0+h*kg3);
    
    Y = y0 + h*(kf1 + 2* kf2 + 2*kf3 + kf4) /6; 
    Z = z0 + h*(kg1 + 2* kg2 + 2*kg3 + kg4) /6;
end

function [ V ] = ch5_subs(f, x, y, z)
    V = subs(f, {'x', 'y', 'z'} , {x, y, z});
end