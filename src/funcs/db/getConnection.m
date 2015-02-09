function [conn] = getConnection()
    addpath('../../../../private/Connections');
    stevemcawesome
    
    % Check if connection was succesful
    if strncmp(conn.Message, 'Access denied', 13)
        error('Could not connect to database.');
    end
end