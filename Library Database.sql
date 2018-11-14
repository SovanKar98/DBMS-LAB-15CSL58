
/*
Consider the following schema for a Library Database:
BOOK(Book_id, Title, Publisher_Name, Pub_Year)
BOOK_AUTHORS(Book_id, Author_Name)
PUBLISHER(Name, Address, Phone)
BOOK_COPIES(Book_id, Branch_id, No-of_Copies)
BOOK_LENDING(Book_id, Branch_id, Card_No, Date_Out, Due_Date)
LIBRARY_BRANCH(Branch_id, Branch_Name, Address)
Write SQL queries to
1. Retrieve details of all books in the library – id, title, name of publisher,
authors, number of copies in each branch, etc.
2. Get the particulars of borrowers who have borrowed more than 3 books, but
from Jan 2017 to Jun 2017.
3. Delete a book in BOOK table. Update the contents of other tables to reflect
this data manipulation operation.
4. Partition the BOOK table based on year of publication. Demonstrate its
working with a simple query.
5. Create a view of all books and its number of copies that are currently
available in the Library.

*/

create table publisher
(
 name varchar(30),
 address varchar(30) not null,
 phone varchar(12),
 primary key(name)
);

create table book
(
 bookid int not null,
 title varchar(20),
 name varchar(20) ,
 pubyear int,
 primary key(bookid,name),
 foreign key(name) references publisher(name) on delete cascade
);

create table authors
(
 bookid int ,
 name varchar(30),
 primary key(bookid),
 foreign key(bookid) references book(bookid) on delete cascade
);

create table branch
(
 branchid int,
 branchname varchar(20) ,
 address varchar(200),
 primary key(branchid)
);

create table borrower
(
 cardno int,
 name varchar(20),
 primary key(cardno)
);

create table lending
(
 bookid int  ,
 branchid int ,
 cardno int,
 dateout date,
 duedate date ,
 primary key(bookid,branchid,cardno),
 foreign key(bookid) references book(bookid) on delete cascade,
 foreign key(branchid) references branch(branchid) on delete cascade,
 foreign key(cardno) references borrower(cardno) on delete cascade
);

create table bookcopies
(
 bookid int ,
 branchid int  ,
 noofcopies int  ,
 primary key(bookid,branchid),
 foreign key(bookid) references book(bookid) on delete cascade,
 foreign key(branchid) references branch(branchid) on delete cascade

);





-- Some dump data to demonstrate the concept and execute the sql queries

insert into publisher values("ali","banglore","77002299");
insert into publisher values("ahmed","pune","770022549");
insert into publisher values("ammar","mumbai","77002199");
insert into publisher values("saleh","sanaa","77002229");
insert into publisher values("yaser","thamar","77202299");
insert into publisher values("omar","aden","77002299");
insert into publisher values("ayaan","us","77002299");




insert into book values (1,"learn html","ali",2012);
insert into book values (2,"learn java","ali",2005);
insert into book values (3,"learn python","ali",2016);
insert into book values (4,"learn anythin","ali",2010);
insert into book values (5,"c#","ali",2011);
insert into book values (6,"linux","ali",2017);


insert into authors values (1,"ali");
insert into authors values (2,"ali");
insert into authors values (3,"ali");
insert into authors values (4,"ali");
insert into authors values (5,"ali");
insert into authors values (6,"ali");





insert into branch values (1,"hkbk","banglore");
insert into branch values (2,"mit","germany");
insert into branch values (3,"lcc","us");
insert into branch values (4,"ppm","mysor");
insert into branch values (5,"kns","mumbai");




insert into borrower values (1,"ahmed");
insert into borrower values (2,"sleh");
insert into borrower values (3,"ammar");
insert into borrower values (4,"khaled");
insert into borrower values (5,"sammer");


insert into lending values (1,1,1,"2017-08-01","2017-08-010");
insert into lending values (2,1,1,"2017-08-01","2017-08-010");
insert into lending values (3,1,1,"2017-08-01","2017-02-010");
insert into lending values (2,2,1,"2017-02-01","2017-08-010");
insert into lending values (4,1,1,"2017-08-01","2017-06-010");
insert into lending values (3,1,2,"2017-01-01","2017-08-010");
insert into lending values (1,1,3,"2017-01-01","2017-08-010");
insert into lending values (1,2,1,"2017-04-01","2017-04-010");
insert into lending values (3,1,4,"2017-08-01","2017-08-010");
insert into lending values (3,2,3,"2017-04-01","2017-03-010");
insert into lending values (4,2,3,"2017-05-01","2017-08-010");
insert into lending values (5,2,3,"2017-01-01","2017-05-010");
insert into lending values (6,1,4,"2017-01-01","2017-07-010");
insert into lending values (3,1,4,"2017-02-01","2017-08-010");
insert into lending values (4,1,4,"2017-03-01","2017-08-010");
insert into lending values (5,1,4,"2017-04-01","2017-08-010");
insert into lending values (6,2,2,"2017-04-01","2017-08-010");
insert into lending values (4,4,2,"2017-01-01","2017-08-010");
insert into lending values (3,1,2,"2017-01-01","2017-08-020");
insert into lending values (2,1,2,"2017-02-01","2017-08-010");
insert into lending values (5,1,2,"2017-03-01","2017-08-010");
insert into lending values (6,3,2,"2017-01-01","2017-08-010");
insert into lending values (2,4,4,"2017-04-01","2017-08-010");
insert into lending values (5,1,4,"2017-01-01","2017-08-010");
insert into lending values (6,3,4,"2017-01-01","2017-08-010");
insert into lending values (2,4,6,"2017-01-01","2017-08-010");





insert into bookcopies values (1,1,2);
insert into bookcopies values (2,2,2);
insert into bookcopies values (3,3,2);
insert into bookcopies values (4,4,2);
insert into bookcopies values (5,5,2);
insert into bookcopies values (6,1,2);
insert into bookcopies values (1,3,2);
insert into bookcopies values (1,5,2);
insert into bookcopies values (5,1,2);
insert into bookcopies values (4,1,2);



/*

Retrieve details of all books in the library – id, title, name of publisher,
authors, number of copies in each branch, etc.


SELECT 
    book.bookid,
    book.title,
    book.name,
    bookcopies.noofcopies,
    authors.name AS 'author name'
FROM
    book,
    bookcopies,
    authors
WHERE
    book.bookid = authors.bookid
        AND bookcopies.bookid = book.bookid;
;





Get the particulars of borrowers who have borrowed more than 3 books, but
from Jan 2017 to Jun 2017.


SELECT 
    lending.cardno, name, COUNT(*)
FROM
    lending ,
    borrower
WHERE
    dateout BETWEEN '2017-01-01' AND '2017-06-30'
        AND lending.cardno = borrower.cardno
GROUP BY lending.cardno
HAVING COUNT(*) > 3;




Delete a book in BOOK table. Update the contents of other tables to reflect
this data manipulation operation.





DELETE FROM book 
WHERE
    bookid = 1;


SELECT 
    *
FROM
    lending;






Partition the BOOK table based on year of publication. Demonstrate its working
with a simple query.




select * from book where Pub_Year = '2012';






 Create a view of all books and its number of copies that are currently available in
the Library



 
CREATE VIEW noofcopiesview AS
    SELECT 
        book.title, SUM(bookcopies.noofcopies)
    FROM
        book,
        bookcopies,
        authors
    WHERE
        book.bookid = bookcopies.bookid
    GROUP BY book.bookid;


select * from noofcopiesview ; 


*/