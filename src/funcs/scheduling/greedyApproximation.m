function [schedule, minConflicts] = greedyApproximation(program, greedyData, verbose)
    % Partially fill in the schedule with a greedy approximation
    
    info('Partial greedy approximation', verbose);
    
    % Get required data
    day = greedyData.day;
    schedule = greedyData.schedule;
    
    % All found conflicts cannot be resolved by further brute forcing
    minConflicts = 0;
    
    for i = greedyData.studDayOrder(day, :)
        % Keep track in which slots the student is already scheduled
        usedSlots = zeros(program.numInters, 1);
        for j = 1:program.numComps
            if greedyData.matches(i,j,day)
                scheduled = 0;
                % Find first spot available        
                for s = 1:program.numInters
                    for b = 1:length(schedule{j,day}) 
                        % Okay if slot is not already used or in use
                        if ~usedSlots(s) &&...
                                schedule{j,day}{b}(s) == 0
                            schedule{j,day}{b}(s) = i;
                            usedSlots(s) = 1;
                            scheduled = 1;
                            break
                        end
                    end

                    % Stop if scheduled
                    if scheduled
                        break
                    end
                end

                % If the student is not scheduled the conflict
                if ~scheduled
                    minConflicts = minConflicts + 1;
                end
            end
        end
        
        info(['Could not schedule ' num2str(minConflicts) ' student(s)'], verbose);

        % Check the amount of remaining solutions assuming all spots will
        % be filled
        permsLeft = 1;
        for j = 1:program.numComps
            spotsLeft = 0;
            for b = 1:length(schedule{j,day})                        
                for s = 1:program.numInters
                    % Check if slot is free
                   if schedule{j,day}{b}(s) == 0   
                       spotsLeft = spotsLeft + 1;
                   end
                end
            end
            permsLeft = permsLeft*factorial(spotsLeft);
        end

        % Check if approximation is far enough
        if permsLeft < greedyData.permsLeftLim
            break
        end
    end
end