function [matches] = match(program, verbose)
    % Find all matches
    
    % Perfect matches
    assVia = program.compInt.*program.studInt';
    info('Find perfect matches', verbose);
    perfectMatches = assign(program, assVia, verbose);

    % Upper half
    programLeft = adjustProgram(program, perfectMatches);
    programUpperHalf = programLeft;
    programUpperHalf.compDay = ceil(programLeft.compDay/2);

    % Company interest matches
    assVia = program.compInt;
    info('Find company interest matches', verbose);
    companyMatches = assign(programUpperHalf, assVia, verbose);

    % Adjust program
    programLeft = adjustProgram(programLeft, companyMatches);

    % Student interest matches
    assVia = program.studInt';
    info('Find student interest matches', verbose);
    studentMatches = assign(programLeft, assVia, verbose);
    
    % Adjust program
    programLeft = adjustProgram(programLeft, studentMatches);
    
    % Assign now left spots to company interest
    assVia = program.compInt;
    info('Assign left spots to company interest matches', verbose);
    companyMatchesLeft = assign(programLeft, assVia, verbose);

    % Merge all matches
    matches = perfectMatches + companyMatches + studentMatches + companyMatchesLeft;
end

