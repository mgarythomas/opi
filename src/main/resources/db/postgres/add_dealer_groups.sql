do $$

declare 
company_id integer;
dealer_id integer;

begin

--select hibernate_sequence.nextval into company_id from dual; 
--select hibernate_sequence.nextval into dealer_id from dual; 
SELECT NEXTVAL('hibernate_sequence') into company_id;
SELECT NEXTVAL('hibernate_sequence') into dealer_id;
insert into company (ID, NAME,ABN,ACN) values (company_id,'Patron Financial Advice','13122381908',''); 
insert into dealergroup (ID, AFSL,COMPANYID,ISDAAPPROVED) values(dealer_id,'307379', company_id,'true');
SELECT NEXTVAL('hibernate_sequence') into company_id;
SELECT NEXTVAL('hibernate_sequence') into dealer_id;
insert into company (ID, NAME,ABN,ACN) values (company_id,'Phillips Dean Brickwood Pty Ltd','65117370288',''); 
insert into dealergroup (ID, AFSL,COMPANYID,ISDAAPPROVED) values(dealer_id, '296724', company_id,'true');

end $$;

commit;