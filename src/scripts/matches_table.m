% Print companies
for j = 1:program.numComps
    fprintf('%10.d | ', j);
end
fprintf('\n');
% Print line
for j = 1:program.numComps
    fprintf('---------- | ');
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
        % Check if students are scheduled
        if isempty(scheduled)
            fprintf('-          | ');
        else
            % Print first
            fprintf('%d', scheduled(1));
            % Print rest
            for i = 2:length(scheduled)
                fprintf(',%d', scheduled(i))
            end
            % Fill space to ten characters
            fill = 10-1-2*(length(scheduled)-1);
            for i = 1:fill
                fprintf(' ');
            end
            fprintf(' | ');
        end
    end
    fprintf('\n');
end