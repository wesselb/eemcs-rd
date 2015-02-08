function [program] = parseCompanyAvailabilityData(program, companyAvailabilityData)
    % Set the availability of the companies
    for i = 1:size(companyAvailabilityData, 1)
        % Field 1: ID
        % Field 3: day available

        compID = companyAvailabilityData{i, 1};
        day = str2num(companyAvailabilityData{i, 3});
        program.compDay(getCompanyIndex(program, compID), day) = 1;
    end
end