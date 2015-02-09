function leastAverageWaitingTimeTest(program, matches, schedule, verbose)
    averageWaitingTime = 0;
    averageBiggestWaitingTime = 0;
    waitingTimes = zeros(12,1);
    num = 0;
    
    for k = 1:program.numDays
        for i = 1:program.numStuds
            slots = [];
            % Find which slots the interviews are in
            for j = 1:program.numComps
                for b = 1:length(schedule{j,k})
                    for s = 1:program.numInters
                        % Check if student is in current spot
                        if schedule{j,k}{b}(s) == i
                            slots = [slots s];
                        end
                    end
                end
            end
            waits = diff(sort(slots));
            if length(slots) > 1
                % Find biggest waiting time
                averageBiggestWaitingTime = averageBiggestWaitingTime...
                    + max(waits) - 1;
                averageWaitingTime = averageWaitingTime...
                    + mean(waits) - 1;
                num = num + 1;
                
                % Record
                for time = waits
                    waitingTimes(time) = waitingTimes(time) + 1;
                end
            end
        end
    end
    
    averageWaitingTime = round(100*averageWaitingTime/num)/100;
    averageBiggestWaitingTime = round(100*averageBiggestWaitingTime/num)/100;
    
    info(['average waiting time: ' num2str(averageWaitingTime)], verbose);
    displayPassed('average waiting time below 2', averageWaitingTime <= 2);
    
    info(['average biggest waiting time: ' num2str(averageBiggestWaitingTime)], verbose);
    displayPassed('average biggest waiting time below 3', averageBiggestWaitingTime <= 3);
    
    if verbose
        % Display table of waiting times
        fprintf('waiting time | indicents\n------------ | ------------\n');
        fprintf('0            | %-12.d\n', waitingTimes(1));
        for i = 1:11
            fprintf('%-12.d | %-12.d\n', i, waitingTimes(i+1));
        end
    end
end