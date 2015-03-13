function generateCompanyTables(fh, program, schedule, j)
    % Write company tables as LaTeX into the file handler fh

    load_constant_data

    for k = 1:program.numDays
        for b = 1:length(schedule{j,k})
            % Begin table
            fprintf(fh, '\\begin{table}[H]\n');
            fprintf(fh, '\\centering\n');
            fprintf(fh, '\\begin{tabularx}{\\linewidth}{@{}lllXll@{}}\n');
            
            % Write day
            if b == 1
                fprintf(fh, '\\multicolumn{2}{@{}l}{%s}', daysDesc{k});
            else
                fprintf(fh, '\\multicolumn{2}{@{}l}{%s (%d)}', daysDesc{k}, b);
            end
            fprintf(fh, '&&&Student interest&Company interest\\\\ \\hline \n');

            % Content
            for s = 1:program.numInters
                % Description
                fprintf(fh, '%s & % s &', slotsDesc{s,1}, slotsDesc{s, 2});

                i = schedule{j,k}{b}(s);
                % Check if a student is scheduled
                if i > 0
                    fprintf(fh, '%d &', program.studID(i));
                    name = unicode2native(program.studName{i}, 'UTF-8');
                    fwrite(fh, name, 'uint8');
                    fprintf(fh, ' & ');
                    if program.studInt(i,j)
                        fprintf(fh, 'Yes&');
                    else
                        fprintf(fh, 'No&');
                    end
                    if program.compInt(j,i)
                        fprintf(fh, 'Yes');
                    else
                        fprintf(fh, 'No');
                    end
                end
                fprintf(fh, ' \\\\ \n');
                
                % Check for break to insert
                for b2 = 1:size(breaksDesc,1)
                    % Check if slot is found
                    if breaksDesc{b2,1} == s
                        fprintf(fh, '%s & % s & && \\\\ \n', breaksDesc{b2, 2}, breaksDesc{b2, 3});
                    end
                end
            end

            % Post
            fprintf(fh, '\\end{tabularx}\n');
            fprintf(fh, '\\end{table}\n');
        end
    end
end