create function passConstant(v1 integer) returns integer as '
    declare 
        rename $1 to user_no;
        user_no1 alias for $1;
    begin
        return user_no;
        return user_no1;
        return v1;
        return $1;
    end;
' language plpgsql;