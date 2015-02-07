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