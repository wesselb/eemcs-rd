function printSchedule(program, schedule)
    for k = 1:program.numDays
        fprintf('DAY %d:\n', k);
        
        % Print companies and bins
        for j = 1:program.numComps
            for b = 1:length(schedule{j,k})
                fprintf('%-3.d (%1.i) | ', program.compID(j), b);
            end
        end
        fprintf('\n');
        
        % Print horizontal separator
        for j = 1:program.numComps
            for b = 1:length(schedule{j,k})
                fprintf('------- | ');
            end
        end
        fprintf('\n');
        
        for i = 1:program.numInters
            for j = 1:program.numComps
                for b = 1:length(schedule{j,k})
                    bin = schedule{j,k}{b};
                    
                    % Check if the schedule has ended or no student is
                    % scheduled
                    if i > length(bin) || bin(i) == 0
                        fprintf('-       | ');
                    else
                        fprintf('%-7.d | ', program.studID(bin(i)));
                    end                   
                end
            end
            fprintf('\n');
        end
    end
end