function [program] = parseCompanyData(program, companyData)
    % Parse student data
    for i = 1:program.numComps
        % Field 2: ID
        % Field 3: preferences
        % Field 4: availability day 1
        % Field 5: availability day 2
        % Field 6: availability day 3
        % Field 7: nationality

        % Save ID
        program.compID(i) = companyData{i, 2};

        % Save days
        program.compDay(i, 1) = 12;%companyData{i, 4}*program.numInters;
        program.compDay(i, 2) = 12;%companyData{i, 5}*program.numInters;
        program.compDay(i, 3) = 12;%companyData{i, 6}*program.numInters;

        % Save preferences
        prefs = strsplit(companyData{i, 3}, ';');
        for k = 1:length(prefs)
            studID = str2num(prefs{k});
            program.compInt(i, getStudentIndex(program, studID)) = 1;
        end
        
        % Save nationality
        program.compNat(i) = 0;%companyData{i, 7};
    end
end