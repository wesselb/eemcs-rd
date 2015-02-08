function maximumCompanyPerDagAssignmentsTest(program, matches, verbose)
    % Maximum company assignments check
    
    assigned = zeros(program.numComps,program.numDays);
    passed = 1;
    for i = 1:program.numStuds
        for j = 1:program.numComps
            for k = 1:program.numDays
                if matches(i,j,k)
                    assigned(j,k) = assigned(j,k) + 1;
                end
                if assigned(j,k) > program.maxCompPerDayAsses
                    passed = 0;
                end
            end
        end
    end
    displayPassed('maximum company per day assignments', passed);
end