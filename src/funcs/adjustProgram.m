function [program] = adjustProgram(program, assignment)
    % Adjust a program to an assignment
    
    for i = 1:program.numStuds
        for j = 1:program.numComps
            for k = 1:program.numDays
                % Check if student i is assigned to company j on day k
                if assignment(i,j,k)                  
                    % Student i cannot be matched to j any more
                    program.compVia(j,i) = 0;
                    % Student i has one less match maximum
                    program.studAss(i) = program.studAss(i) - 1;
                    % Company j has one less spot on day k
                    program.compDay(j,k) = program.compDay(j,k) - 1;
                end
            end
        end
    end
end