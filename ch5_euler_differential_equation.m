function [ finalY, finalZ, Y, Z ] = ch5_euler_differential_equation( f, g, x0, y0, z0, h, n)
    f = sym(f); 
    g = sym(g);
    h =  h / n;
    X = x0 + [0:n] * h;
    Y = zeros(size(X));
    Y(1) = y0;
    Z = zeros(size(X)); 
    Z(1) = z0;
    
    for i = 1:n
        [ Y(i+1), Z(i+1)]  = ch5_euler_differential_equation_one_step(f,g, X(i),Y(i), Z(i), h);
    end
    finalY = Y(n+1);
    finalZ = Z(n+1);
end

function [ Y, Z ] = ch5_euler_differential_equation_one_step( f, g, x0, y0, z0, h)
    Y = y0 + ch5_subs(f, x0, y0, z0) * h; 
    Z = z0 + ch5_subs(g, x0, y0, z0) * h;
end

function [ V ] = ch5_subs(f, x, y, z)
    V = subs(f, {'x', 'y', 'z'} , {x, y, z});
end
