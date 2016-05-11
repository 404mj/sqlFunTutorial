create function get_data(int) returns my_table as $$
	select * from my_table where id = $1;
$$ language sql;
--plpgsql;

-- SELECT *, upper(name) FROM getData(1) AS t1;
--select * , upper(name) from get_data(1);