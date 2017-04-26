function [res] = secant(equation,x0,x1,maxErr0r)
    
    a = x0;
    b = x1;
    
    roots = find_the_roots(equation,x0,x1)
    
    [row col] = size(roots);
    if row > 2
        y = sprintf('the equation has %d roots in this interval !!!' , roots(1));
        disp(y);
        prompt = 'Which one do you want? ';
        x = input(prompt)
        interval = roots(x+1 ,:);
        x0 = interval(1);
        x1 = interval(2);
    end
    
    
    points = [x0;x1];

    for counter=1:1:30    
        fx0 = subs(equation,x0);                   
        fx1 = subs(equation,x1);
        
        next = double((x0*fx1-x1*fx0)/(fx1-fx0));
        fnext = subs(equation,next);
        points = [points;next];
        x0 = x1;
        x1 = next;
        if abs(x1 - x0) < maxErr0r
            break;
        end
    end
   
    res = points;
    
    plotTheGraph(equation , res , a  , b );
    
    
end
