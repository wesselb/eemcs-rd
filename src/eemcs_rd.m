% Config
verbose = true;

addpath('tools');
addpath('scripts');
addpath('funcs');

% Data-encapsulating object
program = getProgram();

% Perfect matches
assVia = program.compInt.*program.studInt';
timer = startTimer('perfect matches assignment');
perfectMatches = assign(program, assVia, verbose);
stopTimer(timer);

% Upper half
adjustedProgram = adjustProgram(program, perfectMatches);
programUpperHalf = adjustedProgram;
programUpperHalf.compDay = ceil(adjustedProgram.compDay/2);

% Company interest matches
assVia = program.compInt;
timer = startTimer('company interest matches assignment');
companyMatches = assign(programUpperHalf, assVia, verbose);
stopTimer(timer);

% Lower half
programLowerHalf = adjustProgram(adjustedProgram, companyMatches);

% Student interest matches
assVia = program.studInt';
timer = startTimer('student interest matches assignment');
studentMatches = assign(programLowerHalf, assVia, verbose);
stopTimer(timer);

% Merge all matches
matches = perfectMatches + companyMatches + studentMatches;

% Validate matches
timer = startTimer('validate matches');
validate_matches
stopTimer(timer);

% Display assignments
printTable(program, matches)


