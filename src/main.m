% Config
verbose = 1;
randomData = 1;

useCachedMatches = 0;
useCachedSchedule = 0;

validation = 1;
display = 1;
export = 0;

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

if validation
    % Validate matches
    timer = startTimer('validate matches');
    testMatches(program, matches, verbose);
    stopTimer(timer);
end

if display
    % Display assignments
    printTable(program, matches);
end

if ~useCachedSchedule
    % Generate schedule
    timer = startTimer('generate schedule');
    schedule = generateSchedule(program, matches, verbose);
    stopTimer(timer);
end

if validation
    % Validate schedule
    timer = startTimer('validate schedule');
    testSchedule(program, matches, schedule, verbose);
    stopTimer(timer);
end

if display
    % Display schedule
    printSchedule(program, schedule);
end

if export
    % Export data
    timer = startTimer('export schedule');
    exportSchedule(program, schedule, verbose);
    stopTimer(timer);
end
