% Config
verbose = false;

addpath('tools');

% Data-encapsulating object
program = getProgram();

sample_data

% Company-student assignment viability matrix to perfect matches
assVia = program.compInt.*program.studInt';
timer = startTimer('perfect matches assignment');
perfectMatches = assign(program, assVia, verbose);
stopTimer(timer);
program = adjustProgram(program, perfectMatches);

% Split the program
programLowerHalf = program;
programLowerHalf.compDay = floor(program.compDay/2);
programUpperHalf = program;
programUpperHalf.compDay = ceil(program.compDay/2);

% Company-student assignment viability matrix to company interests
assVia = program.compInt;
timer = startTimer('company interest matches assignment');
companyMatches = assign(programUpperHalf, assVia, verbose);
stopTimer(timer);

% Company-student assignment viability matrix to student interests
assVia = program.compInt;
timer = startTimer('student interest matches assignment');
studentMatches = assign(programLowerHalf, assVia, verbose);
stopTimer(timer);

% Merge all matches
matches = perfectMatches + companyMatches + studentMatches;

% Display assignments
for j = 1:numComps
    for k = 1:numDays
        for i = 1:numStuds
            if matches(i,j,k) == 1
                display(['Company ' num2str(j) ' - student '...
                    num2str(i) ' (day ' num2str(k) ')']);
            end
        end
    end
end

