function noErrorWaitingListTest(program, schedule, waitingList, verbose)
    % Test the waiting list for errors
    
    passed = 1;
    for k = 1:program.numDays
        for j = 1:program.numComps
            for i = waitingList{j, k}
                % Test for interest
                if ~(program.studInt(i,j) && program.natVia(j,i)) && ~program.compInt(j,i)
                    passed = 0;
                end

                % Check day availability
                if ~(program.studDay(i,k) > 0 && program.compDay(j,k) > 0)
                    passed = 0;
                end

                % Test not already scheduled
                scheduled = 0;
                for k2 = 1:program.numDays
                    for b = 1:length(schedule{j,k2})
                        for s = 1:program.numInters
                            if schedule{j,k2}{b}(s) == i
                                scheduled = 1;
                            end
                        end
                    end
                end
                if scheduled
                    passed = 0;
                end
            end
        end
    end
    
    displayPassed('no error waiting list', passed == 1);
end