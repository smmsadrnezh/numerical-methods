function res = NewtonRaphson(equation,x0, maxError)
    
    syms x
    a = x0;  
    
    fx0 = double(subs(equation,x0));
    firstder = diff(equation,x);
    secondder = diff(equation, x , 2);
    firstderx0 = double(subs(firstder,x0));
    secondderx0 = double(subs(secondder,x0));
    if(abs((fx0*secondderx0)/(firstderx0^2)) >= 1)
        disp('This algorithm does not converge in this point');
        res = [];
        return;
    end
    
    if(fx0 == 0)
        res = x0;
        return;
    end
    points = [];
    x1 = x0 - fx0/firstderx0;
    fx1 = subs(equation,x1);
   
    while(abs(x1 - x0) > maxError)
        points = [points; double(x1)];
        x0 = x1;
        fx0 = subs(equation,x0);
        firstderx0 = subs(firstder,x0);
        x1 = double(x0 - double(fx0/firstderx0));
        fx1 = subs(equation,x1);
        
        
    end
    
    res = [points;x1];
    
    plotTheGraph(equation , res , a - 1 , a + 1);
    
    
end