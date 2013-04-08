set define off;
declare 
individual_id NUMBER(9);
product_id NUMBER(9);

begin
  -- create citibank company
  select hibernate_sequence.nextval into company_citibank_id from dual;
  insert into company (
    ID,
	TYPE,
	NAME,
	TRADINGNAME,
	ADDRESS1,
	ADDRESS2,
	SUBURB,
	STATE,
	POSTCODE,
	TELEPHONE,
	TFN,
	ABN,
	ACN,
	ARBN,
	INCORPORATIONCOUNTRY,
	INCORPORATIONDATE)
  values (
    company_citibank_id,
    'PROVIDER',
    'Citibank',
    '',
    '11 George Street', 
    '',
    'Sydney',
    'NSW',
    '2000',
    '',
    '',
    '12345678911',
    '',
    '',
    '',
    '');

  -- create citibank BDM
  select hibernate_sequence.nextval into individual_id from dual;

  INSERT INTO "INDIVIDUAL" (ID,TITLE, FIRSTNAME, LASTNAME, WORKPHONE, MOBILEPHONE, WORKEMAIL, OCCUPATION, EMPLOYER) 
  VALUES (individual_id, 'MR', 'TOM', 'KITE', '1300309092', '0423217555', 'bdm@citibank.com.au', 'BDM', 'Citibank');

  select hibernate_sequence.nextval into product_id_1 from dual;
  select hibernate_sequence.nextval into product_id_2 from dual;

  INSERT INTO "PRODUCT" (ID, PROVIDERID, NAME, CODE, TYPE, SHORTDESC, PUTPRICE, CALLPRICE, CALLUNDERLYING, LOWMINIMUM, LOWINCREMENT, HIGHMINIMUM, HIGHINCREMENT, MAXCOMMISSION) 
  VALUES (product_id_1, 4289, 'UBS Call Ups - Series 6 - AUD', 'citibank1', 'HEDGED', 'MONTHLY FUND', 20, 20, 20, 5000, 1000, 50000, 10000, 3.000); 

  INSERT INTO "PRODUCT" (ID, PROVIDERID, NAME, CODE, TYPE, SHORTDESC, PUTPRICE, CALLPRICE, CALLUNDERLYING, LOWMINIMUM, LOWINCREMENT, HIGHMINIMUM, HIGHINCREMENT, MAXCOMMISSION) 
  VALUES (product_id_2, 4289, 'UBS Call Ups - Series 6 - USD', 'citibank2', 'HEDGED', 'MONTHLY FUND', 20, 20, 20, 5000, 1000, 50000, 10000, 3.000);
  
  -- TODO:  run stored procedure ReadAndLockApplication for PISA.  grab this
  -- from UAT and run on production when doing release.
end;
/

commit;