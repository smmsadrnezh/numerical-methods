function [ x, more ] = crout( a,b )
    more = {'LU Crout Method'};
    n  = size(a,1);
    u = zeros(n);
    l = zeros(n);
    for i=1:n
        u(i,i) = 1;
    end
    for i=1:n
        for j=1:n
            if (i>=j)
                l(i,j) = (a(i,j) - dot(l(i,:),u(:,j)))/u(j,j);
            else
                 u(i,j) = (a(i,j) - dot(l(i,:),u(:,j)))/l(i,i);
            end
        end
    end
    
    more{end+1} = '$$L = $$';
    for i=1:n
        more{end+1} = [ '$$' clean_array(l(i,:)) '$$' ];
    end
    more{end+2} = '$$U = $$';
    for i=1:n
        more{end+1} = [ '$$' clean_array(u(i,:)) '$$' ];
    end
    
    y = solve_lower(l,b);
    x = solve_upper(u,y);
    
    
    more{end+2} = ['$$ Y = ' clean_array(y') '$$'];
    
    more{end+2} = ['$$ X = ' clean_array(x') '$$'];
end

