function [compIndex] = getCompanyIndex(program, compID)
    % Find index of company
    compIndex = [];
    for j = 1:program.numComps
        if program.compID(j) == compID
            compIndex = j;
        end
    end
end