function [waitingList] = generateWaitingList(program, schedule, verbose)
    % Generate waiting list

    % Initialize waiting lists
    waitingList = cell(program.numComps, program.numDays);
    for j = 1:program.numComps
        for k = 1:program.numDays
            waitingList{j, k} = [];
        end
    end
    
    % Find possible waiters
    for k = 1:program.numDays
        for j = 1:program.numComps
            for i = 1:program.numStuds
                % Check if there is any interest
                if ~(program.studInt(i,j) && program.natVia(j,i)) && ~program.compInt(j,i)
                    continue
                end
                
                % Check if student and company are available that day
                if ~(program.studDay(i,k) > 0 && program.compDay(j,k) > 0)
                    continue
                end

                % Check if the student is already scheduled for this company
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
                    continue
                end

                waitingList{j,k} = [waitingList{j,k} i];
            end
        end
    end      
    
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
    
    % Sort waiting lists
    for j = 1:program.numComps
        for k = 1:program.numDays
            studTimes = studScheduled(waitingList{j, k});
            [~, I] = sort(studTimes, 'ascend');
            waitingList{j, k} = waitingList{j, k}(I);
        end
    end
end