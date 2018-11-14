/*
Consider the schema for Movie Database:
ACTOR(Act_id, Act_Name, Act_Gender)
DIRECTOR(Dir_id, Dir_Name, Dir_Phone)
MOVIES(Mov_id, Mov_Title, Mov_Year, Mov_Lang, Dir_id)
MOVIE_CAST(Act_id, Mov_id, Role)
RATING(Mov_id, Rev_Stars)
Write SQL queries to
1. List the titles of all movies directed by ‘Hitchcock’.
2. Find the movie names where one or more actors acted in two or more movies.
3. List all actors who acted in a movie before 2000 and also in a movie after
2015 (use JOIN operation).
4. Find the title of movies and number of stars for each movie that has at least
one rating and find the highest number of stars that movie received. Sort the
result by movie title.
5. Update rating of all movies directed by ‘Steven Spielberg’ to 5 

*/

create table actor
(
 act_id int,
 act_name varchar(25) ,
 act_gender char(1),
 primary key(act_id)
);

create table director
(
 dir_id int ,
 dir_name varchar(25) ,
 dir_phone int ,
 primary key(dir_id)
);

create table movies
(
 mov_id int,
 mov_title varchar(50),
 mov_year int not null,
 mov_lang varchar(15),
 dir_id int ,
 primary key (mov_id),
 foreign key (dir_id) references director(dir_id) on delete cascade
);

create table movie_cast
(
 act_id INT ,
 mov_id int,
 role varchar(45) ,
 primary key(act_id,mov_Id),
 foreign key (act_id) references actor(act_id) on delete cascade,
 foreign key (mov_id) references movies(mov_id) on delete cascade
);

create table rating
(
 mov_id int not null,
 rev_stars int not null,
 primary key (mov_id),
 foreign key (mov_id) references movies(mov_id) on delete cascade
);

insert into actor values('101','James','M');
insert into actor values('102','Deborah','F'); 
insert into actor values('103','Peter','M'); 
insert into actor values('104','Robert','M'); 
insert into actor values('105','Murray','M');
insert into actor values('106','Harrison','M');
insert into actor values('107','Nicole','F');
insert into actor values('108','Stephen','M'); 
insert into actor values('109','Jack','M');
insert into actor values('110','Kate','F');

insert into director values('201','Alfred','675409');
insert into director values('202','Jack','689543');
insert into director values('203','David','660908');
insert into director values('204','Michael','656432');
insert into director values('205','Milos','600944');
insert into director values('206','Stanley','677543');
insert into director values('207','Roman','660089');

insert into movies values('1','Vertigo','1994','English','201');
insert into movies values('2','Innocents','1997','English','201');
insert into movies values('3','Deer Hunter','1972','English','202');
insert into movies values('4','Eyes Wid Shut','2002','English','202');
insert into movies values('5','Wings','2016','English','203');
insert into movies values('6','Usual Suspects','2006','English','204');
insert into movies values('7','Samurai','2017','English','205');
insert into movies values('8','The Prestige','2016','English','206');
insert into movies values('9','American Beauty','2015','English','201');
insert into movies values('10','Walls','2000','English','207');

insert into movie_cast values('101','1','James');
insert into movie_cast values('101','6','Fero');
insert into movie_cast values('101','2','Eddie');
insert into movie_cast values('102','5','July');
insert into movie_cast values('103','3','John');
insert into movie_cast values('104','7','Adam');
insert into movie_cast values('105','8','Manus');
insert into movie_cast values('106','1','Rick');
insert into movie_cast values('107','8','Rose');
insert into movie_cast values('107','9','Sam');
insert into movie_cast values('108','1','Rock');
insert into movie_cast values('108','5','Bobby');
insert into movie_cast values('109','10','Ed');
insert into movie_cast values('110','4','Cathie');

insert into rating values('1','3');
insert into rating values('2','3');
insert into rating values('3','2');
insert into rating values('4','5');
insert into rating values('5','4');
insert into rating values('6','3');
insert into rating values('7','2');
insert into rating values('8','1');
insert into rating values('9','5');
insert into rating values('10','4');



/*

Query1 -- List the movies directed by Alfred
select mov_title from movies m,director d where d.dir_id=m.dir_id and dir_name="Alfred";
+-----------------+
| mov_title       |
+-----------------+
| Vertigo         |
| Innocents       |
| American Beauty |
+-----------------+

Query2 -- List the movie titles in which more than 2 actors have acted with more than 2 movies
select mov_title from movies where mov_id in(select mov_id from movie_cast where act_id in(select act_id from movie_cast group by act_id having count(*)>1));
+-----------------+
| mov_title       |
+-----------------+
| Vertigo         |
| Innocents       |
| Wings           |
| Usual Suspects  |
| The Prestige    |
| American Beauty |
+-----------------+

Query3 -- List the actors who have acted before 2000 and after 2015 using join operation
select act_name from actor where act_id in(select A.act_id from(select act_id from movie_cast join movies on movie_cast.mov_id=movies.mov_id where mov_year<2000)A,(select act_id from movie_cast join movies on movie_cast.mov_id=movies.mov_id where mov_year>2015)B where A.act_id=B.act_id);
+----------+
| act_name |
+----------+
| Stephen  |
+----------+

Query4 -- find the title of the movies and number of stars for each movie that has at least one rating and find the highest number of stars that the movie received , sort the result by movie title 
select mov_title,rev_stars from movies m,rating r where m.mov_id=r.mov_id order by mov_title;
+-----------------+-----------+
| mov_title       | rev_stars |
+-----------------+-----------+
| American Beauty |         5 |
| Deer Hunter     |         2 |
| Eyes Wid Shut   |         5 |
| Innocents       |         3 |
| Samurai         |         2 |
| The Prestige    |         1 |
| Usual Suspects  |         5 |
| Vertigo         |         3 |
| Walls           |         4 |
| Wings           |         4 |
+-----------------+-----------+

Query5 -- update the rating of all movies directed by michael to five 
update rating set rev_stars=5 where mov_id in (select m.mov_id from movies m,director d where m.dir_id=d.dir_id and dir_name='Michael');
select * from rating;
+--------+-----------+
| mov_id | rev_stars |
+--------+-----------+
|      1 |         3 |
|      2 |         3 |
|      3 |         2 |
|      4 |         5 |
|      5 |         4 |
|      6 |         5 |
|      7 |         2 |
|      8 |         1 |
|      9 |         5 |
|     10 |         4 |
+--------+-----------+



*/


