numComps = 38;
numStuds = 50;
numDays = 3;
% Maximum assignments of one student
maxStudAsses = 9;

% Student-company interests matrix
studInt = zeros(numStuds, numComps);
% Company-student interests matrix
compInt = zeros(numComps, numStuds);
% Company-student viability matrix (based on language requirements)
compVia = ones(numComps, numStuds);

% Company-day availability matrix
compDay = ones(numComps, numDays);
% Student-day availability matrix
studDay = ones(numStuds, numDays);

% Student-company-day assignment matrix
ass = zeros(numStuds, numComps, numDays);

% Load sample daya
sample_data

% Company-student assignment viability matrix to perfect matches
assVia = compInt.*studInt';

% Assign perfect matches
display('[perfect matches assignment]');
start = tic;
assignment
time = toc(start);
display(['[time: ' num2str(round(time*100)/100) ' seconds]']);

% Display assignments
for j = 1:numComps
    for k = 1:numDays
        for i = 1:numStuds
            if ass(i,j,k) == 1
                display(['Company ' num2str(j) ' - student '...
                    num2str(i) ' (day ' num2str(k) ')']);
            end
        end
    end
end

