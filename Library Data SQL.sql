create database SQL_Project2_Library_Management

select * from [dbo].[books]  

select * from [dbo].[employees]

select * from [dbo].[issued_status]

select * from [dbo].[members]

select * from [dbo].[return_status]

select * from [dbo].[branch]

alter table [dbo].[books]
ADD CONSTRAINT PK_books PRIMARY KEY (isbn)

alter table [dbo].[employees]
ADD CONSTRAINT PK_Employees PRIMARY KEY (emp_id);

ALTER TABLE [dbo].[branch]
ADD CONSTRAINT PK_branch PRIMARY KEY (branch_id);

ALTER TABLE [dbo].[members]
ADD CONSTRAINT PK_Members PRIMARY KEY (member_id)

ALTER TABLE [dbo].[return_status]
ADD CONSTRAINT PK_return_status PRIMARY KEY (return_id)

ALTER TABLE [dbo].[issued_status]
ADD CONSTRAINT PK_issued_status PRIMARY KEY (issued_id)

alter table issued_status
add constraint fk_members
foreign key(issued_member_id)
references members(member_id)

alter table issued_status
add constraint fk_books
foreign key(issued_book_isbn)
references books(isbn)

alter table issued_status
add constraint fk_employees
foreign key(issued_emp_id)
references employees(emp_id)

alter table employees
add constraint fk_branch
foreign key(branch_id)
references branch(branch_id)

'''alter table [dbo].[return_status]
add constraint fk_issued_status
foreign key(issued_id)
references issued_status(issued_id)'''


--*CURD Operation*
--Q1. create new book record i.e ("978-1-60129-456-2", "To Kill a Mokingbird"
--"Classic", 6.00, 1 , 'Harper Lee', 'J.B. Lippincott & Co.' )
select * from [dbo].[books]

-- I got an error here as rental price have time datatype so we need to convert this into decimal or int

ALTER TABLE books
ALTER COLUMN rental_price DECIMAL(5,2);

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'books';

insert into 
books
	(
	isbn,
	book_title,
	category,
	rental_price, 
	status , 
	author , 
	publisher
	)
values
	(
	'978-1-60129-456-2', 
	'To Kill a Mokingbird',
	'Classic', 
	'06:00:00.000', 
	1, 
	'Harper Lee', 
	'J.B. Lippincott & Co.' 
	)

--Q2. Update an existing members address 
select * from [dbo].[members]

update members
set member_address = '123 oak st'
where member_id = 'C103';

--Q3. Delete a record from the issued status where issued_id = 'IS106	'
select * from issued_status

Delete from issued_status
where issued_id = 'IS106'

--Q4 . Retrive all books issued by specific employee 104.00
select * from issued_status

select * from issued_status 
where  issued_emp_id = 104

--Q5. List Employee who have issued more than one book

select issued_emp_id, COUNT(issued_id) as [no_of books]
from issued_status
group by issued_emp_id
having COUNT(issued_id) > 1 

--CTAS (Create table as select)
--create summary tables : use CTAS to generate new table based on query result
--each book and total book issued count

select 
	b.isbn,
	COUNT(ist.issued_id) as [no_of_issue]
into Book_count
from
books as b 
join
issued_status as ist
on
ist.issued_book_isbn = b.isbn
group by b.isbn


select * from Book_count


--Data Analysis Tasks
--Q1. Retrive All books from 'classic ' category
select * 
from books
where category = 'Classic '

--Q2.List members who registered  in the past 180 days
select * from  members
where reg_date >=  DATEADD(DAY, -180, GETDATE())


--Q3. List Employee with thier Branch manager's name and thier branch details
select 
	e1.emp_id,
	e1.emp_name,
	e1.position,
	b.*,
	e2.emp_name as [manager_name]
from
employees as e1
join
branch as b
on e1.branch_id = b.branch_id
join
employees as e2
on e2.emp_id = b.manager_id

--Q4. Retrive the list of books not yet returned

select *
from
issued_status as ist
left join
return_status as rst
on ist.issued_id=rst.issued_id
where return_id is null

--Q5. Identify members with overdue books
/* Write a SQL Query to  identify members with overdue books(assume  a 30 day return peroid) . */
select 
	ist.issued_member_id,
	m.member_name,
	b.book_title,
	ist.issued_date,
	rst.return_date,
	DATEDIFF(DAY, ist.issued_date, GETDATE()) as [overdue_days]
