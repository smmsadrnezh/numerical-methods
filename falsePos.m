function res = falsePos(equation, x0 , x1 , maxError)
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
    
    fx0 = subs(equation,x0);                   
    fx1 = subs(equation,x1);
    
   if(fx1 == 0)
        res = x1;
        return;
    end
    
    if(fx0 == 0)
        res = x0;
        return;
    end
    
    if fx1*fx0 > 0
        disp('This interval is not an appropriate interval!!!!');
        return;
    end
    
    next = double(x0 - fx0*(x1 - x0)/(fx1 - fx0));
    fnext = double(subs(equation,next));
    
    points=[];
    
    nextold = 2*next;
    while(abs(nextold - next) > maxError)
        if(fnext *fx1 < 0)
            x0 = x1;
            fx0 = fx1;
            x1 = next;
            fx1 = fnext;
            points = [points;x1];
        else
            x1 = next;
            fx1 = fnext;
            points = [points; x1];
        end
        nextold = next;
        next = double( x0 - fx0*(x1 - x0)/(fx1 - fx0));
        fnext = double(subs(equation,next));
    end
    
    res = [points;next];
    
    plotTheGraph(equation , res , a  , b );
    
    
format long;