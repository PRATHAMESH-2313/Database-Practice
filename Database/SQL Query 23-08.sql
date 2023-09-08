create database geekyworks;
use geekyworks;
create table employee(eid int primary key auto_increment,ename varchar(50) not null,edpt varchar(50) not null, esal int not null);
desc employee;
insert into employee(ename,edpt,esal) values("prathamesh","electrical",15000);
select *from employee;

create table emp(eid int,ename varchar(50) ,edpt varchar(50) , esal int);
insert into emp select * from employee;  /*this statement used to copy one table to another*/
select *from emp;
select *from employee limit 2 offset 3;

use sakila;
select * from city;
select * from city where not country_id=44;
select * from city order by city_id limit 10;
select max(country_id) as max_country from city;
select count(*) from city;
select sum(country_id) from city;
select * from city where city like "%a";
select * from city where city in("Ahmadnagar","aden","adoni");
select * from city where country_id between 1 and 50 order by country_id asc;
select count(*) as row_count from film;
select * from film;
select * from film where title like "%rs";
select * from film where film_id<=( select count(film_id)/2 from film);

select * from actor;
update actor set first_name="prathamesh",last_name="dabhole" where actor_id=1;


delete from employee where ename="vinayak";


