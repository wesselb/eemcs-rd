function [program] = parseNationalities(program)
    % Parse nationalities to viability
    program.natVia = zeros(program.numComps, program.numStuds);
    
    % Check if nationality matches with company
    for j = 1:program.numComps
        for i = 1:program.numStuds
            for n = program.compNat{j}
                if n == program.studNat(i)
                    program.natVia(j,i) = 1;
                end
            end
        end
    end
end