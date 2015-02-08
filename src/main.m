% Config
verbose = true;

addpath('tools');
addpath('scripts');
addpath('funcs');
addpath('funcs/db');
addpath('tests');

% Data-encapsulating object
timer = startTimer('get data');
program = getProgram();
stopTimer(timer);

% Find matches
timer = startTimer('find matches');
matches = match(program, verbose);
stopTimer(timer);

% Validate matches
timer = startTimer('validate matches');
testMatches(program, matches, verbose);
stopTimer(timer);

% Display assignments
printTable(program, matches);

% TODO: zeros(1 arg)


