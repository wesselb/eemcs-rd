function [studIndex] = getStudentIndex(program, studID)
    % Get index of student
    studIndex = [];
    for i = 1:program.numStuds
        if program.studID(i) == studID
            studIndex = i;
        end
    end
end