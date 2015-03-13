function [program] = parseCompanyData(program, companyData)
    % Parse company data
    for i = 1:program.numComps
        % Field 2: ID
        % Field 3: preferences
        % Field 4: availability day 1
        % Field 5: availability day 2
        % Field 6: availability day 3
        % Field 7: NOI
        % Field 8: nationality
        % Field 9: name

        % Save ID
        program.compID(i) = companyData{i, 2};

        % Save days
        NOI = companyData{i, 7};
        program.compDay(i, 1) = companyData{i, 4}*NOI*program.numInters;
        program.compDay(i, 2) = companyData{i, 5}*NOI*program.numInters;
        program.compDay(i, 3) = companyData{i, 6}*NOI*program.numInters;

        % Save preferences
        prefs = strsplit(companyData{i, 3}, ';');
        for k = 1:length(prefs)
            studID = str2num(prefs{k});
            program.compInt(i, getStudentIndex(program, studID)) = 1;
        end
        
        % Save nationality
        program.compNat{i} = [];
        nats = strsplit(companyData{i, 8}, ';');
        for k = 1:length(nats)
            nat = str2num(nats{k});
            program.compNat{i} = [program.compNat{i} nat];
        end
        
        % Save name
        program.compName{i} = companyData{i, 9};
    end
end