from 
issued_status as ist
join
members as m
on ist.issued_member_id = m.member_id
join
books as b
on b.isbn = ist.issued_book_isbn
left join
return_status as rst
on rst.issued_id=ist.issued_id
where
	rst.return_date is null
	and 
	DATEDIFF(DAY, ist.issued_date, GETDATE()) >=30

/*
Q6. Update book status on return
Write a query to update the status of books in the book table to 'Yes(1)' when they are returned
(based on entries in the return status table)
*/
Select * from  issued_status
where  issued_book_isbn ='978-0-451-52994-2'

select * from books
where isbn='978-0-451-52994-2'

update books
set status=0
where isbn='978-0-451-52994-2'

select *  from return_status
where issued_id='IS130'

--------BY Using Store Procedure-------------
create procedure updatereturnbookStatus
as
begin
	update b
	set b.status=1
	from books as b
	inner join
	return_status as rst
	on b.isbn=rst.return_book_isbn
	where b.status=0
end;

exec updatereturnbookStatus

--Q7. Identify  the most issued  book Category
select * from books
select * from issued_status

select 
	b.category,
	count(ist.issued_id) as [issued_count ]
from 
	issued_status as ist 
join 
	books as b
on
	ist.issued_book_isbn = b.isbn
group by b.category
order by [issued_count] desc

--Q8. Find branches with highest book circulation


select
	b.branch_id,
	COUNT(ist.issued_id) as [total_issued_books]
from
	issued_status as ist 
join
	employees as e
on 
	ist.issued_emp_id = e.emp_id
join
	branch as b
on  e.branch_id= b.branch_id
group by b.branch_id
order by total_issued_books desc


--Q9. Top 3  members with most book issues
select
	ist.issued_member_id,
	m.member_id,
	COUNT(ist.issued_id) as [total_issued_book]
from
	issued_status as ist
join
	members as m
on
	ist.issued_member_id = m.member_id
group by ist.issued_member_id , m.member_id
order by total_issued_book desc

--Q10. Monthly trend of book issued
select
	FORMAT(issued_date, 'yyyy-MM') as [Month],
	COUNT(issued_id) as [monthly_issued_book]
from issued_status 
group by FORMAT(issued_date, 'yyyy-MM')
order by FORMAT(issued_date, 'yyyy-MM')

--Q11. Avg return time for each category
select
	b.category,
	avg(DATEDIFF(DAY, ist.issued_date,rst.return_date)) as [avg_reutrn_time]

from
	issued_status as ist
join
	return_status as rst
on
	ist.issued_id = rst.issued_id
join
	books as b
on 
	ist.issued_book_isbn = b.isbn
group by b.category
order by avg_reutrn_time

--Q12. Determine how many books of each category are being  utilized compared to total books available

select 
	b.category,
	COUNT(distinct ist.issued_book_isbn) as [issued_books],
	COUNT(*) as [total_books],
	cast(COUNT(distinct ist.issued_book_isbn) * 100 / count(*) as decimal(5,2)) as [utilized_books]

from
	books as b
left join
	issued_status as ist
on
	b.isbn = ist.issued_book_isbn
group by b.category

--Q13. Members who  never borrowed  a book
select * from branch
select * from books
select * from issued_status
select * from employees
select * from members
select * from return_status

select
	m.member_id,
	m.member_name,
	COUNT(ist.issued_id) as [total_issed_books]
from
	members as m
left join
	issued_status as ist
on
	m.member_id = ist.issued_member_id
where ist.issued_member_id is null
group by m.member_id, m.member_name

--Q14. identify employee who haven't issued any book
select
	e.emp_id,
	e.emp_name
from
	employees as e
left join
	issued_status as ist
on
	e.emp_id = ist.issued_emp_id
where ist.issued_id is null

--Q15. Total fine collected on overdue 
select
	SUM(
	case
		when DATEDIFF(DAY, ist.issued_date, rst.return_date) > 30
		then (DATEDIFF(DAY, ist.issued_date, rst.return_date) - 30 ) * 2
		else 0
	end) as [total_fine_collected]
from
	issued_status as ist
join
	return_status as rst
on
	ist.issued_id = rst.issued_id




	
	




