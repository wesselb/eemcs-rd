function [schedule] = bruteForce(program, bruteForceData, verbose)
    % Brute force remainder of schedule to find a feasible schedule
    info('Brute forcing feasiblity', verbose);

    % Calculate amount of solutions to brute force
    maxIndices = bruteForceData.studsLeftLen';
    totLen = 1;
    for i = 1:length(maxIndices)
        totLen = totLen*maxIndices(i);
    end

    % Initial indices
    curIndices = ones(1, length(maxIndices));

    % Keep track of schedule with least conflicts
    leastConflicts = Inf;
    schedule = bruteForceData.schedule;
    
    for i = 1:totLen
         % Do not erase conflicts
        [conflicts, schedule] = applyBruteForceSolution(program, bruteForceData,...
            curIndices, 0);
        
        % Check if best solution after approximation is found
        if conflicts == bruteForceData.minConflicts
            [~, schedule] = applyBruteForceSolution(program, bruteForceData,...
                curIndices, 1);
            break
        else
            % Keep track of best schedule so far
            if conflicts < leastConflicts
                leastConflicts = conflicts;
                bestIndices = curIndices;
            end
        end

        % Advance to next and ripple carry
        j = 1;
        curIndices(1) = curIndices(1) + 1;
        while curIndices(j) > maxIndices(j)
            curIndices(j) = 1;
            if j < length(maxIndices)
                j = j + 1;
                curIndices(j) = curIndices(j) + 1;
            end
        end
    end

    percentage = round(100*i/totLen*100)/100;
    info(['Brute forced ' num2str(percentage) '%'], verbose);

    % Pick out best schedule
    if conflicts > bruteForceData.minConflicts
        disp(['WARNING: could not find feasible schedule (at least '...
            num2str(leastConflicts-bruteForceData.minConflicts) ' extra conflict(s))']);

        % Erase conflicts
        [~, schedule] = applyBruteForceSolution(program, bruteForceData,...
            bestIndices, 1);
    end
end