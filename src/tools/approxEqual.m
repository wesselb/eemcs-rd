function [equality] = approxEqual(a, b)
    % Return wether a and b are approximately equal
    
    if abs(a-b) < 10e-6
        equality = 1;
    else
        equality = 0 ;
    end
end