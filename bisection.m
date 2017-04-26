function [result] = bisection(equation,x0,x1,maxError)
        
    
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

    
    points= [];
    fx1 = subs(equation,x1);
    fx0 = subs(equation,x0);
    format long;
    
    
    if fx1*fx0 > 0
        disp('The interval is not an appropriate interval ');
        result = [];
        return;
    end
    
    if(fx1 == 0) 
        result = x1;
        return;
    end
    
    if(fx0 == 0)
        result = x0;
        return;
    end
    
    
    for i = 0:1:30
        mid = (x0 + x1)/2;
        fmid = subs(equation,mid);
        if(fmid == 0)
            break;
        end
        if fmid*fx1 < 0
            if abs( x0 - mid) < maxError
                break;
            end
            x0 = mid;
            points = [points; x0];
            fx0 = fmid;
        else
            if abs( x1 - mid) < maxError
                break;
            end
            x1 = mid;
            points = [points; x1];
            fx1 = fmid;
        end
    end
    result = [points;mid];
    
    plotTheGraph(equation , result , a - 1 , b + 1);
    
end
