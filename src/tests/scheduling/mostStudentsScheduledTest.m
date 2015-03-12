function mostStudentsScheduledTest(program, matches, schedule, verbose)
    % Check if the waiting list is in the correct order

    misses = 0;
    hits = 0;
    
    for i = 1:program.numStuds
        for j = 1:program.numComps
            for k = 1:program.numDays
                if matches(i,j,k)
                    found = 0;
                    % Student must be scheduled
                    for b = 1:length(schedule{j,k})
                        for s = 1:program.numInters
                            if schedule{j,k}{b}(s) == i
                                found = 1;
                            end
                        end
                    end
                    
                    if found
                        hits = hits + 1;
                    else
                        misses = misses + 1;
                    end
                end
            end
        end
    end
    
    percentage = floor(hits/(hits+misses)*100);
    info(['matched students scheduled: '...
        num2str(hits) '/' num2str(hits + misses) ' ('...
        num2str(percentage) '%)'], verbose);
    displayPassed('at least 99% students scheduled', percentage >= 99);
end