function [absoluteError, relativeError, absoluteErrorOfA, relativeErrorOfA, absoluteErrorOfB, relativeErrorOfB, absoluteErrorOfC, relativeErrorOfC, absoluteErrorOfD, relativeErrorOfD, absoluteErrorOfE, relativeErrorOfE, absoluteErrorOfF, relativeErrorOfF ] = getErrors( equation, a, errorA, b, errorB, c, errorC, d, errorD, e, errorE, f, errorF, roundMethod)
    roundVal = 4; 
    roundVal = 0.1^roundVal;
   F = addError(equation);
    e_a=errorA;
    e_b=errorB;
    e_c=errorC;
    e_d=errorD;
    e_e=errorE;
    e_f=errorF;
   
    ALL = {'a', 'b', 'c', 'd', 'e', 'f', 'e_a','e_b','e_c','e_d','e_e','e_f'};
    RF = valueExcept(F,  a,b,c,d,e,f, e_a ,e_b,e_c,e_d,e_e,e_f, ALL);
    EF = valueExcept(F,  a,b,c,d,e,f,  0 , 0 , 0 , 0 , 0 , 0 , ALL);
    absoluteErrorOfA = abs(valueExcept(F,  a,b,c,d,e,f,  0 ,e_b,e_c,e_d,e_e,e_f, ALL)-RF);
    absoluteErrorOfB = abs(valueExcept(F,  a,b,c,d,e,f, e_a, 0 ,e_c,e_d,e_e,e_f, ALL)-RF);
    absoluteErrorOfC = abs(valueExcept(F,  a,b,c,d,e,f, e_a,e_b, 0 ,e_d,e_e,e_f, ALL)-RF);
    absoluteErrorOfD = abs(valueExcept(F,  a,b,c,d,e,f, e_a,e_b,e_c, 0 ,e_e,e_f, ALL)-RF);
    absoluteErrorOfE = abs(valueExcept(F,  a,b,c,d,e,f, e_a,e_b,e_c,e_d, 0 ,e_f, ALL)-RF);
    absoluteErrorOfF = abs(valueExcept(F,  a,b,c,d,e,f, e_a,e_b,e_c,e_d,e_e, 0 , ALL)-RF);
    relativeErrorOfA = absoluteErrorOfA / RF;
    relativeErrorOfB = absoluteErrorOfB / RF;
    relativeErrorOfC = absoluteErrorOfC / RF;
    relativeErrorOfD = absoluteErrorOfD / RF;
    relativeErrorOfE = absoluteErrorOfE / RF;
    relativeErrorOfF = absoluteErrorOfF / RF;
    absoluteError = abs(RF - EF);
    relativeError = absoluteError / RF; 
    
    absoluteErrorOfA = myRound(absoluteErrorOfA, roundVal, roundMethod);
    absoluteErrorOfB = myRound(absoluteErrorOfB, roundVal, roundMethod);
    absoluteErrorOfC = myRound(absoluteErrorOfC, roundVal, roundMethod);
    absoluteErrorOfD = myRound(absoluteErrorOfD, roundVal, roundMethod);
    absoluteErrorOfE = myRound(absoluteErrorOfE, roundVal, roundMethod);
    absoluteErrorOfF = myRound(absoluteErrorOfF, roundVal, roundMethod);
    
    relativeErrorOfA = myRound(relativeErrorOfA, roundVal, roundMethod);
    relativeErrorOfB = myRound(relativeErrorOfB, roundVal, roundMethod);
    relativeErrorOfC = myRound(relativeErrorOfC, roundVal, roundMethod);
    relativeErrorOfD = myRound(relativeErrorOfD, roundVal, roundMethod);
    relativeErrorOfE = myRound(relativeErrorOfE, roundVal, roundMethod);
    relativeErrorOfF = myRound(relativeErrorOfF, roundVal, roundMethod);
    
    absoluteError = myRound(absoluteError , roundVal, roundMethod);
    relativeError = myRound(relativeError , roundVal, roundMethod);
end

function A = myRound(Val, R , M)
    if isnumeric(Val)==0
        A = Val;
    elseif strcmp(M, 'symmetric')
        Rem = mod(Val, R/2);
        A = myChop(Val+ Rem, R);
    else
        A= myChop(Val, R);
    end
end

function A = myChop(Val, R)
     A = Val - mod(Val, R);
end

function F = valueExcept(F, a,b,c,d,e,f, e_a,e_b,e_c,e_d,e_e,e_f, V)
    bad = '';
    [~, sz] = size(V);
    for i=1:sz
        sub = getSym(V(i), a,b,c,d,e,f, e_a,e_b,e_c,e_d,e_e,e_f);
        if strcmp(sub, bad)==0 
            F = subs(F, V(i), sub);
        elseif isE(V(i))
            F = subs(F, V(i), 0);
        end
    end
end

function val = getSym(x, a,b,c,d,e,f, e_a,e_b,e_c,e_d,e_e,e_f)
if strcmp(x,'a')
val = a;
end
if strcmp(x,'e_a')
val = e_a;
end
if strcmp(x,'b')
val = b;
end
if strcmp(x,'e_b')
val = e_b;
end
if strcmp(x,'c')
val = c;
end
if strcmp(x,'e_c')
val = e_c;
end
if strcmp(x,'d')
val = d;
end
if strcmp(x,'e_d')
val = e_d;
end
if strcmp(x,'e')
val = e;
end
if strcmp(x,'e_e')
val = e_e;
end
if strcmp(x,'f')
val = f;
end
if strcmp(x,'e_f')
val = e_f;
end

end

function A = isE(E)
    if strcmp(E,'e_a')
        A = 1;
    elseif strcmp(E,'e_b')
        A = 1 ;
       elseif strcmp(E,'e_f')
        A = 1 ;
       elseif strcmp(E,'e_c')
        A = 1 ;
       elseif strcmp(E,'e_d')
        A = 1 ;
       elseif strcmp(E,'e_e')
        A = 1 ;
    else
        A = 0;
    end
end


function EF = addError(F)
    EF = F;
    for c='a':'e'
        ec = strcat('(',c,'+','e_',c,')');
        EF = subs(EF, c,  ec);
    end
    return 
end