CREATE DATABASE Bank;

use Bank;
--Customer Personal Information
create table Customer(customer_id int identity(1,1), 
					  customer_name nvarchar(50), 
					  dob date, 
					  contact_no nvarchar(10), 
					  gender char(6), 
					  city varchar(20),
					  mail_id nvarchar(50), 
					  primary key (customer_id));
select * from Customer;

--Branch information
create table Branch(ifsc_code varchar(15),
					brname nvarchar(30),
					brcity nvarchar(30),
					primary key(ifsc_code));
select * from Branch;

--Account Information
create table Account(acc_no  int, 
				     customer_id int,
					 ifsc_code varchar(15),
					 total_bal int,
					 acc_type nvarchar(15),
					 acc_opening_date date,
					 primary key (acc_no), 
					 foreign key (customer_id) references Customer(customer_id),
					 foreign key (ifsc_code) references Branch(ifsc_code));
select * from Account;

--Loan Information
create table Loan(loan_id int,
				  customer_id int,
				  ifsc_code varchar(15),
				  loan_amt int,
				  loan_issued date, 
				  loan_due date,
				  primary key(loan_id),
				  foreign key (customer_id) references Customer(customer_id),
				  foreign key (ifsc_code) references Branch(ifsc_code));
select * from Loan;


--Insert Values 
insert into Customer(customer_name, dob, contact_no, gender, city, mail_id)
values('SAHIL', '1996-09-04', '9876543210', 'M', 'Mumbai', 'SAHIL@GMAIL.COM'),
      ('DHONI', '1986-05-28','9887543210','M', 'Delhi', 'DHONI@GMAIL.COM'),
      ('SANJAY', '1991-07-16','9884112210','M', 'Mumbai', 'SANJAY@GMAIL.COM'),
      ('MURLI', '1989-03-23','9876482414', 'M', 'Kolkata', 'MURLI@GMAIL.COM'),
      ('HARPREET', '1996-10-31', '9865327410', 'M', 'Pune', 'HARPREET@GMAIL.COM');
select * from Customer;

insert into Branch(ifsc_code, brname, brcity)
values('SBIN0000353', 'Dadar', 'Mumbai'),
('SBIN0014914', 'Kalina', 'Mumbai'),
('SBIN0000737', 'Paharganj', 'Delhi'),
('SBIN0001722', 'Kalighat', 'Kolkata'),
('SBIN0070876', 'Pimpri', 'Pune');

insert into Account(acc_no, customer_id, ifsc_code, total_bal,acc_type, acc_opening_date)
values(1001, 1,'SBIN0000353','1000','Saving','2012-12-15'),
      (1002, 2,'SBIN0070876','5000','Saving','2012-06-12'),
      (1003, 3,'SBIN0000737','3000','Saving','2012-05-17'),
      (1004, 4,'SBIN0000353','2500','Saving','2013-05-04'),
      (1005, 5,'SBIN0070876','1000','Saving','2013-04-23');


insert into Loan(loan_id, customer_id, ifsc_code, loan_amt, loan_issued, loan_due)
values(111, 1, 'SBIN0000353', 10000, '2015-10-05', '2016-10-05'),
(112, 4, 'SBIN0001722', 15000, '2014-06-25', '2015-12-25'),
(113, 1, 'SBIN0014914', 20000, '2017-03-05', '2019-03-05'),
(114, 3, 'SBIN0014914', 12000, '2013-08-10', '2014-11-11'),
(115, 5, 'SBIN0070876', 25000, '2016-02-15', '2018-02-15');

select * from Customer;
select * from Branch;
select * from Account;
select * from Loan;


--Mathematical & Aggregate functions
Select ABS (-10.8) --returns without the sign
Select CEILING (10.2) -- returns integer value greater than the parameter
Select CEILING (-10.2) 

Select FLOOR (10.2) --returns integer value greater than the parameter
Select FLOOR (-10.2) 

Select POWER (3,3) 
Select SQUARE (10) 
Select SQRT (64) 
Select RAND (1) --Always returns the same value
Select FLOOR (RAND () * 100)

Declare @Counter INT
Set @Counter = 1
While (@Counter <= 10)
Begin
	Print FLOOR (RAND() * 100)
	Set @Counter = @Counter + 1
End



--Round to 2 places after (to the right) the decimal point 
Select ROUND (850.556, 2)


SELECT MAX(loan_amt) AS Hihgest_loan_given FROM Loan; -- highest loan amt
SELECT SUM(loan_amt) AS Total_Loan_Dispatched FROM Loan ; --total loan amount given by bank
SELECT COUNT(loan_amt) FROM Loan;

--Order By clause
SELECT * FROM Customer ORDER BY customer_name ASC; --ascending order in name form
SELECT * FROM Account ORDER BY acc_opening_date ASC; --account opening date wise


----Bonus Information
create table Bonus(employee_id int identity, 
				     first_name varchar(15),
					 last_name varchar(15),
					 position varchar(50),
					 outlet int,
					 region varchar(10),
					 bonus float);

INSERT INTO Bonus(first_name, last_name, position, outlet, region, bonus) 
VALUES
('Max', 'Black', 'manager', 123, 'South', 2305.45),
('Jane', 'Wolf', 'cashier',	123, 'South', 1215.35),
('Kate', 'White', 'customer service specialist', 123, 'South', 1545.75),
('Andrew', 'Smart', 'customer service specialist', 123, 'South',	1800.55),
('John', 'Ruder', 'manager', 105, 'South', 2549.45),
('Sebastian', 'Cornell', 'cashier', 105,	'South', 1505.25),
('Diana', 'Johnson', 'customer service specialist', 105, 'South', 2007.95),
('Sofia', 'Blanc', 'manager', 224, 'North', 2469.75),
('Jack', 'Spider', 'customer service specialist', 224, 'North', 2100.50),
('Maria', 'Le', 'cashier', 224, 'North', 1325.65),
('Anna', 'Winfrey',	'manager', 211, 'North', 2390.25),
('Marion', 'Spencer', 'cashier', 211, 'North', 1425.25);

SELECT * FROM Bonus;

--CTE
WITH avg_position AS 
(
	SELECT position, AVG(bonus) AS avg_bonus
	FROM Bonus
	GROUP BY position
)
SELECT b.employee_id, b.first_name, b.last_name, b.position, b.bonus, ap.avg_bonus
FROM Bonus b
JOIN avg_position ap
ON b.position = ap.position
ORDER BY b.position;


--multiple CTE
WITH avg_position AS 
(
	SELECT position, AVG(bonus) AS avg_bonus_position
	FROM Bonus
	GROUP BY position
), avg_region AS 
(
	SELECT region, AVG(bonus) AS avg_bonus_region
	FROM Bonus
	GROUP BY region
)
SELECT b.employee_id, b.first_name, b.last_name, b.position, b.region, b.bonus, ap.avg_bonus_position, ar.avg_bonus_region
FROM Bonus b
JOIN avg_position ap
ON b.position = ap.position
JOIN avg_region ar
ON b.region = ar.region;