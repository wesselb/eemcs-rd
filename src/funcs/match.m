function [matches] = match(program, verbose)
    % Find all matches
    
    % Perfect matches
    assVia = program.compInt.*program.studInt';
    info('Find perfect matches', verbose);
    perfectMatches = assign(program, assVia, verbose);

    % Upper half
    adjustedProgram = adjustProgram(program, perfectMatches);
    programUpperHalf = adjustedProgram;
    programUpperHalf.compDay = ceil(adjustedProgram.compDay/2);

    % Company interest matches
    assVia = program.compInt;
    info('Find company interest matches', verbose);
    companyMatches = assign(programUpperHalf, assVia, verbose);

    % Lower half
    programLowerHalf = adjustProgram(adjustedProgram, companyMatches);

    % Student interest matches
    assVia = program.studInt';
    info('Find student interest matches', verbose);
    studentMatches = assign(programLowerHalf, assVia, verbose);

    % Merge all matches
    matches = perfectMatches + companyMatches + studentMatches;
end

