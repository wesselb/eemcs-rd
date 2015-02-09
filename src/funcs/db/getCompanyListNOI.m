function [companyListNOI] =  getCompanyListNOI(conn)
    % Get company data (including NOI)
    query = [
    'select '...
        'users.uid, '...
        'users.name, '...
        'field_data_field_no_interviewers_per_day.field_no_interviewers_per_day_value as noiday '...
    'from users '...
        'inner join users_roles '...
            'on users.uid = users_roles.uid '...
        'inner join profile '...
            'on profile.uid = users.uid '...
        'left outer join field_data_field_no_interviewers_per_day '...
            'on field_data_field_no_interviewers_per_day.entity_id = profile.pid '...
    'where users_roles.rid = 5'];
    res = exec(conn, query);
    res = fetch(res);
    companyListNOI = res.Data;
end