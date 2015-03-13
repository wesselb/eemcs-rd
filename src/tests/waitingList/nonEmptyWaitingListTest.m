function nonEmptyWaitingListTest(program, schedule, waitingList, verbose)
    % Check if the waiting list is non-empty
    
    passed = 1;
    for k = 1:program.numDays
        for j = 1:program.numComps
            if program.compDay(j,k) > 0 && length(waitingList{j, k}) == 0
                passed = 0;
            end
        end
    end
    
    displayPassed('non-empty waiting list test', passed == 1);
end