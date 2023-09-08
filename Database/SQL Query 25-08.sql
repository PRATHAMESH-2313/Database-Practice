use hospital;
show tables;

/*create procedure*/
delimiter //
create procedure get_patient()
begin
select *from patient;
end //
delimiter ;
call get_patient();
drop procedure get_patient;

/*create procedure with paramter*/
delimiter //
create procedure find_doctor(IN did int)
begin
select * from doctor where id=did;
end //
delimiter ;
call find_doctor(1); 	# procedure call 
drop procedure find_doctor;  -- drop procedure

delimiter //
create procedure get_count(IN patientgender varchar(50),OUT total int)
begin
select count(id) into total from patient where gender=patientgender ;
end //
delimiter ;
drop procedure get_count;
call get_count('male', @total);
select @total;

select * from patient;
 
create view doctor_details as select name from doctor;  -- create view doctor_details
select *from doctor_details;
drop view docto_details;  # drop view

/* Date time */
select str_to_date('23,03,00','%d,%m,%y') as temp;
select str_to_date('march 23rd,2000','%M %D,%Y') as temp2;

