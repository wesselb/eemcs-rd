function generateWaitingListTables(fh, program, schedule, waitingList, j)
    % Generate the LaTeX tables for the waiting lists
    
    load_constant_data

    % Pre
    for k = 1:program.numDays
        for b = 1:length(schedule{j,k})
            fprintf(fh, '\\begin{table}[H]\n');
            fprintf(fh, '\\centering\n');
            fprintf(fh, '\\begin{tabularx}{\\linewidth}{@{}llX@{}}\n');

            if b == 1
                fprintf(fh, '\\multicolumn{2}{@{}l}{%s}', daysDesc{k});
            else
                fprintf(fh, '\\multicolumn{2}{@{}l}{%s (%d)}', daysDesc{k}, b);
            end
            fprintf(fh, '& \\\\ \\hline \n');

            % Content
            for i = 1:length(waitingList{j,k})
                if i > program.maxWaitingList
                    break
                end
                fprintf(fh, '%d & ', program.studID(waitingList{j,k}(i)));
                name = unicode2native(program.studName{waitingList{j,k}(i)}, 'UTF-8');
                fwrite(fh, name, 'uint8');
                fprintf(fh, '& %s \\\\ \n', program.studTel{waitingList{j,k}(i)});
            end
            
            % Post
            fprintf(fh, '\\end{tabularx}\n');
            fprintf(fh, '\\end{table}\n');
        end
    end
end