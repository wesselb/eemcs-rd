function noConflictsScheduleTest(program, matches, schedule, verbose)
    % Check if there are no conflicts

    passed = 1;
    for k = 1:program.numDays
        for j = 1:program.numComps
            for b = 1:length(schedule{j,k}) 
                for s = 1:program.numInters
                    % Student must be matched
                    if schedule{j,k}{b}(s) > 0
                        % Walk through all concurrent slots
                        for jj = 1:program.numComps
                            for bb = 1:length(schedule{jj,k})                        
                                % Check for conflict
                                if schedule{jj,k}{bb}(s) ==...
                                        schedule{j,k}{b}(s) &&...
                                       (jj ~= j || (jj == j && bb ~= b))
                                   passed = 0;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    displayPassed('no conflicts schedule', passed);
end