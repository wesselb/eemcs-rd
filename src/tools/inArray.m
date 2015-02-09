function [out] = inArray(array, item)
    % Checks if array contains item

    out = 0;
    for i = array
        if i == item
            out = 1;
            break
        end
    end
end