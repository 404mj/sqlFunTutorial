create function get_authors (integer) returns text as '
    declare 
        a_id alias for $1;
        found_author authors%ROWTYPE;
    begin
        select into found_author * from autors where id = a_id;
        return found_author.first_name || '' '' ||found_author.last.last.name;
    end;
' language plpgsql; 

--is case intensible!
-- result := word1 || '' , by '' || word2;