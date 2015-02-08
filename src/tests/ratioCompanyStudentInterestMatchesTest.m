function ratioCompanyStudentInterestMatchesTest(program, matches, verbose)
    % Check if the ratio between company and student interest matches is
    % okay

    compDayCompIntMatches = zeros(program.numComps, program.numDays);
    compDayStudIntMatches = zeros(program.numComps, program.numDays);

    for i = 1:program.numStuds
        for j = 1:program.numComps
            for k = 1:program.numDays
                % Student interest match
                if matches(i,j,k) && program.compInt(j,i) &&...
                        ~program.studInt(i,j)
                    compDayCompIntMatches(j,k) = compDayCompIntMatches(j,k)+1;
                end
                % Company interest match
                if matches(i,j,k) && ~program.compInt(j,i) &&...
                        program.studInt(i,j)
                    compDayStudIntMatches(j,k) = compDayStudIntMatches(j,k)+1;
                end
            end
        end
    end
    
    % Largest allowable difference between the specific interest matches
    threshold = 2;
    
    totalErrorRatio = 0;
    numErrorRatio = 0;
    
    passed = 1;
    for j = 1:program.numComps
        for k = 1:program.numDays
            % Difference
            diff = abs(compDayCompIntMatches(j,k) -...
                compDayStudIntMatches(j,k));
            if diff > threshold
                passed = 0;
                totalErrorRatio = totalErrorRatio...
                    + abs(compDayCompIntMatches(j,k)/...
                    compDayStudIntMatches(j,k));
                numErrorRatio = numErrorRatio + 1;
            end
        end
    end
    
    if numErrorRatio > 0
        info(['threshold: ' num2str(threshold)...
            ', average error ratio: '...
            num2str(round(100*totalErrorRatio/numErrorRatio)/100)...
            ' (' num2str(numErrorRatio) ')'], verbose);
    end
    displayPassed('ratio company student interest matches', passed);
end