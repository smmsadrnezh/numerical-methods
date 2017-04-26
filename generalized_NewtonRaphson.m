    
function [result] = generalized_NewtonRaphson(n,initial,steps)    
    
   n = 2;
   initial = [2 1];
   steps = 5;
    for i = 1:n
        syms(sprintf('a%d',i));   
    end
     for i = 1:n
         a(i)= sym(sprintf('a%d',i));  
     end
    
    for i = 1:n
       prompt = 'please enter the equation...';
       h = input(prompt);
       eq(i) = h;
    end
    
    
    for i=1:1:n
        for j=1:1:n
            D(i,j)=diff(eq(i),a(j));
        end
    end
    
    result = initial;
    old=initial;
    for k=1:steps
        
        for i=1:n
            for j=1:n
                Dvalued(i,j)=subs(D(i,j),a,old);
            end
        end
        new=old;
        
        
        for i=1:n
            Di=Dvalued;
            for j=1:n
                Di(j,i)=subs(eq(j),a,old)*(-1);
            end
            new(i)=old(i) + det(Di)/det(Dvalued);
        end
        result = [result;new];
        old=new;
        
    end

  
    end
    
    
   
    
    
   