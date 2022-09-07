create database adata;

create table city(
    city_name varchar(255),
    city_id integer primary key
);

create table accounts(
    user_account_id integer primary key,
    account_role varchar(255)
);

create table departments(

    department_id integer primary key,
    department_name varchar(255)
);

create table office(
    office_id integer primary key,
    adress varchar(255),

    city_id integer,

    foreign key(city_id) references city(city_id)
);

create table employees(
    Full_Name varchar(255) primary key,
    working_position varchar(255),
    employment_date DATE,
    salary integer NOT NULL,

    user_account_id integer,

    department_id integer NOT NULL,

    foreign key(department_id) references departments(department_id),
    office_id integer,
    foreign key(office_id) references office(office_id),
    foreign key(user_account_id) references accounts(user_account_id)
);

Insert into city (city_name, city_id) values ('almaty', 1);
insert into city (city_name, city_id) values ('astana', 2);
insert into city (city_name, city_id) values ('taraz', 3);

insert into accounts (user_account_id, account_role) values (1, 'admin');
insert into accounts (user_account_id, account_role) values (2, 'employee');

insert into departments (department_id, department_name) values (1, 'IT');
insert into departments (department_id, department_name) values (2, 'HR');
insert into departments (department_id, department_name) values (3, 'Sales');
insert into departments (department_id, department_name) values (4, 'Снабжение');

insert into office (office_id, adress, city_id) values (1, 'Tole Bi street 51', 1);
insert into office (office_id, adress, city_id) values (2, 'Abay street 68', 1);
insert into office (office_id, adress, city_id) values (3, 'Independence street 21', 2);
insert into office (office_id, adress, city_id) values (4, 'street No 36', 2);
insert into office (office_id, adress, city_id) values (5, 'Prikolov street 14', 3);
insert into office (office_id, adress, city_id) values (6, 'Domestos street 25', 3);

insert into employees (Full_Name, working_position, employment_date, salary, user_account_id, department_id, office_id)
VALUES ('Jaldybaev Alikhan', 'Web-developer', to_date('23/08/2019','DD/MM/YYYY'), 250000, 1, 1, 1);

insert into employees (Full_Name, working_position, employment_date, salary, user_account_id, department_id, office_id)
VALUES ('Orakbay Kassym', 'data engineer', to_date('14/05/2016','DD/MM/YYYY'), 250000, 2, 1, 2);

insert into employees (Full_Name, working_position, employment_date, salary, user_account_id, department_id, office_id)
VALUES ('Frolov Ilya', 'HR recruiter', to_date('21/12/2020','DD/MM/YYYY'), 140000, 1, 2, 4);

insert into employees (Full_Name, working_position, employment_date, salary, user_account_id, department_id, office_id)
VALUES ('Nysanov Ersain', 'sales manager', to_date('22/03/2018','DD/MM/YYYY'), 170000, 1, 3, 3);

insert into employees (Full_Name, working_position, employment_date, salary, user_account_id, department_id, office_id)
VALUES ('Baicherkeshev Damir', 'sales manager', to_date('23/04/2021','DD/MM/YYYY'), 130000, 1, 3, 4);

insert into employees (Full_Name, working_position, employment_date, salary, user_account_id, department_id, office_id)
VALUES ('Smirnov David', 'Web-developer', to_date('25/08/2020','DD/MM/YYYY'), 250000, 1, 4, 2);


--2
select d.department_name, avg(e.salary) as avg_salary
from employees e
join departments d
on d.department_id = e.department_id
GROUP BY d.department_id ;



--4

CREATE VIEW task_4 AS

SELECT e.working_position, d.department_name
from departments d
join employees e on e.department_id = d.department_id
group by  working_position, department_name

UNION

Select d.department_name, e.Full_Name
from employees e
join departments d
on d.department_id = e.department_id
where e.employment_date > '01-01-2021'

Union
SELECT avg(salary)
from employees
group by (working_position)



--1
select Full_Name, salary, working_position
from employees e
join departments d
  on e.department_id = d.department_id
where e.full_name like '%David%'
  and d.department_name = 'Снабжение';

--3


SELECT working_position, AVG(salary) AS AVG_salary_for_position,
                    CASE
                        WHEN AVG(salary) > 97000 THEN 'Yes'
                        WHEN AVG(salary) < 97000 THEN 'No'
                    END AVG_Salary_Comparison
                    FROM departments
                        LEFT JOIN employees ON departments.department_id = employees.department_id
    GROUP BY working_position;