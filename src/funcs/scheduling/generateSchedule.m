function [schedule] = generateSchedule(program, matches, verbose)
    % Generate a schedule by a FPTAS

    % Order students per day by number of interviews
    studDayOrder = zeros(program.numDays, program.numStuds);
    for k = 1:program.numDays
        studDayCount = sum(matches(:,:,k),2);
        [~, order] = sort(-studDayCount);
        studDayOrder(k, :) = order;
    end
    
    % Initiate schedule
    schedule = cell(program.numComps, program.numDays);
    for j = 1:program.numComps
        for k = 1:program.numDays
            numBins = ceil(sum(matches(:,j,k))/program.numInters);
            schedule{j, k} = cell(numBins,1);
            
            % Fill with zeros
            for b = 1:numBins
                schedule{j, k}{b} = zeros(program.numInters,1);
            end
        end
    end
    
    % Set invariant greedy approximation data
    greedyData.studDayOrder = studDayOrder;
    greedyData.matches = matches;
    % Maximum amount of remaining solutions which could be brute forced
    greedyData.permsLeftLim = 1e5;    
    
    for k = 1:program.numDays
        % Solve first part of the scheduling by a greedy approximation
        greedyData.schedule = schedule;
        greedyData.day = k;
        [schedule, minConflicts] = greedyApproximation(program, greedyData, verbose);
        
        % Brute force the remainder of the problem for best feasibility
        bruteForceData = generateBruteForceData(program, schedule, matches, k, verbose);
        bruteForceData.minConflicts = minConflicts;
        schedule = bruteForce(program, bruteForceData, verbose);
    end
end
    