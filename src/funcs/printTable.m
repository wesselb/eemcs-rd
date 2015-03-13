function printTable(program, matches)
    % Print a table of all matches

    % Calculate line width
    lineWidth = max(max(program.compDay))...
        * (floor(log10(program.numStuds)) + 2);

    % Print companies
    for j = 1:program.numComps
        fprintf(['%' num2str(lineWidth) '.d | '], j);
    end
    fprintf('\n');

    % Print horizontal separator
    for j = 1:program.numComps
        for i = 1:lineWidth
            fprintf('-');
        end
        fprintf(' | ');
    end
    fprintf('\n');

    for k = 1:program.numDays
        for j = 1:program.numComps
            % Find scheduled students
            scheduled = [];
            for i = 1:program.numStuds
                if matches(i,j,k) == 1
                    scheduled = [scheduled i];
                end
            end
            % Check if any student is scheduled
            if isempty(scheduled)
                fprintf('-');
                for i = 1:(lineWidth-1)
                    fprintf(' ');
                end
                fprintf(' | ');
            else
                % Print first student
                fprintf('%d', scheduled(1));
                curWidth = floor(log10(scheduled(1))) + 1;
                % Print rest with extra comma
                for i = 2:length(scheduled)
                    fprintf(',%d', scheduled(i));
                    curWidth = curWidth + floor(log10(scheduled(i))) + 2;
                end
                % Fill remaining space
                for i = 1:(lineWidth-curWidth)
                    fprintf(' ');
                end
                fprintf(' | ');
            end
        end
        fprintf('\n');
    end
end