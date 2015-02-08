% Config
verbose = true;

addpath('tools');
addpath('scripts');
addpath('funcs');
addpath('tests');

% Data-encapsulating object
program = getProgram();

% Find matches
timer = startTimer('find matches');
matches = match(program, verbose);
stopTimer(timer);

% Validate matches
timer = startTimer('validate matches');
testMatches(program, matches, verbose);
stopTimer(timer);

% Display assignments
printTable(program, matches)


