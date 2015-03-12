function testWaitingList(program, schedule, waitingList, verbose)
    % Test the waitingList
    
    noErrorWaitingListTest(program, schedule, waitingList, verbose);
    correctOrderWaitingListTest(program, schedule, waitingList, verbose);
end