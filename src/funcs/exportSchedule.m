function exportSchedule(program, schedule, verbose)
    conn = getConnection();
    
    % Find table name
    res = exec(conn, 'show tables');
    res = fetch(res);
    tables = res.Data;
    num = 1;
    while 1
        % Check if name is available
        nameAvailable = 1;
        for i = 1:length(tables)
            if strcmp(tables{i}, ['schedule' num2str(num)])
                nameAvailable = 0;
                break
            end
        end
        % If the name is not available, increase num
        if ~nameAvailable
            num = num+1;
        else
            break
        end
    end
    tableName = ['schedule' num2str(num)];
    info(['Table name: ' tableName], verbose);
    
    % Create table
    query = [...
        'create table ' tableName ' ( '...
            'id int(4) unsigned auto_increment primary key, '...
            'student_uid int(6) unsigned, '...
            'company_uid int(6) unsigned, '...
            'day int(1) unsigned, '...
            'slot int(2) unsigned, '...
            'interviewer int(1) unsigned '...
        ')'];
    res = exec(conn, query);
    info(['Table creation message: ' res.Message], verbose);

    % Insert data
    query = [...
        'insert into ' tableName ' '...
        '(student_uid, company_uid, day, slot, interviewer) '...
        'values '];
    
    for k = 1:program.numDays
        for j = 1:program.numComps
            for b = 1:length(schedule{j,k})
                for s = 1:program.numInters
                    stud = schedule{j,k}{b}(s);
                    % Check if a student is scheduled
                    if stud > 0
                        studID = program.studID(stud);
                        compID = program.compID(j);
                        query = [query...
                            '(' num2str(studID)...
                            ',' num2str(compID)...
                            ',' num2str(k)...
                            ',' num2str(s)...
                            ',' num2str(b) '),'];
                    end
                end
            end
        end
    end
    
    % Remove last comma and execute insertion
    query = query(1:(length(query)-1));
    res = exec(conn, query);
    info(['Data insertion message: ' res.Message], verbose);
    
    close(conn);
end
