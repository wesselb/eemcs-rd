function noErrorMatchesTest(program, matches, verbose)
    % No error matches check
    
    numErrorMatches = 0;

    for i = 1:program.numStuds
        for j = 1:program.numComps
            for k = 1:program.numDays
                % Error match by no interest
                if matches(i,j,k) &&...
                        ~program.compInt(j,i) && ~program.studInt(i,j)
                    numErrorMatches = numErrorMatches + 1;
                % Error match by nationality
                elseif matches(i,j,k) &&...
                        ~program.compInt(j,i) && ~program.natVia(j,i)
                    numErrorMatches = numErrorMatches + 1
                end
            end
        end
    end
    
    displayPassed('no error matches', numErrorMatches == 0);
end