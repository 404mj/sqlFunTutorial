create function getName(emp) returns varchar(10) as $$
    select $1.name;
$$ language sql;
--select getName(emp.*) from emp;

-- drop function getName(emp);