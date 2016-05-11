create function alterData(integer, integer) returns integer as '
begin 
    update employee  set salary = salary - $2 where id = $1;
    return 1;
end;
' language 'plpgsql';