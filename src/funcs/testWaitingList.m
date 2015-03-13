function testWaitingList(program, schedule, waitingList, verbose)
    % Test the waiting list
    
    noErrorWaitingListTest(program, schedule, waitingList, verbose);
    correctOrderWaitingListTest(program, schedule, waitingList, verbose);
    nonEmptyWaitingListTest(program, schedule, waitingList, verbose);
end