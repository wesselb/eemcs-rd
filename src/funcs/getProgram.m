function [program] = getProgram(randomData)
    % Returns the data-encapsulating object
    
    % Default value random data
    if nargin == 0
        randomData = 0;
    end
    
    % Check if random data has to be generated
    if randomData
        load_random_data
        return
    end
    
    conn = getConnection();

    studentData = getStudentData(conn);
    companyData = getCompanyData(conn);

    program = struct;
    program.numDays = 3;
    program.maxStudAsses = 9;
    program.maxCompPerDayAsses = Inf;
    program.numInters = 12;
    program.maxWaitingList = 10;

    program.numStuds = size(studentData, 1);
    program.numComps = size(companyData, 1);

    % Student-company interests matrix
    program.studInt = zeros(program.numStuds, program.numComps);
    % Company-student interests matrix
    program.compInt = zeros(program.numComps, program.numStuds);

    % Company-day availability matrix
    program.compDay = zeros(program.numComps, program.numDays);
    % Student-day availability matrix
    program.studDay = zeros(program.numStuds, program.numDays);
    
    % Student nationality matrix
    program.studNat = ones(program.numStuds, 1);
    % Company nationality matrix
    program.compNat = cell(program.numComps, 1);
    % Company-student nationality viability matrix
    program.natVia = ones(program.numComps, program.numStuds);

    % Company-student viability matrix
    program.compVia = ones(program.numComps, program.numStuds);
    % Student number assigned matrix
    program.studAss = program.maxStudAsses*ones(program.numStuds);
    % Student ID matrix
    program.studID = zeros(program.numStuds, 1);
    % Company ID matrix
    program.compID = zeros(program.numComps, 1);
    % Student phone matrix
    program.studTel = cell(program.numStuds, 1);

    % Parse all data
    program = setCompanyIDs(program, companyData);
    program = parseStudentData(program, studentData);
    program = parseCompanyData(program, companyData);
    program = parseNationalities(program);

    close(conn);
end

