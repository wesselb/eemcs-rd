function testMatches(program, matches, verbose)
    % Test the matches
    
    allSpotsAssignedTest(program, matches, verbose);
    viabilityTest(program, matches, verbose);
    doublyAssignedTest(program, matches, verbose);
    mostPerfectMatchesTest(program, matches, verbose);
    noErrorMatchesTest(program, matches, verbose);
    ratioCompanyStudentInterestMatchesTest(program, matches, verbose);
    maximumStudentAssignmentsTest(program, matches, verbose);
    maximumCompanyPerDayAssignmentsTest(program, matches, verbose);
end