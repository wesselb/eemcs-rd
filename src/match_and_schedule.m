% Config
verbose = 1;
randomData = 0;

useCachedMatches = 0;
useCachedSchedule = 0;
validation = 1;
inject = 1;
display = 1;
export = 1;

addpath('tools');
addpath('scripts');
addpath('funcs');
addpath('funcs/db');
addpath('funcs/matching');
addpath('funcs/scheduling');
addpath('funcs/generate');
addpath('tests');
addpath('tests/matching');
addpath('tests/scheduling');
addpath('tests/waitingList');

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
    waitingList = generateWaitingList(program, schedule, verbose);
    stopTimer(timer);
end

if validation
    % Validate schedule
    timer = startTimer('validate schedule');
    testSchedule(program, matches, schedule, verbose);
    testWaitingList(program, schedule, waitingList, verbose);
    stopTimer(timer);
end

if inject
    % Inject rules
    timer = startTimer('inject rules');
    schedule = injectRules(program, schedule);
    stopTimer(timer);
end

if validation
    % Validate schedule
    timer = startTimer('validate schedule after injection');
    testSchedule(program, matches, schedule, verbose);
    testWaitingList(program, schedule, waitingList, verbose);
    stopTimer(timer);
end

if display
    % Display schedule
    printSchedule(program, schedule);
    printWaitingList(program, waitingList);
end

if export
    % Export data
    timer = startTimer('export schedule');
    scheduleNum = exportSchedule(program, schedule, verbose);
    exportWaitingList(program, waitingList, scheduleNum, verbose);
    stopTimer(timer);
end
