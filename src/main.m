% Config
verbose = true;
randomData = true;
skipGetDataAndMatch = false;

addpath('tools');
addpath('scripts');
addpath('funcs');
addpath('funcs/db');
addpath('funcs/matching');
addpath('funcs/scheduling');
addpath('tests');

if ~skipGetDataAndMatch
    % Data-encapsulating object
    timer = startTimer('get data');
    program = getProgram(randomData);
    stopTimer(timer);

    % Find matches
    timer = startTimer('find matches');
    matches = match(program, verbose);
    stopTimer(timer);
end

% Validate matches
timer = startTimer('validate matches');
testMatches(program, matches, verbose);
stopTimer(timer);

% Display assignments
printTable(program, matches);

% Generate schedule
timer = startTimer('generate schedule');
schedule = generateSchedule(program, matches, verbose);
stopTimer(timer);

% Display schedule
printSchedule(program, schedule);

% Validate schedule
timer = startTimer('validate schedule');
%testSchedule(program, matches, schedule, verbose);
stopTimer(timer);

% TODO's:
% - test schedule
% - data export

