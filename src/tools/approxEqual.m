function [equality] = approxEqual(a, b)
    % Return wether a and b are approximately equal
    
    if abs(a-b) < 0.0001
        equality = true;
    else
        equality = false;
    end
end