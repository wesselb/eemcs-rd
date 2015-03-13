function exportWaitingList(program, waitingList, scheduleNum, verbose)
    conn = getConnection();
    
    % Find table name
    tableName = ['waitingList' num2str(scheduleNum)];
    info(['Table name: ' tableName], verbose);
    
    % Create table
    query = [...
        'create table ' tableName ' ( '...
            'id int(4) unsigned auto_increment primary key, '...
            'company_uid int(6) unsigned, '...
            'day int(1) unsigned, '...
            'student_uids char(' num2str(program.maxWaitingList*4+10) ') '...
        ')'];
    res = exec(conn, query);
    info(['Table creation message: ' res.Message], verbose);

    % Insert data
    query = [...
        'insert into ' tableName ' '...
        '(company_uid, day, student_uids) '...
        'values '];
    
    for k = 1:program.numDays
        for j = 1:program.numComps
            compID = program.compID(j);
            query = [query '(' num2str(compID) ', ' num2str(k) ', ' char(39)];
            for i = 1:length(waitingList{j})
                studID = program.studID(waitingList{j}(i));
                % Check if max are added
                if i > program.maxWaitingList
                    break
                end         
                % Check if delimiter has to be added
                if i > 1
                    query = [query ';'];
                end
                % Add student
                query = [query num2str(studID)];
            end
            query = [query char(39) '),'];
        end
    end
    
    % Remove last comma and execute insertion
    query = query(1:(length(query)-1));
    res = exec(conn, query);
    info(['Data insertion message: ' res.Message], verbose);
    
    close(conn);
end
