SELECT
    department_name
   ,city
FROM
    hr.departments
    INNER JOIN hr.locations
    ON departments.location_id = locations.location_id
WHERE
    city = 'Toronto';

SELECT
    city
FROM
    hr.locations
WHERE
    city = 'Toronto';
