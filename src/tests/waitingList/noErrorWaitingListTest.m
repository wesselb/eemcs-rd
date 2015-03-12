function noErrorWaitingListTest(program, schedule, waitingList, verbose)
    % Test the waiting list for errors
    
    passed = 1;
    for j = 1:program.numComps
        for i = waitingList{j}
            % Test for interest
            if ~(program.studInt(i,j) && program.natVia(j,i)) && ~program.compInt(j,i)
                passed = 0;
            end
            
            % Test not already scheduled
            scheduled = 0;
            for k = 1:program.numDays
                for b = 1:length(schedule{j,k})
                    for s = 1:program.numInters
                        if schedule{j,k}{b}(s) == i
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
    
    displayPassed('no error waiting list', passed == 1);
end