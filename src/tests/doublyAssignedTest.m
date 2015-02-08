function doublyAssignedTest(program, matches, verbose)
    % Doubly assigned check

    passed = 1;
    for i = 1:program.numStuds
        for j = 1:program.numComps
            if sum(matches(i,j,:)) > 1
                passed = 0;
            end
        end
    end
    displayPassed('doubly assigned', passed);
end