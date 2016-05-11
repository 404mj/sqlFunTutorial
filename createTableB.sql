CREATE TABLE books (
     id           integer NOT NULL,
     title        text NOT NULL,
     author_id    integer,
     subject_id   integer,
     Constraint books_id_pkey  Primary Key (id)
);
insert into books values (7808,  'Java',                  4156, 9);

insert into books values(4513,  'Javascript',            1866, 15);

insert into books values(4267,  'C#',                    2001, 15);

insert into books values(1608,  'Oracle',                1809, 2);

insert into books values(1590,  'Sql Server',            1809, 2);

insert into books values(25908, 'Postgre SQL',          15990, 2);

insert into books values(1501,  'Python',                2031, 2);

insert into books values(190,   'Java by API',             16, 6);

insert into books values(1234,  '2D',                   25041, 3);

insert into books values(2038,  'C',                     1644, 0);

insert into books values(156,   'C++',                    115, 9);

insert into books values(41473, 'Programming Python',    7805, 4);

insert into books values(41477, 'Learning Python',       7805, 4);

insert into books values(41478, 'Perl Cookbook',         7806, 4);

insert into books values(41472, 'Practical PostgreSQL',  1212, 4);