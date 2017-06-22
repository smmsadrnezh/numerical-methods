function [absoluteError, relativeError, absoluteErrorOfA, relativeErrorOfA, absoluteErrorOfB, relativeErrorOfB, absoluteErrorOfC, relativeErrorOfC, absoluteErrorOfD, relativeErrorOfD, absoluteErrorOfE, relativeErrorOfE, absoluteErrorOfF, relativeErrorOfF, steps] = getErrors( equation, a, errorA, b, errorB, c, errorC, d, errorD, e, errorE, f, errorF, roundVal, roundMethod)
    roundVal = 0.1^roundVal;
    [absoluteError, relativeError, absoluteErrorOfA, relativeErrorOfA, absoluteErrorOfB, relativeErrorOfB, absoluteErrorOfC, relativeErrorOfC, absoluteErrorOfD, relativeErrorOfD, absoluteErrorOfE, relativeErrorOfE, absoluteErrorOfF, relativeErrorOfF ] = MRecursive( equation, a, errorA, b, errorB, c, errorC, d, errorD, e, errorE, f, errorF, roundVal, roundMethod);
    steps = SReq(equation, a, errorA, b, errorB, c, errorC, d, errorD, e, errorE, f, errorF, roundVal, roundMethod);
end

function [steps] = SReq( equation, a, errorA, b, errorB, c, errorC, d, errorD, e, errorE, f, errorF, roundVal, roundMethod)
    [e1,e2] = breakDown(equation);
    single = [strcat('absolute error of:',equation, ' equals: ', MRecursive( equation, a, errorA, b, errorB, c, errorC, d, errorD, e, errorE, f, errorF, roundVal, roundMethod), '|')];
    if( e2 =='z')
        steps = single;
    else
        s1 = SReq( e1, a, errorA, b, errorB, c, errorC, d, errorD, e, errorE, f, errorF, roundVal, roundMethod);
        s2 = SReq( e2, a, errorA, b, errorB, c, errorC, d, errorD, e, errorE, f, errorF, roundVal, roundMethod);
        steps = strcat(single, s1, s2);
        return;
        [~,sz1] = size(s1);
        [~,sz2] = size(s2);
        steps = zeros(1,sz1+sz2);
        for i=1:sz1
            steps(i)=s1(i);
        end
        for i=1:sz2
            steps(i+sz1) = s2(i);
        end
    end
end

function [eq1, eq2] = breakDown(eqq)
    [~,sz] = size(eqq);
    if(eqq(1) == '(')
        v = 0;     
        for i=1:sz
            if(eqq(i)=='(')
                v = v-1;
            end
            if(eqq(i)==')')
                v = v +1 ;
            end
            if(v == 0)
                eq1 = eqq(1,[2:i-1]);
                eq2 = eqq(1,[i+2:sz]);
                return;
            end
        end
    else
        for i=1:sz
            if(eqq(i)=='+' || eqq(i)=='-')
                eq1 = eqq(1,[1:i-1]);
                eq2 = eqq(1,[i+1:sz]);
                return;
            end
            if(eqq(i)=='*' || eqq(i)=='/' || eqq(i)=='^' || eqq(i)=='(')
                break;
            end
        end
        for i=1:sz
            if(eqq(i)=='*' || eqq(i)=='/')
                eq1 = eqq(1,[1:i-1]);
                eq2 = eqq(1,[i+1:sz]);
                return;
            end
        end
        eq1 = eqq;
        eq2 = 'z';
    end
end

function [absoluteError, relativeError, absoluteErrorOfA, relativeErrorOfA, absoluteErrorOfB, relativeErrorOfB, absoluteErrorOfC, relativeErrorOfC, absoluteErrorOfD, relativeErrorOfD, absoluteErrorOfE, relativeErrorOfE, absoluteErrorOfF, relativeErrorOfF , steps ] = MRecursive( equation, a, errorA, b, errorB, c, errorC, d, errorD, e, errorE, f, errorF, roundVal, roundMethod)

F = addError(equation);
    e_a=errorA;
    e_b=errorB;
    e_c=errorC;
    e_d=errorD;
    e_e=errorE;
    e_f=errorF;
   
    ALL = {'a', 'b', 'c', 'd', 'e', 'f', 'e_a','e_b','e_c','e_d','e_e','e_f'};
    RF = valueExcept(F,  a,b,c,d,e,f, e_a ,e_b,e_c,e_d,e_e,e_f, ALL);
    if isnumeric(RF) 
        for i=1:64
            z_a = 1;
            z_b = 1;
            z_c = 1;
            z_d = 1;
            z_e = 1;
            z_f = 1; 
            if( mod (i / 2^0, 2) == 1)
                z_a = -1 ; 
            end
            if( mod (i / 2^1, 2) == 1)
                z_b = -1 ; 
            end
            if( mod (i / 2^2, 2) == 1)
                z_c = -1 ; 
            end
            if( mod (i / 2^3, 2) == 1)
                z_d = -1 ; 
            end
            if( mod (i / 2^4, 2) == 1)
                z_e = -1 ; 
            end
            if( mod (i / 2^5, 2) == 1)
                z_f = -1 ; 
            end
            Temp = valueExcept(F,  a,b,c,d,e,f, z_a*e_a ,z_b*e_b,z_c*e_c,z_d*e_d,z_e*e_e,z_f*e_f, ALL);
            if( Temp > RF ) 
                RF = Temp; 
            end
        end
    end
    
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
    
    
    absoluteErrorOfA = makeNormalNum(absoluteErrorOfA);
    absoluteErrorOfB = makeNormalNum(absoluteErrorOfB);
    absoluteErrorOfC = makeNormalNum(absoluteErrorOfC);
    absoluteErrorOfD = makeNormalNum(absoluteErrorOfD);
    absoluteErrorOfE = makeNormalNum(absoluteErrorOfE);
    absoluteErrorOfF = makeNormalNum(absoluteErrorOfF);
    
    relativeErrorOfA = makeNormalNum(relativeErrorOfA);
    relativeErrorOfB = makeNormalNum(relativeErrorOfB);
    relativeErrorOfC = makeNormalNum(relativeErrorOfC);
    relativeErrorOfD = makeNormalNum(relativeErrorOfD);
    relativeErrorOfE = makeNormalNum(relativeErrorOfE);
    relativeErrorOfF = makeNormalNum(relativeErrorOfF);
    
    absoluteError = makeNormalNum(absoluteError);
    relativeError = makeNormalNum(relativeError);
    
end

function OUT = makeNormalNum(IN)
    if isnumeric(IN) 
        OUT = num2str(IN);
    else 
        OUT = char(IN + 0.0);
    end
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