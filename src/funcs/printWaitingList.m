function printWaitingList(program, waitingList)
    % Print the waiting list
    display 'WAITING LIST:';
    for j = 1:program.numComps
        fprintf('%-3.d:', program.compID(j));
        for i = waitingList{j}
            fprintf(' %-3.d', program.studID(i));
        end
        fprintf('\n');
    end
end