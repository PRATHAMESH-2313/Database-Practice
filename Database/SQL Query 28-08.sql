use hospital;
show tables;
alter table doctor add column totalhours int not null;
alter table doctor add column salary int not null;
update doctor set totalhours=125 where id=8;
update doctor set salary=totalhours*200;

-- 1) create trigger for doctor table (before update)
create trigger before_update_hours
before update on doctor
for each row
set new.salary=new.totalhours*200;

update doctor set totalhours=200 where id=1;
update doctor set totalhours=totalhours+2;

-- 2) before insert trigger
create trigger before_insert_in_doctor
before insert on doctor
for each row 
set new.salary=new.totalhours*200;

insert into doctor(id,name,degree,email,totalhours,salary) values
(9,'Dr.Vaibhavi k', 'DMLT', 'vaibhavi.k@example.com',130,null);

create table expenses(expense_id int primary key,expense_name varchar(50),expense_total decimal(10,2));
insert into expenses values
(1,"salaries",0),
(2,"suppliers",0),
(3,"taxes",0);
drop table expenses;
update expenses set expense_total=(select sum(salary) from doctor) where expense_name="salaries";

-- 3) after delete trigger
create trigger after_delete_doctor
after delete on doctor
for each row
update expenses
set expense_total=expense_total-old.salary where expense_name="salaries";

delete from doctor where id=11;

-- 4) after insert trigger
create trigger after_insert_doctor
after insert on doctor
for each row
update expenses
set expense_total=expense_total+new.salary where expense_name="salaries";


-- 5) after update doctor
create trigger after_update_doctor
after update on doctor
for each row
update expenses
set expense_total=expense_total+(new.salary-old.salary) 
where expense_name="salaries";

update doctor set totalhours=110 where id=9;
select *from expenses;
select *from doctor;

create table archievedoctor(id int primary key auto_increment,name varchar(50) not null,deletedAt timestamp default now());
select *from archievedoctor;

-- 6) before delete trigger
create trigger before_delete_doctor
before delete on doctor
for each row
insert into archievedoctor(doctor_name) values(old.name);
delete from doctor where id=9;

