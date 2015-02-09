function [conflicts, schedule] = applyBruteForceSolution(program, bruteForceData, curIndices, eraseConflicts)
    % Apply a permutation

    schedule = bruteForceData.schedule;
    day = bruteForceData.day;
    % Copy pre-allocated flag data
    flags = bruteForceData.flags;

    % Fill in schedule with current solution
    for j = 1:program.numComps
        for s = 1:size(bruteForceData.studsLeftSpots{j},1)
            bin = bruteForceData.studsLeftSpots{j}(s,1);
            slot = bruteForceData.studsLeftSpots{j}(s,2);
            stud = bruteForceData.studsLeft{j}(curIndices(j), s);
            schedule{j,day}{bin}(slot) = stud;
        end
    end

    % Find all conflicts
    conflicts = 0;
    for j = 1:program.numComps
        for s = 1:size(bruteForceData.studsLeftSpots{j},1)
            bin = bruteForceData.studsLeftSpots{j}(s,1);
            slot = bruteForceData.studsLeftSpots{j}(s,2);
            stud = bruteForceData.studsLeft{j}(curIndices(j), s);
            
            % If spot is flagged, do not check for conflicts, otherwise
            % some conflicts will be counted multiple times
            if flags{j}(bin,slot)
                continue
            end

            % Walk through all concurrent slots
            for jj = 1:program.numComps
                for bb = 1:length(schedule{jj,day})                        
                    % Check for conflict, only if tha
                    if schedule{jj,day}{bb}(slot) == stud &&...
                           (jj ~= j || (jj == j && bb ~= bin))
                        conflicts = conflicts + 1;
                        flags{jj}(bb, slot) = 1;
                        
                        % Check if conflict has to be erased
                        if eraseConflicts
                            schedule{jj,day}{bb}(slot) = 0;
                        end
                    end
                end
            end
        end
    end
end