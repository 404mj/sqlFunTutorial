--insert into emp values ('None', 1000.0, 25, '(2,2)');

create function new_emp() returns emp as $$
	select row('None',1000.0, 25, '(2,2)')::emp;
$$ language sql;
