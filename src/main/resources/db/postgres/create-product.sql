do $$

declare 
individual_id integer;
company_id integer;
product_id integer;

begin
select nextval('hibernate_sequence') into individual_id;
select nextval('hibernate_sequence') into company_id;
select nextval('hibernate_sequence') into product_id;

INSERT INTO individual (ID,TITLE, FIRSTNAME, LASTNAME, WORKPHONE, MOBILEPHONE, WORKEMAIL, OCCUPATION, EMPLOYER) 
VALUES ( individual_id, 'MR', 'SAM', 'COOK', '1300309092', '0423217555', 'bdm@hfa.com.au', 'BDM', 'HFA');

INSERT INTO COMPANY (ID,TYPE, NAME, ADDRESS1, ADDRESS2, SUBURB, STATE, POSTCODE, TELEPHONE, ABN, INCORPORATIONCOUNTRY) 
VALUES ( company_id, 'PROVIDER', 'HFA', 'LEVEL 1 13 KIRKETON RD', '', 'DARLINGHURST', 'NSW', '2010', '1300309092', '25082852364','AUSTRALIA');

INSERT INTO PRODUCT (ID, PROVIDERID, NAME, TYPE, code, SHORTDESC, PUTPRICE, CALLPRICE, CALLUNDERLYING, LOWMINIMUM, LOWINCREMENT, HIGHMINIMUM, HIGHINCREMENT, MAXCOMMISSION) 
VALUES (product_id, company_id, 'Octane Global', 'HEDGED', 'hfa', 'ALTERNATIVE YIELD FUND', 20, 20, 20, 5000, 1000, 50000, 10000, 3.000); 

end $$;

commit;

