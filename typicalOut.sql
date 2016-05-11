 --select c1, a1, sum(预算数) as 预算数  from codes group by c1, a1;
 
--select c2, a2, sum(预算数) as 预算数 from codes group by c2,a2;

select distinct(c2) from codes where c2 like '501%' order by c2;
select distinct(c3) from codes where c3 like '501205%' order by c3;


select a2, sum(预算数) as 预算数  from codes where c2='501201' group by a2
union all
select a2, sum(预算数) as 预算数  from codes where c2='501203' group by a2;


select a2, sum(预算数) as 预算数  from codes where c2='501201' group by a2
union all
select a3, sum(预算数) as 预算数  from codes where c3 like '501201%' group by a3;

--setof codes
-- http://stackoverflow.com/questions/27671140/
--error-return-type-mismatch-in-function-declared-to-return
--returns后边的类型必须完全和返回格式匹配，看看这儿stackOverflow上说的！
--table(a2 varchar,预算数 double precision)

create type level_out as (a2 varchar,预算数 double precision); 
create or replace function level_data_2_3(level2 varchar(10))
returns setof level_out
as $body$
    select a2, sum(预算数) as 预算数  from codes where c2=level2  group by a2
    union all
    select a3, sum(预算数) as 预算数  from codes where c3 like level2 || '%' group by a3;
$body$
language 'sql';



create or replace function union_data(level_1 varchar(10))
returns setof level_out
as $body$
declare 
    level_2 varchar(10);
    set_data level_out;
    flag integer := 1;
begin
    for level_2 in (select distinct(c2) from codes where c2 like level_1 || '%' order by c2) loop
        raise notice 'level_2 %',level_2;
        -- if flag > 1 then
            raise notice '----here is if statement,flag is %',flag;
            raise notice 'set_data is %',set_data;
            raise notice 'set_data is %',set_data;
            --set_data = set_data union all  
            return query select * from level_data_2_3(level_2);
        -- set_data = query(select * level_data_2_3(level_2));
        -- else
            -- select into set_data * from level_data_2_3(level_2);
        -- end if;
        -- flag = flag + 1;
    end loop;
    return;
    /*
    return query 
    select * from level_data_2_3(level_2) where level_2 in (select distinct(c2) from codes where c2 like level_1 || '%' order by c2);

    */
    

    -- return;
end;
$body$
language 'plpgsql';
--==============================
create or replace function union_data(level_1 varchar(10))
returns setof level_out
as $body$
declare 
    level_2 varchar(10);
begin
    for level_2 in (select distinct(c2) from codes where c2 like level_1 || '%' order by c2) loop
        raise notice 'level_2 %',level_2;
        return query select * from level_data_2_3(level_2);
    end loop;
    return;
  end;
$body$
language 'plpgsql';

--===============================sql
  

-----------------------------------
create or replace function union_data(level_1 varchar(10))
returns setof level_out
as $body$
declare 
    level_2 varchar(10);
    set_data level_out;
begin
        return query select * from level_data_2_3(level_2);
        return;
end;
$body$
language 'plpgsql' volatile;

select a1, sum(预算数) as 预算数  from codes group by a1
union all
select * from union_data('501');

--alter table codes alter column c1 type varchar(10);
--alter table codes alter column c2 type varchar(10);
--alter table codes alter column c3 type varchar(10);

--select c2,a2,sum(预算数) as 预算数 from codes where c2 in (select distinct(c2) from codes where c2 like '501%' order by c2) group by c2,a2 order by c2;

--返回结果集
-- returns setof table_name 
-- returns recursor 

--简洁的sql方式是这样的，plpgsql方式要不使用query要不就只能只用遍历的方式了！！！
create or replace function datas() 
returns setof employee as 
$BODY$
--begin 
    select * from employee ;
--end;
$BODY$ 
language 'sql';

--然后发现这样写是不行的，要这样写！！！
create or replace function datas() returns setof employee as $$
    begin 
      return  query select * from employee;
   end;
$$ language 'plpgsql';

create or replace function datas() returns setof record as $$
    declare 
        rec record;
    begin 
      for rec in select * from employee loop
          return next rec;
      end loop;
      -- return null;
   end;
$$ language 'plpgsql';
--这种方式需要指定返回的table的格式

-- 两种调用方式:
--1. select * from  datas();
--2. select datas();

---------------
CREATE OR REPLACE FUNCTION skytf.func_test_result_single ( in_id integer)
 RETURNS SETOF varchar as
$$
DECLARE
    v_name varchar;
BEGIN
   
   for v_name in  ( (select  name  from test_result1  where id = in_id) union (select  name  from test_result2  where id = in_id) )loop
    RETURN NEXT v_name;
   end loop;
   return;
END;
$$
LANGUAGE PLPGSQL;

------------------==================
--http://www.codeweblog.com/postgresq
--l%E5%87%BD%E6%95%B0%E5%A6%82%E4%BD%95%E8%BF%94%E5%9B%9E%E6%95%B0%E6%8D%AE%E9%9B%86/

create type dept_salary as (departmentid int, totalsalary int);
create or replace function f_dept_salary() 
returns setof dept_salary 
as
$$
declare
rec dept_salary%rowtype;
begin
for rec in select departmentid, sum(salary) as totalsalary from f_get_employee() group by departmentid loop
  return next rec;
  end loop;
return;
end;
$$
language 'plpgsql';

--用Out传出的方式

create or replace function f_dept_salary_out(out o_dept text,out o_salary text) 
returns setof record as
$$
declare
    v_rec record;
begin
    for v_rec in select departmentid as dept_id, sum(salary) as total_salary from f_get_employee() group by departmentid loop
        o_dept:=v_rec.dept_id;
        o_salary:=v_rec.total_salary;  
        return next;
    end loop; 
end;
$$
language plpgsql;
--执行结果:
--postgres=# select * from f_dept_salary();
 --departmentid | totalsalary 
---------------+-------------
 --           1 |       80000
   --         3 |      120000
     --       2 |       60000

--postgres=# select * from f_dept_salary_out();
 --o_dept | o_salary 
--------+----------
 --1      | 80000
 --3      | 120000
 --2      | 60000

--根据执行函数变量不同返回不同数据集

create or replace function f_get_rows(text) returns setof record as
$$
declare
rec record;
begin
for rec in EXECUTE 'select * from ' || $1 loop
return next rec;
end loop;
return;
end
$$
language 'plpgsql';


--Version 1.0 succeed!

create type level_out as (a2 varchar,预算数 double precision); 
create or replace function level_data_2_3(level2 varchar(10))
returns setof level_out
as $body$
    select a2, sum(预算数) as 预算数  from codes where c2=level2  group by a2
    union all
    select a3, sum(预算数) as 预算数  from codes where c3 like level2 || '%' group by a3;
$body$
language 'sql';

create or replace function union_data(level_1 varchar(10))
returns setof level_out
as $body$
declare 
    level_2 varchar(10);
begin
    for level_2 in (select distinct(c2) from codes where c2 like level_1 || '%' order by c2) loop
        raise notice 'level_2 %',level_2;
        return query select * from level_data_2_3(level_2);
    end loop;
    return;
  end;
$body$
language 'plpgsql';

select a1, sum(预算数) as 预算数  from codes group by a1
union all
select * from union_data('501');


