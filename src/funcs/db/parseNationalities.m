function [program] = parseNationalities(program)
    % Parse nationalities to viability
    program.natVia = rand(program.numComps, program.numStuds) < 1; % Random for now to test
end