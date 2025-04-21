CREATE database SalesDB: --used to create a database
Drop database SalesDB: --used to drop a database

--week2 challenge

create database MovieDB: --used to create a database called MovieDB
use MovieDB: --used to select the database MovieDB
create table Movies --used to create a table called Movie
(
    MovieID int not null primary key,
    Title varchar(50) not null,
    ReleaseYear int not null;

);

insert into
    Movies(MovieID, Title, ReleaseYear)
values
(1, 'The Shawshank Redemption', 1994),
    --used to insert a record into the Movies table
    (2, 'The Godfather', 1972),
    --used to insert a record into the Movies table
    (3, 'The Dark Knight', 2008),
    --used to insert a record into the Movies table
    (4, 'Pulp Fiction', 1994);

--used to insert a record into the Movies table
create table Actors (
    ActorID int not null primary key,
    Actorname varchar(50) not null,
    age int not null;

);

insert into
    Actors(ActorID, Actorname, age)
values
(1, 'Morgan Freeman', 86),
    --used to insert a record into the Actors table
(2, 'Marlon Brando', 80),
    --used to insert a record into the Actors table
(3, 'Christian Bale', 49),
    --used to insert a record into the Actors table
(4, 'John Travolta', 69);



-- used to select check number, payment date, and amount from the payments table
select CheckNumber, paymentDate, Amount 
from payments;

-- used to select the check number, payment date, and amount from the payments table
select OrderDate, RequiredDate, status
from orders
where status = "In Process"
order by OrderDate desc;

-- used to select the first name, last name, and email of employees with the job title 'Sales Rep' in descending order of employee number
SELECT firstName, lastName, email
FROM employees
WHERE jobTitle = 'Sales Rep'
ORDER BY employeeNumber DESC;


-- Week 3 Challenge
create table students (
    Studid int not null primary key,
    StudName varchar(100) not null,
    Studage int not null,
    gender varchar(10) not null;

);

insert into
    students(Studid, StudName, Studage, gender)
Values
(1, "John Doe", 23, "Male"),
    (2, "Jane Smith", 24, "Female"),
    (3, "Sam Brown", 24, "Male");

Update students
set Studage = 25
where Studid = 2; --used to update the age of the student with ID 1 to 25

-- Week 4 Challenge
select
    paymentDate,
    SUM(Amount) as total_amount
from
    payments
group by
    paymentDate
order by
    paymentDate desc
Limit
    5; --used to limit the number of records returned by the query to 5


select
    CustomerName,
    country,
    Avg(credit_limit) as average_credit_limit
from
    customers
group by CustomerName, country;


select
    Productcode,
    quantityOrderdered,
   sum(priceEach * quantityOrderdered) as total_price
from orderdetails
group by Productcode, quantityOrdered;


select
    check_number,
    max(check_number) as max_check_number
from payments
group by check_number;