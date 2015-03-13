function [assignment] = assign(program, assVia, verbose, nationalityViability)
    % Reduction to max-flow for bipartite matching
    
    % Default value for verbose
    if nargin == 2
        verbose = false;
    end

    % Student-company-day assignment matrix
    assignment = zeros(program.numStuds, program.numComps,...
        program.numDays);

    % Nodes:
    % - students
    % - students per company
    % - students per company per day
    % - company per day

    getStudNode = @(stud) stud;
    getStudPerCompNode = @(stud, comp) program.numStuds...
        + (stud-1)*program.numComps...
        + comp;
    getStudPerCompPerDayNode = @(stud, comp, day) program.numStuds...
        + program.numStuds*program.numComps...
        + (stud-1)*program.numComps*program.numDays...
        + (comp-1)*program.numDays...
        + day;
    getCompPerDayNode = @(comp, day) program.numStuds...
        + program.numStuds*program.numComps...
        + program.numStuds*program.numComps*program.numDays...
        + (comp-1)*program.numDays...
        + day;
    sourceNode = program.numStuds...
        + program.numStuds*program.numComps...
        + program.numStuds*program.numComps*program.numDays...
        + program.numComps*program.numDays + 1;
    sinkNode = sourceNode + 1;
    
    % The sink represents the last node
    numNodes = sinkNode;

    % Sparse adjacency matrix for the required max-flow calculation
    info('Allocate memory', verbose);
    adj = sparse(zeros(numNodes, numNodes));

    % Source to student edges
    info('Generate adjacency matrix', verbose);
    for i = 1:program.numStuds
        adj(sourceNode, getStudNode(i)) = program.studAss(i);
    end

    % Student to student per company edges
    for i = 1:program.numStuds
        for j = 1:program.numComps
            if (program.natVia(j, i) || ~nationalityViability) && program.compVia(j,i) && assVia(j,i)
                adj(getStudNode(i), getStudPerCompNode(i,j)) = 1;
            end
        end
    end

    % Student per company to student per company per day edges
    for i = 1:program.numStuds
        for j = 1:program.numComps
            for k = 1:program.numDays
                if program.studDay(i,k)
                    adj(getStudPerCompNode(i,j),...
                        getStudPerCompPerDayNode(i,j,k)) = 1;
                end
            end
        end
    end

    % Student per company per day to company per day edges
    for i = 1:program.numStuds
        for j = 1:program.numComps
            for k = 1:program.numDays
                adj(getStudPerCompPerDayNode(i,j,k),...
                    getCompPerDayNode(j,k)) = program.maxCompPerDayAsses;
            end
        end
    end

    % Company per day to sink edges
    for j = 1:program.numComps
        for k = 1:program.numDays
            adj(getCompPerDayNode(j,k), sinkNode) = program.compDay(j,k);
        end
    end

    % Calculate max-flow
    info('Calculate max-flow', verbose);
    [valFlow, adjFlow] = graphmaxflow(adj, sourceNode, sinkNode,...
        'Method', 'edmonds');
    info(['Found ' num2str(round(valFlow)) ' matches'], verbose);

    % Save assignments
    for i = 1:program.numStuds
        for j = 1:program.numComps
            for k = 1:program.numDays
                if approxEqual(adjFlow(getStudPerCompNode(i,j),...
                        getStudPerCompPerDayNode(i,j,k)), 1)
                    assignment(i,j,k) = 1;
                end
            end
        end
    end
end
            