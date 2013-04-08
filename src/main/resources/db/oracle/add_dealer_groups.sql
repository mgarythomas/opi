-- set define off;
declare
company_id NUMBER(9);
dealer_id NUMBER(9);
begin
select hibernate_sequence.nextval into company_id from dual; 
select hibernate_sequence.nextval into dealer_id from dual; 
insert into company (ID,NAME,ABN,ACN) values ( company_id, 'Patron Financial Advice','13122381908',''); 
insert into dealergroup (ID,AFSL,COMPANYID,ISDAAPPROVED) values(dealer_id, '307379', company_id,'true');
select hibernate_sequence.nextval into company_id from dual; 
select hibernate_sequence.nextval into dealer_id from dual; 
insert into company (ID,NAME,ABN,ACN) values ( company_id, 'Phillips Dean Brickwood Pty Ltd','65117370288',''); 
insert into dealergroup (ID,AFSL,COMPANYID,ISDAAPPROVED) values(dealer_id, '296724', company_id,'true');
end;

commit;
