function [program] = setCompanyIDs(program, companyData)
    % Set company IDs
    for j = 1:program.numComps
        program.compID(j) = companyData{j, 2};
    end
end