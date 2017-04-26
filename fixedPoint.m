function result = fixedPoint(equation , x0 , n , maxError )
    format long;
    prompt = 'if you are not sure about your initial point and you want to give an interval enter YES o.w. enter NO ... ';
    cond = input(prompt , 's');
    if strcmp(cond , 'YES')
        prompt = 'please enter your desired interval ... ';
        interval = input(prompt);
        roots = find_the_roots(equation,interval(1),interval(2));
    
        [row col] = size(roots);
        if row > 2
        y = sprintf('the equation has %d roots in this interval !!!' , roots(1));
        disp(y);
        prompt = 'Which one do you want? ';
        x = input(prompt)
        interv = roots(x+1 ,:);
        x0 = (interv(1) + interv(1))/2;
    end
    end
    
    a = x0;
    g = strcat(equation , '+ x');
    disp(g)
    points = [];
    for i=1:n
         x1 = double(subs(g,x0));
         if abs(x0 - x1) < maxError
            result = [points;x1];
            return;  
         else
            x0 = x1;
            points = [points; x1];
         end;
    end
    result = points;
    
    plotTheGraph(equation , result , a - 1 , a + 1);

end