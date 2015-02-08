function [program] = parseCompanyListNOI(program, companyListNOI)
    % Set the number of spots available of the companies
    for i = 1:size(companyListNOI, 1)
        % Field 1: ID
        % Field 3: NOI

        compID = companyListNOI{i, 1};
        compIndex = getCompanyIndex(program, compID);

        % If no NOI is given, the value is NaN
        if isnan(companyListNOI{i,3})
            program.compDay(compIndex, :) = 0;
        else
            program.compDay(compIndex, :) =...
                program.compDay(compIndex, :)...
                * companyListNOI{i,3} * program.numInters;
        end
    end
end