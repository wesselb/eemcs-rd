% function [schedule] = generateSchedule(program, matches)
    schedule = [];
    
    % Initiate bins
    compBins = cell(program.numComps, 1);
    for i = 1:program.numComps
        compBins{i} = cell(1,1);
    end
    
    % Student day count
    
    
    for i = 1:program.numStuds
        for j = 1:program.numComps
            for k = 1:program.numDays
                if matches(i,j,k)
                    % Find current bin
                    bin = size(compBins{j},1);
                    binSize = size(compBins{j}{bin},1);
                    
                    % Check if bin is full
                    if binSize >= program.numInters
                        bin = bin+1;
                    end
                    
                    % Put student in bin
                    compBins{j}{bin}(binSize+1) = i;
                end
            end
        end
    end
        
% end