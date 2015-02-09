function [companyIntData] = getCompanyIntData(conn)
    % Get company likes
    query = [
    'select '...
        'users1.uid as uid1, '...
        'users1.name as company, '...
        'users2.uid as uid2, '...
        'users2.name as student '...
    'from users users1 '...
        'inner join users_roles '...
            'on users1.uid = users_roles.uid '...
        'inner join profile profile1 '...
            'on profile1.uid = users1.uid '...
        'inner join field_data_field_student_type_student '...
            'on field_data_field_student_type_student.entity_id = profile1.pid '...
        'inner join field_data_field_student_type '...
            'on field_data_field_student_type.field_student_type_value = field_data_field_student_type_student.field_student_type_student_value '...
        'inner join profile profile2 '...
            'on profile2.pid = field_data_field_student_type.entity_id '...
        'inner join users users2 '...
            'on users2.uid = profile2.uid '...
    'where users_roles.rid = 5'];
    res = exec(conn, query);
    res = fetch(res);
    companyIntData = res.Data;
end