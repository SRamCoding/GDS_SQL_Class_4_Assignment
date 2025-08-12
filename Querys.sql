use module1;

-- Q101:
/*Write an SQL query to show the second 
most recent activity of each user.
If the user only has one activity, return 
that one. A user cannot perform more 
than one activity at the same time.
Return the result table in any order.*/
with y1 as
(select *, 
		row_number() over(partition by username order by startDate) as v1,
		count(*) over(partition by username) as v2
from Q101_UserActivity),

y2 as
(select username, activity, startDate, endDate
from y1
where v1 = 2

union all 

select username, activity, startDate, endDate
from y1
where v2 = 1)

select * from y2;

create table if not exists Q101_UserActivity
(
	username varchar(15),
	activity varchar(15),
    startDate date,
    endDate date
);

insert into Q101_UserActivity (username, activity, startDate, endDate) 
values
('Alice', 'Travel', '2020-02-12', '2020-02-20'),
('Alice', 'Dancing', '2020-02-21', '2020-02-23'),
('Alice', 'Travel', '2020-02-24', '2020-02-28'),
('Bob', 'Travel', '2020-02-11', '2020-02-18');

-- Q102:
/*Write an SQL query to show the second 
most recent activity of each user.
If the user only has one activity, return 
that one. A user cannot perform more 
than one activity at the same time.
Return the result table in any order.*/
with y1 as
(select *, 
		row_number() over(partition by username order by startDate) as v1,
		count(*) over(partition by username) as v2
from Q101_UserActivity),

y2 as
(select username, activity, startDate, endDate
from y1
where v1 = 2

union all 

select username, activity, startDate, endDate
from y1
where v2 = 1)

select * from y2;

-- Q103:
/*Query the Name of any student in 
STUDENTS who scored higher than 75 
Marks. Order your output by the last 
three characters of each name. If 
two or more students both have names 
ending in the same last three 
characters (i.e.: Bobby, Robby, etc.), 
secondary sort them by ascending ID.*/
select name
from Q103_STUDENTS
where Marks > 75
order by right(name, 3) asc, id asc;

create table if not exists Q103_STUDENTS
(
	id int,
	name varchar(15),
    Marks int
);

insert into Q103_STUDENTS (id, name, Marks) 
values
(1, 'Ashley', 81),
(2, 'Samantha', 75),
(4, 'Julia', 76),
(3, 'Belvet', 84);

-- Q104:
/*Write a query that prints a list 
of employee names (i.e.: the name 
attribute) for employees in
Employee having a salary greater 
than $2000 per month who have been 
employees for less than 10
months. Sort your result by ascending 
employee_id.*/
select name
from Q104_Employee
where months < 10 and salary > 2000
order by employee_id asc;

create table if not exists Q104_Employee
(
	employee_id int,
	name varchar(15),
    months int,
    salary int
);

insert into Q104_Employee (employee_id, name, months, salary) 
values
(12228, 'Rose', 15, 1968),
(33645, 'Angela', 1, 3443),
(45692, 'Frank', 17, 1608),
(56118, 'Patrick', 7, 1345),
(59725, 'Lisa', 11, 2330),
(74197, 'Kimberly', 16, 4372),
(78454, 'Bonnie', 8, 1771),
(83565, 'Michael', 6, 2017),
(98607, 'Todd', 5, 3396),
(99989, 'Joe', 9, 3573);

-- Q105:
/*Write a query identifying the 
type of each record in the 
TRIANGLES table using its three 
side lengths.
Output one of the following 
statements for each record in 
the table:
● Equilateral: It's a triangle 
with sides of equal length.
● Isosceles: It's a triangle with 
sides of equal length.
● Scalene: It's a triangle with 
sides of differing lengths.
● Not A Triangle: The given values 
of A, B, and C don't form a 
triangle.*/
select
		case 
			when (A + B > C and A + C > B and B + C > A) 
				then case 
						when A=B and A=C and B=C then 'Equilateral'
                        when A<>B and A<>C and B<>C then 'Scalene'
                        else 'Isosceles'
					 end
			else 'Not A Triangle' 
		end 	as isornot
from Q105_TRIANGLES;

create table if not exists Q105_TRIANGLES
(
	A int,
	B int,
    C int
);

insert into Q105_TRIANGLES (A, B, C) 
values
(20, 20, 23),
(20, 20, 20),
(20, 21, 22),
(13, 14, 30);

-- Q106:
/*Samantha was tasked with 
calculating the average monthly 
salaries for all employees in 
the EMPLOYEES table, but did not 
realise her keyboard's 0 key was 
broken until after completing the
calculation. She wants your help 
finding the difference between her 
miscalculation (using salaries
with any zeros removed), and the 
actual average salary.
Write a query calculating the 
amount of error (i.e.: actual - 
miscalculated average monthly 
salaries), and round it up to the
next integer.*/
with t1 as 
(select avg(cast(replace(salary, '0', '') as unsigned)) as t 
from Q106_EMPLOYEES),

t2 as
(select avg(salary) as g
from Q106_EMPLOYEES)

select abs(ceil(t1.t - t2.g)) as result
from t1, t2;

create table if not exists Q106_EMPLOYEES
(
	id int,
	name varchar(15),
    salary int
);

insert into Q106_EMPLOYEES (id, name, salary) 
values
(1, 'Kristeen', 1420),
(2, 'Ashley', 2006),
(3, 'Julia', 2210),
(4, 'Maria', 3000);

-- Q107:
/*We define an employee's total 
earnings to be their monthly 
salary * months worked, and the
maximum total earnings to be the 
maximum total earnings for any 
employee in the Employee table.
Write a query to find the maximum 
total earnings for all employees 
as well as the total number of
employees who have maximum total 
earnings. Then print these values 
as 2 space-separated integers.*/
with t1 as
(select max(months*salary) as total_earnings
from Q104_Employee),

t2 as
(select count(employee_id) as total_employees
from Q104_Employee
join t1
on (Q104_Employee.months*Q104_Employee.salary) = t1.total_earnings)

select t1.total_earnings, t2.total_employees
from t1, t2;

-- Q108:
/*We define an employee's total 
earnings to be their monthly 
salary * months worked, and the
maximum total earnings to be the 
maximum total earnings for any 
employee in the Employee table.
Write a query to find the maximum 
total earnings for all employees 
as well as the total number of
employees who have maximum total 
earnings. Then print these values 
as 2 space-separated integers.*/































































































