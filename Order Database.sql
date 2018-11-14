
/*
Consider the following schema for Order Database:
SALESMAN(Salesman_id, Name, City, Commission)
CUSTOMER(Customer_id, Cust_Name, City, Grade, Salesman_id)
ORDERS(Ord_No, Purchase_Amt, Ord_Date, Customer_id, Salesman_id)

Write SQL queries to
1. Count the customers with grades above Bangalore’s average.
2. Find the name and numbers of all salesman who had more than one customer.
3. List all the salesman and indicate those who have and don’t have customers in their cities (Use UNION operation.)
4. Create a view that finds the salesman who has the customer with the highest order of a day.
5. Demonstrate the DELETE operation by removing salesman with id 1000. All his orders must also be deleted
*/

create table salesman
(
	salesmanid varchar(10) not null,
	name varchar(20),
	city varchar(20) not null,
	commission varchar(5),
	primary key(salesmanid)
); 

create table customer
(
	customerid varchar(10) not null,
	custname varchar(20) not null,
	city varchar(20) not null,
	grade int,
	salesmanid varchar(10),
	primary key(customerid),
	foreign key(salesmanid) references salesman(salesmanid) on delete cascade
);

create table orders
(
	ordno varchar(10) not null,
	amount int not null,
	orddate date,
	customerid varchar(10),
	salesmanid varchar(10),
	primary key(ordno),
	foreign key(customerid) references customer(customerid) on delete cascade,
	foreign key(salesmanid) references salesman(salesmanid) on delete cascade
);

insert into salesman values('s1','Amir','Bangalore','10%');
insert into salesman values('s2','Daniel','Mysore','20%');
insert into salesman values('s3','Thomas','Mumbai','30%');
insert into salesman values('s4','Raghu','Pune','40%');
insert into salesman values('s5','Ram','Patna','50%');
insert into salesman values('s6','Raja','Goa','15%');
insert into salesman values('s7','Wadia','Lucknow','5%');

insert into customer values('c1','Athira','Bangalore',100,'s1');
insert into customer values('c2','Barkha','Mysore',200,'s2');
insert into customer values('c3','Tripthi','Mumbai',300,'s3');
insert into customer values('c4','Dia','Pune',400,'s4');
insert into customer values('c5','Deepu','Patna',500,'s5');
insert into customer values('c6','Eliza','Bangalore',100,'s1');
insert into customer values('c7','Clara','Bangalore',200,'s2');
insert into customer values('c8','Deena','Mysore',300,'s2');
insert into customer values('c9','Heena','Mumbai',400,'s3');
insert into customer values('c10','Prabhas','Mumbai',500,'s4');
insert into customer values('c11','Bala','Chennai',200,'s5');
insert into customer values('c12','chandra','Hyderabad',300,'s1');
insert into customer values('c13','Susan','Trivadurm',400,'s2');
insert into customer values('c14','priya','Goa',500,'s3');
insert into customer values('c15','Riya','Udupi',100,'s4');
insert into customer values('c16','Megha','Banaglore',100,'s5');

insert into orders values('o1',1000,'2017-08-01','c1','s1');
insert into orders values('o2',2000,'2017-08-02','c2','s2');
insert into orders values('o3',3000,'2017-08-03','c3','s3');
insert into orders values('o4',4000,'2017-08-04','c4','s4');
insert into orders values('o5',5000,'2017-08-05','c5','s5');
insert into orders values('o6',6000,'2017-08-01','c6','s1');
insert into orders values('o7',7000,'2017-08-06','c7','s2');
insert into orders values('o8',8000,'2017-08-06','c8','s3');
insert into orders values('o9',9000,'2017-08-07','c9','s4');
insert into orders values('o10',10000,'2013-08-08','c10','s5');
insert into orders values('o11',1500,'2017-08-01','c11','s1');
insert into orders values('o12',2500,'2017-06-01','c12','s2');
insert into orders values('o13',3500,'2017-03-01','c13','s3');
insert into orders values('o14',4500,'2017-02-01','c14','s4');
insert into orders values('o15',5500,'2017-01-01','c15','s5');
insert into orders values('o16',6500,'2017-05-01','c16','s6');



/**
--question 1 
select count(customerid) from customer where grade > ( select avg(grade) from customer where city='Bangalore' );



--question 2
select s.name , s.salesmanid , count(*)  from customer c , salesman s where s.salesmanid=c.salesmanid  group by c.salesmanid , s.name having count(*) > 1;



-- question 3 

select distinct s.salesmanid from salesman s , customer c where s.city = c.city and c.salesmanid=s.salesmanid
union 
select distinct s.salesmanid from salesman s , customer c where s.city != c.city  and c.salesmanid=s.salesmanid;



--queston 4 --> Create a view that finds the salesman who has the customer with the highestorder of a day.
create view v10 as select b.orddate , a.salesmanid , a.name , b.customerid from salesman  a , orders b where a.salesmanid = b.salesmanid and b.amount = (select max(amount) from orders c where c.orddate = b.orddate);
select * from v10;


--queston 5 -->>>>  delete query 
delete from salesman where salesmanid = "s6" ; 
-- check the order table and check whether  all orders belong to s6 were deleted  

**/