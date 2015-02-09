function noErrorScheduleTest(program, matches, schedule, verbose)
    % Check if all scheduled students are matched

    passed = 1;
    for k = 1:program.numDays
        for j = 1:program.numComps
            for b = 1:length(schedule{j,k}) 
                for s = 1:program.numInters
                    % Student must be matched
                    if schedule{j,k}{b}(s) > 0 &&...
                            ~matches(schedule{j,k}{b}(s),j,k)
                        passed = 0;
                    end
                end
            end
        end
    end
    
    displayPassed('no error schedule', passed);
end