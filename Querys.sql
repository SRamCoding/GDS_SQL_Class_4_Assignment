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
