function [program] = parseCompanyData(program, companyData)
    % Parse student data
    for i = 1:program.numStuds
        % Field 2: ID
        % Field 3: preferences
        % Field 4: availability day 1
        % Field 5: availability day 2
        % Field 6: availability day 3

        % Save ID
        program.compID(i) = companyData{i, 2};

        % Save days
        program.compDay(i, 1) = companyData{i, 4}*program.numInters;
        program.compDay(i, 2) = companyData{i, 5}*program.numInters;
        program.compDay(i, 3) = companyData{i, 6}*program.numInters;

        % Save preferences
        prefs = strsplit(companyData{i, 3}, ';');
        for k = 1:length(prefs)
            studID = str2num(prefs{k});
            program.compInt(i, getStudentIndex(program, studID)) = 1;
        end
    end
end