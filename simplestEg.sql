create function one() returns integer as $$
    select 1 as result;
$$ language sql;

--drop function one();