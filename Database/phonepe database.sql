create database phonepe;
use phonepe;
desc user;
select * from user;
select * from bankaccount;
select * from merchant;

select * from transaction;
desc transaction;

-- Trigger for transaction history table --
create trigger after_transaction
after insert on transaction
for each row
insert into transaction_history(amount,date_time,user_id,recipient_id,user_name,recipient_name,tstatus) 
								values (new.amount,new.date_time,new.user_id,new.recipient_id,
                                (select name from user where id=new.user_id),(select name from user where id=new.recipient_id),new.tstatus);
drop trigger after_transaction;

select * from transaction;
desc transaction;

select *from transaction_history;
desc transaction_history;

insert into wallet(user_id,wallet_balance,topup_amount,withdrawl_amount) values (5,0,0,0);

-- Triggers for wallet table --
delimiter //
create trigger before_update_wallet
before update on wallet
for each row
begin
        if new.transaction_type='credit' then
        set NEW.wallet_balance = OLD.wallet_balance + NEW.last_topup_amount;
    elseif new.transaction_type='debit' then
        set NEW.wallet_balance = OLD.wallet_balance - NEW.last_withdrawl_amount;
    end if;
end;
//
delimiter ;

drop trigger before_update_wallet;
update wallet set transaction_type='credit',last_topup_amount=2000 where id=2;
update wallet set transaction_type='debit',last_withdrawl_amount=500 where id=2;
alter table wallet rename column withdrawl_amount to last_withdrawl_amount;
select * from wallet ;
desc wallet;

select * from offers;
select * from feedback;
desc feedback;

select * from notifications;

-- Trigger for notification table---

delimiter //
create trigger after_insert_on_transaction 
after insert on transaction
FOR EACH ROW
begin
  IF NEW.tstatus = 'completed' THEN
    insert into notifications(user_id,message) values
    (new.user_id, concat('Rs.',(select amount from transaction where id=new.id),' Recieved from ',(select name from user where id=new.recipient_id)));
else
    insert into notifications(user_id,message) values(new.user_id,concat('Payment failed from ',(select name from user where id=new.recipient_id)));
end if;
end //
delimiter ;

drop trigger after_insert_on_transaction;

-- Queries for transaction table --
insert into transaction(id,amount,user_id,recipient_id,tstatus) values (6,300,1,10,'completed');
select * from transaction where user_id=1;
select sum(amount) as total_amt_recieved from transaction where user_id=1; 






