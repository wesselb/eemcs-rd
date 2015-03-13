function generateStudentTable(fh, program, schedule, i)
    % Generate the LaTeX tables for the students' schedule

    load_constant_data
    
    % Header
    fprintf(fh, '\\begin{table}[H]\n');
    fprintf(fh, '\\centering\n');
    fprintf(fh, '\\begin{tabularx}{\\linewidth}{@{}lXp{3.6cm}p{3.6cm}p{3.6cm}@{}}\n');
    fprintf(fh, '&&%s&%s&%s \\\\ \\hline \n', daysDesc{1}, daysDesc{2}, daysDesc{3});

    % Content
    for s = 1:program.numInters
        % Description
        fprintf(fh, '%s &%s &', slotsDesc{s,1}, slotsDesc{s, 2});
        
        for k = 1:program.numDays                   
            % Check if scheduled
            scheduled = 0;
            for j = 1:program.numComps
                for b = 1:length(schedule{j,k})
                    if schedule{j,k}{b}(s) == i
                        % Student is scheduled at this slot
                        fprintf(fh, '%s ', program.compName{j});
                        scheduled = 1;

                        % Find location
                        loc = 0;
                        for z = 1:length(locs{k})
                            if locs{k}{z}(1) == program.compID(j)
                                loc = locs{k}{z}(2);
                            end
                        end
                        
                        % Check if location occurs in constant data
                        if loc == 0
                            error('Unknown location');
                        else
                            fprintf(fh, '(zaal %d)', loc);
                        end
                    end
                end
            end
            
            % Placeholder
            if ~scheduled
                fprintf(fh, '-');
            end

            if k < program.numDays
                fprintf(fh, '&');
            end
        end          
    
        fprintf(fh, ' \\\\ \n');
        
        % Check for break to insert
        for b = 1:size(breaksDesc,1)
            % Check if slot is found
            if breaksDesc{b,1} == s
                fprintf(fh, '%s & % s & && \\\\ \n', breaksDesc{b, 2}, breaksDesc{b, 3});
            end
        end
    end
    
    % Post
    fprintf(fh, '\\end{tabularx}\n');
    fprintf(fh, '\\end{table}\n');
    
    % Zaal overview
    for z = 1:length(locsDesc)
        fprintf(fh, 'Zaal %d: %s \\\\ \n', z, locsDesc{z});
    end
end