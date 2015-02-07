function [program] = getProgram()
    % Returns the data-encapsulating object
    
    program.numComps = 4;
    program.numStuds = 8;
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
    
    sample_data
end

