create function getdata (integer) returns text as $$
    declare 
        eid alias for $1;
        found_employee employee%ROWTYPE;
    begin
        select into found_employee * from employee where id = eid;
        return found_employee.name || ' ' || found_employee.city;
    end;
$$ language plpgsql;