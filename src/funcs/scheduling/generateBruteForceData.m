function [bruteForceData] = generateBruteForceData(program, schedule, matches, day, verbose)
    % Generate brute force data
    info('Generating remaining solution permutations', verbose);
    
    bruteForceData = struct;
    bruteForceData.schedule = schedule;
    bruteForceData.day = day;
    
    studsLeft = cell(program.numComps, 1);
    studsLeftSpots = cell(program.numComps, 1);
    studsLeftLen = zeros(program.numComps, 1);

    for j = 1:program.numComps
        studsLeft{j} = [];
        studsLeftSpots{j} = [];

        % Find which students still have to be scheduled
        for i = 1:program.numStuds
            if matches(i, j, day)
                % Check if student is not already scheduled
                scheduled = 0;
                for b = 1:length(schedule{j, day})                        
                    for s = 1:program.numInters
                       if schedule{j, day}{b}(s) == i 
                           scheduled = 1;
                       end
                    end
                end

                % Add if the student is not yet scheduled
                if ~scheduled
                    studsLeft{j} = [studsLeft{j} i];
                end
            end
        end

        % Find which spots to be filled
        for b = 1:length(schedule{j, day})                        
            for s = 1:program.numInters
                % Check if slot is free and still spots are needed
               if schedule{j, day}{b}(s) == 0 &&...
                       size(studsLeftSpots{j},1)  < length(studsLeft{j})
                   studsLeftSpots{j} = [studsLeftSpots{j}; b s];
               end
            end
        end

        % Generate permutations
        studsLeft{j} = perms(studsLeft{j});
        studsLeftLen(j) = size(studsLeft{j},1);
    end
    
    % Flag array which says if that spot is already checked for conflicts
    flags = cell(program.numComps,1);
    for j = 1:program.numComps
        flags{j} = zeros(length(schedule{j, day}), program.numInters);
    end
        
    % Set data
    bruteForceData.studsLeft = studsLeft;
    bruteForceData.studsLeftSpots = studsLeftSpots;
    bruteForceData.studsLeftLen = studsLeftLen;
    bruteForceData.flags = flags;
end