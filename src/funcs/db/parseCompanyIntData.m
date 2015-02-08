function [program] = parseCompanyIntData(program, companyIntData)
    % Set the company preferences
    for i = 1:size(companyIntData, 1)
        % Field 1: ID company
        % Field 3: ID student

        compID = companyIntData{i, 1};
        studID = companyIntData{i, 3};

        program.compInt(...
            getCompanyIndex(program, compID),...
            getStudentIndex(program, studID)) = 1;
    end
end