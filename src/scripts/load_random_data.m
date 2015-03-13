% Pre-defined data
program.numInters = 12;
program.maxStudAsses = 9;
program.maxCompPerDayAsses = Inf;
program.numDays = 3;

load_sim_data

% Pre-process data
[studID, studIDTab, ~] = unique(dataStuds(:,1));
[compID, compIDTab, ~] = unique(dataComps(:,1));
program.studID = studID;
program.compID = compID;
program.numStuds = length(studID);
program.numComps = length(compID);
program.studAss = program.maxStudAsses*ones(program.numStuds);

% Initialize
program.studInt = zeros(program.numStuds, program.numComps);
program.compInt = zeros(program.numComps, program.numStuds);
program.compVia = zeros(program.numComps, program.numStuds);
program.compDay = zeros(program.numComps, program.numDays);
program.studDay = zeros(program.numStuds, program.numDays);

% Fill availability
for i = 1:size(dataStuds, 1)
    ID = dataStuds(i,1);
    day = dataStuds(i,2);
    
    studNum = find(studID == ID);
    program.studDay(studNum, day) = 1;
end
for i = 1:size(dataComps, 1)
    ID = dataComps(i,1);
    day = dataComps(i,2);
    numParInters = dataComps(i,3);
    
    compNum = find(compID == ID);
    program.compDay(compNum, day) = program.numInters*numParInters;
end

% Set all to viable
program.compVia = ones(program.numComps, program.numStuds);

% Distribute interests randomly
for j = 1:program.numComps
    places = sum(program.compDay(j,:));
    prefs = randperm(program.numStuds);
    
    for i = 1:places
        program.compInt(j,prefs(i)) = 1;
    end
end

ints = [];
for j = 1:program.numComps
    numLikes = dataComps(compIDTab(j), 4);
    for i = 1:numLikes
        ints = [ints j];
    end
end
ints = ints(randperm(length(ints))); % Just a shuffle (MATLAB...)

curStud = 1;
for int = ints
    program.studInt(curStud, int) = 1;
    
    curStud = curStud+1;
    if curStud > program.numStuds
        curStud = 1;
    end
end