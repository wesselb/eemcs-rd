function [program] = setCompanyIDs(program, companyListNOI)
    % Set company IDs
    for j = 1:program.numComps
        program.compID(j) = companyListNOI{j, 1};
    end
end