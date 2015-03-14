function testSchedule(program, matches, schedule ,verbose)
    % Test the schedule
    
    noErrorScheduleTest(program, matches, schedule, verbose);
    noConflictsScheduleTest(program, matches, schedule, verbose);
    mostStudentsScheduledTest(program, matches, schedule, verbose);
    leastAverageWaitingTimeTest(program, matches, schedule, verbose); 
    doublyAssignedScheduleTest(program, matches, schedule, verbose);
end