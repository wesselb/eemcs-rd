function viabilityTest(program, matches, verbose)
    % Viability check
    
    passed = 1;
    for i = 1:program.numStuds
        for j = 1:program.numComps
            for k = 1:program.numDays
                if matches(i,j,k) && ~program.compVia(j,i)
                    passed = 0;
                end
            end
        end
    end
    displayPassed('viability', passed);
end