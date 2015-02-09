function maximumStudentAssignmentsTest(program, matches, verbose)
    % Maximum student assignments check
    
    assigned = zeros(program.numStuds, 1);
    passed = 1;
    for i = 1:program.numStuds
        for j = 1:program.numComps
            for k = 1:program.numDays
                if matches(i,j,k)
                    assigned(i) = assigned(i) + 1;
                end
                if assigned(i) > program.maxStudAsses
                    passed = 0;
                end
            end
        end
    end
    displayPassed('maximum student assignments', passed);
end