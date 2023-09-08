create database opd;
use opd;
desc doctor;
desc patient;
show tables;
desc appointment;
alter table appoinment rename to appointment;
select * from doctor;
select *from patient;
select * from appointment;
truncate table appointment;

-- Queries --

-- fetch higest cosulting fees doctor --
select max(fees) as highest from doctor;

 -- fetch second highest consulting fees doctor --
select max(fees) as SecondHighest from doctor where fees < (select max(fees) from doctor);


-- create procedure to insert data into appointment --
delimiter &&
create procedure create_appointment(IN bp varchar(10),IN weight int,IN disease varchar(100),IN nextvisit date,IN did int,IN pid int)
begin
insert into appointment(blood_pressure,weight,disease,followup,doctor_id,patient_id) values (bp,weight,disease,nextvisit,did,pid);
end &&
delimiter ;
call create_appointment("102/80mmHg",75,"headache","2023-09-10",3,20);

-- create trigger after insert --
create trigger update_earning_after_appointment
after insert on appointment
for each row
update doctor set total_earning=total_earning+fees where doctor.id=new.doctor_id;
drop trigger update_earning_after_appointment;

-- create trigger after delete --
create trigger delete_earning_after_appointment
after delete on appointment
for each row
update doctor set total_earning=total_earning-fees where doctor.id=old.doctor_id;

insert into appointment(id,blood_pressure,weight,disease,visit_date,next_appointment,doctor_id,patient_id) 
values (19,"117/65mmHg",70,"cold","2023-08-22","2023-09-09",2,15);

update appointment set id=7 where id=8;
delete from appointment where id=5;

-- Fetch total patient for each doctor they consulted --
select d.name as doctor_name,count(a.patient_id) as total_patient 
from appointment a inner join doctor d 
on a.doctor_id=d.id group by doctor_id ;

-- Fetch higest earning doctor --,
select max(total_earning) as highest_earning from doctor;

-- Select patient name with number of time they consulted to doctors --
select p.id as patient_id,p.name,count(a.patient_id) as no_of_times 
from patient p inner join appointment a 
on p.id=a.patient_id group by patient_id;

-- Select patient name with number of time they consulted to individual doctors --
select p.name as patient_name,d.name as doctor_name,count(p.id) as time_of_visit from 
patient p join appointment a on p.id=a.patient_id 
join doctor d on d.id=a.doctor_id  group by p.id,d.id;

-- create stored procedure to display patient above age 40 --
delimiter //
create procedure display_patient(IN newage int)
begin 
select * from patient where age>newage;
end //
delimiter ;
drop procedure display_patient; 
call display_patient(40);

-- select day wise earning for all doctors --
-- select doctor name and total consulted paitent day wise --
select a.visit_date as day ,d.name as doctor_name,count(patient_id) as total_patient_on_that_day,d.fees*count(patient_id) as total_earing_daywise 
from appointment a inner join doctor d on a.doctor_id=d.id group by doctor_id,day order by day asc;

-- Store procedure to display doctor name patient name for a given date --
delimiter //
create procedure display_on_date(IN newdate date)
begin
select a.visit_date as date,d.name as doctor_name,p.name as patient_name from 
doctor d join appointment a on d.id=a.doctor_id join patient p on p.id=a.patient_id where visit_date=newdate;
end //
delimiter ;
drop procedure display_on_date;
call display_on_date("2023-08-30");





