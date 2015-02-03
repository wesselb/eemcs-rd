% Assignment of the perfect matches by reduction to max-flow for bipartite
% matching. Note that every student is assigned to a company only once.

% Nodes:
% - students
% - students per company
% - students per company per day
% - company per day

getStudNode = @(stud) stud;
getStudPerCompNode = @(stud, comp) numStuds...
    + (stud-1)*numComps + comp;
getStudPerCompPerDayNode = @(stud, comp, day) numStuds...
    + numStuds*numComps + (stud-1)*numComps*numDays + (comp-1)*numDays...
    + day;
getCompPerDayNode = @(comp, day) numStuds + numStuds*numComps...
    + numStuds*numComps*numDays + (comp-1)*numDays + day;
sourceNode = numStuds + numStuds*numComps + numStuds*numComps*numDays...
    + numComps*numDays + 1;
sinkNode = sourceNode + 1;

% Sparse adjacency matrix for the required max-flow calculation
display('Allocate memory');
adj = zeros(sinkNode,sinkNode);

% Source to student edges
display('Generate adjacency matrix');
for i = 1:numStuds
    adj(sourceNode, getStudNode(i)) = maxStudAsses;
end

% Student to student per company edges
for i = 1:numStuds
    for j = 1:numComps
        if compVia(j, i) == 1 && assVia(j,i)
            adj(getStudNode(i), getStudPerCompNode(i,j)) = 1;
        end
    end
end

% Student per company to student per company per day edges
for i = 1:numStuds
    for j = 1:numComps
        for k = 1:numDays
            if studDay(i,k) == 1
                adj(getStudPerCompNode(i,j),...
                    getStudPerCompPerDayNode(i,j,k)) = 1;
            end
        end
    end
end

% Student per company per day to company per day edges
for i = 1:numStuds
    for j = 1:numComps
        for k = 1:numDays
            adj(getStudPerCompPerDayNode(i,j,k),...
                getCompPerDayNode(j,k)) = 100;
        end
    end
end

% Company per day to sink edges
for j = 1:numComps
    for k = 1:numDays
        adj(getCompPerDayNode(j,k), sinkNode) = compDay(j,k);
    end
end

% Convert matrix to sparse representation
display('Convert to sparse representation');
adj = sparse(adj);

% Calculate max-flow
display('Calculate max-flow (pre-push algorithm)');
[valFlow, adjFlow] = graphmaxflow(adj, sourceNode, sinkNode,...
    'Method', 'Goldberg');

% Save assignments
for i = 1:numStuds
    for j = 1:numComps
        for k = 1:numDays
            if abs(adjFlow(getStudPerCompNode(i,j),...
                    getStudPerCompPerDayNode(i,j,k))-1)<0.001
                ass(i,j,k) = 1;
            end
        end
    end
end
            