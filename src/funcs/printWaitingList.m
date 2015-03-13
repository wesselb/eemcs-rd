function printWaitingList(program, waitingList)
    % Print the waiting list
    for k = 1:program.numDays
        fprintf('WAITING LIST DAY %d:\n', k);
        for j = 1:program.numComps
            fprintf('%-3.d:', program.compID(j));
            for i = waitingList{j}
                fprintf(' %-3.d', program.studID(i));
            end
            fprintf('\n');
        end
    end
end