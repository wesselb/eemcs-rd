function [waitingList] = generateWaitingList(program, schedule, verbose)
    % Initialize waiting lists
    waitingList = cell(program.numComps, 1);
    for j = 1:program.numComps
        waitingList{j} = [];
    end
    
    % Find possible waiters
    for j = 1:program.numComps
        for i = 1:program.numStuds
            % Check if there is any interest
            if ~(program.studInt(i,j) && program.natVia(j,i)) && ~program.compInt(j,i)
                continue
            end
            
            % Check if the student is already scheduled for this company
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
                continue
            end
            
            waitingList{j} = [waitingList{j} i];
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
        studTimes = studScheduled(waitingList{j});
        [~, I] = sort(studTimes, 'ascend');
        waitingList{j} = waitingList{j}(I);
    end
end