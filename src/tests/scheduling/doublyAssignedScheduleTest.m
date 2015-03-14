function doublyAssignedScheduleTest(program, matches, schedule, verbose)
    % Check if there are no conflicts

    passed = 1;
    for k = 1:program.numDays
        for j = 1:program.numComps
            for b = 1:length(schedule{j,k}) 
                for s = 1:program.numInters
                    % Check if student is scheduled
                    if schedule{j,k}{b}(s) > 0
                        i = schedule{j,k}{b}(s);
                        % Now this student cannot be scheduled for this
                        % company at another time
                        for kk = 1:program.numDays
                            for bb = 1:length(schedule{j,kk}) 
                                for ss = 1:program.numInters
                                   % Check if this student is
                                   % scheduled now at another time
                                   if schedule{j,kk}{bb}(ss) == i && (kk ~= k || ss ~= s || bb ~= b)
                                       passed = 0;
                                   end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    displayPassed('no doubly assigned to company', passed);
end