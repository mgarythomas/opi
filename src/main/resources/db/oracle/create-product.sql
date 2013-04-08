declare 
individual_id NUMBER(9);
company_id NUMBER(9);
product_id NUMBER(9);

begin
select hibernate_sequence.nextval into individual_id from dual;
select hibernate_sequence.nextval into company_id from dual;
select hibernate_sequence.nextval into product_id from dual;

INSERT INTO "INDIVIDUAL" (ID,TITLE, FIRSTNAME, LASTNAME, WORKPHONE, MOBILEPHONE, WORKEMAIL, OCCUPATION, EMPLOYER) 
VALUES ( individual_id, 'MR', 'SAM', 'COOK', '1300309092', '0423217555', 'bdm@hfa.com.au', 'BDM', 'HFA');

INSERT INTO "COMPANY" (ID,TYPE, NAME, ADDRESS1, ADDRESS2, SUBURB, STATE, POSTCODE, TELEPHONE, ABN, INCORPORATIONCOUNTRY) 
VALUES ( company_id, 'PROVIDER', 'HFA', 'LEVEL 1 13 KIRKETON RD', '', 'DARLINGHURST', 'NSW', '2010', '1300309092', '25082852364','AUSTRALIA');

INSERT INTO "PRODUCT" (ID, PROVIDERID, NAME, TYPE, SHORTDESC, PUTPRICE, CALLPRICE, CALLUNDERLYING, LOWMINIMUM, LOWINCREMENT, HIGHMINIMUM, HIGHINCREMENT, MAXCOMMISSION) 
VALUES (product_id, company_id, 'Octane Global', 'HEDGED', 'ALTERNATIVE YIELD FUND', 20, 20, 20, 5000, 1000, 50000, 10000, 3.000); 

end;
/

commit;