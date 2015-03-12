function [matches] = match(program, verbose)
    % Find all matches
    
    % Perfect matches
    assVia = program.compInt.*program.studInt';
    nationalityViability = 0;
    info('Find perfect matches', verbose);
    perfectMatches = assign(program, assVia, verbose, nationalityViability);

    % Upper half
    programLeft = adjustProgram(program, perfectMatches);
    programUpperHalf = programLeft;
    programUpperHalf.compDay = ceil(programLeft.compDay/2);

    % Company interest matches
    assVia = program.compInt;
    nationalityViability = 0;
    info('Find company interest matches', verbose);
    companyMatches = assign(programUpperHalf, assVia, verbose, nationalityViability);

    % Adjust program
    programLeft = adjustProgram(programLeft, companyMatches);

    % Student interest matches
    assVia = program.studInt';
    nationalityViability = 1;
    info('Find student interest matches', verbose);
    studentMatches = assign(programLeft, assVia, verbose, nationalityViability);
    
    % Adjust program
    programLeft = adjustProgram(programLeft, studentMatches);
    
    % Assign now left spots to company interest
    assVia = program.compInt;
    nationalityViability = 0;
    info('Assign left spots to company interest matches', verbose);
    companyMatchesLeft = assign(programLeft, assVia, verbose, nationalityViability);

    % Merge all matches
    matches = perfectMatches + companyMatches + studentMatches + companyMatchesLeft;
end

