function mostPerfectMatchesTest(program, matches, verbose)
    % Check if most perfect matches are assigned

    numPerfectMatches = sum(sum(program.compInt.*program.studInt'));
    foundPerfectMatches = 0;

    for i = 1:program.numStuds
        for j = 1:program.numComps
            for k = 1:program.numDays
                % Perfect match
                if matches(i,j,k) && program.compInt(j,i) &&...
                        program.studInt(i,j)
                    foundPerfectMatches = foundPerfectMatches+1;
                end
            end
        end
    end

    percentage = floor(100*foundPerfectMatches/numPerfectMatches);
    info(['perfect matches assigned: '...
        num2str(foundPerfectMatches) '/'...
        num2str(numPerfectMatches) ' (' num2str(percentage) '%)'], verbose);
    displayPassed('at least 95% perfect matches assigned', percentage >= 95);
end