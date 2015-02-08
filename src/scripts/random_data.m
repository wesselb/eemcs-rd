program.numComps = 38;
program.numStuds = 250;
program.numDays = 3;
% Maximum assignments of one student
program.maxStudAsses = 9;
% Maximum assignments of a company per day
program.maxCompPerDayAsses = Inf;

% Student-company interests matrix
program.studInt = zeros(program.numStuds, program.numComps);
% Company-student interests matrix
program.compInt = zeros(program.numComps, program.numStuds);
% Company-student viability matrix
program.compVia = zeros(program.numComps, program.numStuds);

% Company-day availability matrix
program.compDay = zeros(program.numComps, program.numDays);
% Student-day availability matrix
program.studDay = zeros(program.numStuds, program.numDays);

% Student number assigned matrix
program.studAss = program.maxStudAsses*ones(program.numStuds);


% Config
studsPerDay = 12;
studDayChance = 2/3;
studIntChance = 1/3;

% All viable
program.compVia = ones(program.numComps, program.numStuds);

% Random
program.compDay = ones(program.numComps, program.numDays)*studsPerDay;
program.studDay = rand(program.numStuds,program.numDays)...
    /(1-studDayChance) > 1;
program.studInt = rand(program.numStuds,program.numComps)...
    /(1-studIntChance) > 1;

% Distribute interests randomly
for j = 1:program.numComps
    places = sum(program.compDay(j,:));
    prefs = randperm(program.numStuds);
    
    for i = 1:places
        program.compInt(j,prefs(i)) = 1;
    end
end