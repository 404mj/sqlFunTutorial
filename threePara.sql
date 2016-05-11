create function add_3_para(v1 anyelement,v2 anyelement, v3 anyelement) returns anyelement as $$
    declare 
        result alias for $0;
    begin 
        result := v1+v2+v3;
        --result = v1+v2+v3;
        return result;
        end;
$$ language plpgsql;
