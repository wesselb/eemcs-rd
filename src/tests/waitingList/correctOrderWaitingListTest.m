function correctOrderWaitingListTest(program, schedule, waitingList, verbose)
    % Check if the waiting list has the correct order

    % Find amount of times every student is scheduled
    studScheduled = zeros(program.numStuds, 1);
    for i = 1:program.numStuds
        for j = 1:program.numComps
            for k = 1:program.numDays
                for b = 1:length(schedule{j,k})
                    for s = 1:program.numInters
                        if schedule{j,k}{b}(s) == i
                            studScheduled(i) = studScheduled(i) + 1;
                        end
                    end
                end
            end
        end
    end
    
    % The amount of times a student is scheduled should be ascending
    passed = 1;
    for k = 1:program.numDays
        for j = 1:program.numComps
            if length(waitingList{j, k}) > 1
                for i = 1:(length(waitingList{j, k})-1)
                    if studScheduled(waitingList{j, k}(i)) > studScheduled(waitingList{j, k}(i+1))
                        passed = 0;
                    end
                end
            end
        end
    end
    
    displayPassed('correct order waiting list', passed == 1);
end