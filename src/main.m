% Config
verbose = 1;
randomData = 1;

useCachedMatches = 1;
useCachedSchedule = 1;

addpath('tools');
addpath('scripts');
addpath('funcs');
addpath('funcs/db');
addpath('funcs/matching');
addpath('funcs/scheduling');
addpath('tests');
addpath('tests/matching');
addpath('tests/scheduling');

if ~useCachedMatches
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

if ~useCachedSchedule
    % Generate schedule
    timer = startTimer('generate schedule');
    schedule = generateSchedule(program, matches, verbose);
    stopTimer(timer);
end

% Display schedule
printSchedule(program, schedule);

% Validate schedule
timer = startTimer('validate schedule');
% testSchedule(program, matches, schedule, verbose);
stopTimer(timer);

% TODO's:
% - test schedule
% - data export

