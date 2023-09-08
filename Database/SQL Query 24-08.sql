use sakila;
show tables;
select *from city;
desc city;
select *from country;
select city.city,city.country_id,country.country from city inner join country on city.country_id=country.country_id limit 10;
select c.city,c.country_id,c1.country from city c inner join country c1 on c.country_id=c1.country_id limit 10;

create database hospital;
use hospital;
/*-- ----------create doctor table---------*/
create table doctor(
id int primary key auto_increment,name varchar(50) not null,degree varchar(30) not null,email varchar(50) not null);
desc doctor;
drop table doctor;

/*-- ----------create patient table---------*/
create table patient(
id int primary key auto_increment,name varchar(50) not null,email varchar(50),gender varchar(10),
phone_no varchar(15) not null unique,doctor_id int,
foreign key(doctor_id) references doctor(id) on delete cascade on update cascade,
created_on datetime,updated_on datetime  default current_timestamp on update current_timestamp);
drop table patient;
desc patient;

insert into doctor (name, degree, email) values
('Dr.Shubham M', 'MD', 'shubham.m@example.com'),
('Dr.Ashish P', 'MBBS', 'ashish.p@example.com'),
('Dr.Prathamesh D', 'PhD', 'prathamesh.d@example.com'),
('Dr.Harish M', 'DDS', 'harish.m@example.com'),
('Dr.Satyajeet K', 'MD', 'satyajeet.k@example.com'),
('Dr.Shreya B', 'BAMS', 'shreya.b@example.com'),
('Dr.Shweta J', 'BHMS', 'shweta.j@example.com'),
('Dr.Radha D', 'BDS', 'radha.d@example.com');
select * from doctor;
delete from doctor;

insert into patient (name, email, gender, phone_no, doctor_id, created_on, updated_on)
values
('Omkar P', 'omkarp@example.com', 'Male', '8698116839', 1, NOW(), default),
('Aditya A', 'adityaa@example.com', 'Male','7391548124', 5, NOW(), default),
('Rushi G', 'rushig@example.com', 'Male', '9423545212', 2, NOW(), default),
('Aditya Y', 'adityay@example.com', 'Male', '9856124546', 4, NOW(), default),
('Nikhil R', 'nikhilr@example.com', 'Male', '8080880612', 3, NOW(), default),
('Vaibhav K', 'vaibhavk@example.com', 'Male', '7066262332', 4, NOW(), default),
('Someshwar S', 'someshwars@example.com', 'Male', '8523458923', 5, NOW(), default),
('Bhagyashree P', 'bhagyashreep@example.com', 'Female', '7356482325', 6, NOW(), default),
('Vishakha R', 'vishakhar@example.com', 'Female', '8698562329', 7, NOW(), default),
('Shraddha C', 'shraddhac@example.com', 'Female', '7391456778', 8, NOW(), default);
select *from patient;
update patient set doctor_id=6 where id=10;
select p.name,p.email,p.gender,d.name from patient p inner join doctor d on p.doctor_id=d.id;
select p.name,p.email,p.gender,d.name from patient p left join doctor d on p.doctor_id=d.id;
select p.name,p.email,p.gender,d.name from patient p cross join doctor d;

select * from patient p left join doctor d on p.doctor_id=d.id   /*Here union is used to perfrom full join or outer join in mysql */
union
select * from patient p right join doctor d on p.doctor_id=d.id;

select degree ,count(degree) as total from doctor group by degree having total>1; /* Group by and having */
select *from patient where id<=any (select id from doctor where degree="BAMS" );  /*any operator*/

create table backup as   /* used to copy all table structure and data from that table*/
select *from patient;
select * from backup;
desc backup;

create table backup2 like patient;  /*used to create structure like another table structure*/
select *from backup2;
insert into backup2 select *from patient; /*used to copy data from another table*/