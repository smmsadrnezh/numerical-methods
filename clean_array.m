function [ out ] = clean_array(X)
    out = strjoin(arrayfun(@(x) char(x),vpa(X),...
        'UniformOutput',false),',');
    out = [ '[' out ']' ];
end