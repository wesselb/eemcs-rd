function allSpotsAssignedTest(program, matches, verbose)
    % Check if all spots are assigned
    
    passed = 1;
    for j = 1:program.numComps
        for k = 1:program.numDays
            if ~(sum(matches(:,j,k)) == program.compDay(j,k))
                passed = 0;
            end
        end
    end
    displayPassed('complete assignment', passed);
end

