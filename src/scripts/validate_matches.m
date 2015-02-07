% Dependencies: matches, program

%% Check if all spots are assigned
passed = 1;
for j = 1:program.numComps
    for k = 1:program.numDays
        if ~(sum(matches(:,j,k)) == program.compDay(j,k))
            passed = 0;
        end
    end
end
displayPassed('complete assignment', passed);

%% Viability check
passed = 1;
for i = 1:program.numStuds
    for j = 1:program.numComps
        for k = 1:program.numDays
            if matches(i,j,k) && ~program.compVia(j,i)
                passed = 0;
            end
        end
    end
end
displayPassed('viability', passed);

%% Doubly assigned check
passed = 1;
for i = 1:program.numStuds
    for j = 1:program.numComps
        if sum(matches(i,j,:)) > 1
            passed = 0;
        end
    end
end
displayPassed('doubly assigned', passed);

%% Type matches test
numPerfectMatches = sum(sum(program.compInt.*program.studInt'));
numErrorMatches = 0;

compDayPerfectMatches = zeros(program.numComps, program.numDays);
compDayCompIntMatches = zeros(program.numComps, program.numDays);
compDayStudIntMatches = zeros(program.numComps, program.numDays);

for i = 1:program.numStuds
    for j = 1:program.numComps
        for k = 1:program.numDays
            % Perfect match
            if matches(i,j,k) && program.compInt(j,i) &&...
                    program.studInt(i,j)
                compDayPerfectMatches(j,k) = compDayPerfectMatches(j,k)+1;
            end
            % Student interest match
            if matches(i,j,k) && program.compInt(j,i) &&...
                    ~program.studInt(i,j)
                compDayCompIntMatches(j,k) = compDayCompIntMatches(j,k)+1;
            end
            % Company interest match
            if matches(i,j,k) && ~program.compInt(j,i) &&...
                    program.studInt(i,j)
                compDayStudIntMatches(j,k) = compDayStudIntMatches(j,k)+1;
            end
            % Error match
            if matches(i,j,k) && ~program.compInt(j,i) &&...
                    ~program.studInt(i,j)
                numErrorMatches = numErrorMatches + 1;
            end
        end
    end
end


% Percentage perfect matches
percentage = round(100*sum(sum(compDayPerfectMatches))/numPerfectMatches);
display(['perfect matches assigned: '...
    num2str(foundPerfectMatches) '/' num2str(numPerfectMatches) ' ('...
    num2str(percentage) '%)']);

% No missed perfect matches check
misses = sum(sum(program.compDay))-foundPerfectMatches;
displayPassed('no perfect match misses', misses == 0);

% No error matches check
displayPassed('no error matches', numErrorMatches == 0);

% Percentage company interest matches check
passed = 1;
for j = 1:program.numComps
    for k = 1:program.numDays
        diff = abs(compDayCompIntMatches(j,k) -...
            compDayStudIntMatches(j,k));
        if diff > 1
            passed = 0;
        end
    end
end
displayPassed('ratio company student interest matches', passed);


%% Maximum student assignments check
assigned = zeros(program.numStuds);
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

%% Maximum company assignments check
assigned = zeros(program.numComps,program.numDays);
passed = 1;
for i = 1:program.numStuds
    for j = 1:program.numComps
        for k = 1:program.numDays
            if matches(i,j,k)
                assigned(j,k) = assigned(j,k) + 1;
            end
            if assigned(j,k) > program.maxCompPerDayAsses
                passed = 0;
            end
        end
    end
end
displayPassed('maximum company per day assignments', passed);