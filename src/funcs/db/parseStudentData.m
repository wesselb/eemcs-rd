function [program] = parseStudentData(program, studentData)
    % Parse student data
    for i = 1:program.numStuds
        % Field 2: ID
        % Field 3: preferences
        % Field 4: availability day 1
        % Field 5: availability day 2
        % Field 6: availability day 3
        % Field 7: nationality

        % Save ID
        program.studID(i) = studentData{i, 2};

        % Save days
        program.studDay(i, 1) = studentData{i, 4};
        program.studDay(i, 2) = studentData{i, 5};
        program.studDay(i, 3) = studentData{i, 6};

        % Save preferences
        prefs = strsplit(studentData{i, 3}, ';');
        for k = 1:length(prefs)
            compID = str2num(prefs{k});
            program.studInt(i, getCompanyIndex(program, compID)) = 1;
        end
        
        % Save nationality
        program.studNat(i) = studentData{i, 7};
    end
end