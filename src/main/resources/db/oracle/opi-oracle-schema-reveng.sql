-- drop table advisorindividual;                -- level 5       
drop table investorindividual;               -- level 5    
drop table application;                      -- level 4
drop table advisor;                          -- level 4
drop table advisorfirm;                      -- level 3
drop table individual;                       -- level 2     
drop table product;                          -- level 2
drop table trust;                            -- level 2         -- renamed
drop table dealergroup;                      -- level 2
drop table role;                             -- level 2    
drop table logon;                            -- level 1    
drop table company;                          -- level 1

drop sequence hibernate_sequence;

    create table "LOGON"(
        "ID" NUMBER(9) not null,
       "USERNAME" VARCHAR2(10),
       "PWD" VARCHAR2(10),
       "EMAIL" VARCHAR2(40) default '' not null,
        constraint "SYS_C008095" primary key ("ID")
    );

--    create unique index "DEVHKG8DBO"."SYS_C008095" on "DEVHKG8DBO"."LOGON"("ID");
    
    create table "COMPANY"(
       "ID" NUMBER(9) not null,
       "TYPE" VARCHAR2(24),
       "NAME" VARCHAR2(80),
       "TRADINGNAME" VARCHAR2(80),
       "ADDRESS1" VARCHAR2(40),
       "SUBURB" VARCHAR2(25),
       "STATE" VARCHAR2(3),
       "POSTCODE" VARCHAR2(4),
       "TELEPHONE" VARCHAR2(10),
       "TFN" VARCHAR2(9),
       "ABN" VARCHAR2(11),
       "ACN" VARCHAR2(9),
       "ARBN" VARCHAR2(11),
       "INCORPORATIONCOUNTRY" VARCHAR2(20),
       "INCORPORATIONDATE" DATE,
        constraint "SYS_C008097" primary key ("ID")
    );

--    create unique index "SYS_C008097" on "COMPANY"("ID");
    
    create table "ROLE"(
        "ID" NUMBER(9) not null,
       "LOGONID" NUMBER(9),
       "ROLENAME" VARCHAR2(12) default '' not null,
        constraint "SYS_C008100" primary key ("ID")
    );

    alter table "ROLE"  
        add constraint "ROLE_LOGON_FK" 
        foreign key ("LOGONID") 
        references "LOGON"("ID") 
        on delete set null ;

--    create unique index "SYS_C008100" on "ROLE"("ID");
    
    create table "DEALERGROUP"(
        "ID" NUMBER(9) not null,
       "AFSL" VARCHAR2(6),
       "ISAPPROVED" CHAR(1) default 'N' not null,
       "COMPANYID" NUMBER(9),
        constraint "SYS_C008103" primary key ("ID")
    );

    alter table "DEALERGROUP"  
        add constraint "DEALERGROUP_COMPANY_FK" 
        foreign key ("COMPANYID") 
        references "COMPANY"("ID") 
        on delete cascade ;

--    create unique index "SYS_C008103" on "DEALERGROUP"("ID");
    
    create table "TRUST"(
        "ID" NUMBER(9) not null,
       "COMPANYID" NUMBER(9),
       "SOLICITORNAME" VARCHAR2(25),
       "SOLICITORCOMPANYID" NUMBER(9),
        constraint "SYS_C008106" primary key ("ID")
    );

    alter table "TRUST"  
        add constraint "TRUST_COMPANY_FK" 
        foreign key ("COMPANYID") 
        references "COMPANY"("ID") 
        on delete set null ;
    alter table "TRUST"  
        add constraint "TRUST_SOLICITOR_FK" 
        foreign key ("SOLICITORCOMPANYID") 
        references "COMPANY"("ID") 
        on delete set null ;

--    create unique index "SYS_C008106" on "TRUST"("ID");
    
    create table "PRODUCT"(
        "ID" NUMBER(9) not null,
       "PROVIDERID" NUMBER(9),
       "NAME" VARCHAR2(40),
       "TYPE" VARCHAR2(24),
       "SHORTDESC" VARCHAR2(120),
       "HASMINIMUMBASE" CHAR(1) default 'N' not null,
       "HASMINIMUMINCREMENT" CHAR(1) default 'N' not null,
       "LOWMINIMUM" NUMBER(9),
       "LOWINCREMENT" NUMBER(9),
       "HIGHMINIMUM" NUMBER(9),
       "HIGHINCREMENT" NUMBER(9),
        constraint "SYS_C008125" primary key ("ID")
    );

    alter table "PRODUCT"  
        add constraint "PRODUCT" 
        foreign key ("PROVIDERID") 
        references "COMPANY"("ID") 
        on delete cascade ;

--    create unique index "SYS_C008125" on "PRODUCT"("ID");
    
    create table "INDIVIDUAL"(
        "ID" NUMBER(9) not null,
       "LOGONID" NUMBER(9),
       "TITLE" VARCHAR2(4),
       "FIRSTNAME" VARCHAR2(24),
       "MIDDLENAME" VARCHAR2(24),
       "LASTNAME" VARCHAR2(24),
       "ADDRESS1" VARCHAR2(32),
       "ADDRESS2" VARCHAR2(32),
       "SUBURB" VARCHAR2(24),
       "STATE" VARCHAR2(3),
       "POSTCODE" VARCHAR2(4),
       "COUNTRY" VARCHAR2(20),
       "TFN" VARCHAR2(9),
       "ABN" VARCHAR2(11),
       "HOMEPHONE" VARCHAR2(10),
       "WORKPHONE" VARCHAR2(10),
       "MOBILEPHONE" VARCHAR2(10),
       "PERSONALFAX" VARCHAR2(10),
       "WORKFAX" VARCHAR2(10),
       "PERSONALEMAIL" VARCHAR2(50),
       "WORKEMAIL" VARCHAR2(50),
       "DATEOFBIRTH" DATE,
       "TOWNOFBIRTH" VARCHAR2(24),
       "COUNTRYOFBIRTH" VARCHAR2(24),
       "PASSPORTNO" VARCHAR2(24),
       "NATIONALITY" VARCHAR2(24),
       "DRIVERSLICENCENO" VARCHAR2(24),
       "OCCUPATION" VARCHAR2(24),
       "EMPLOYER" VARCHAR2(37),
       "WEALTHBYEMPLOYMENT" CHAR(1) default 'N',
       "WEALTHBYINVESTMENTS" CHAR(1) default 'N',
       "WEALTHBYOTHER" CHAR(1) default 'N',
       "WEALTHBYOTHERINFO" VARCHAR2(80),
        constraint "SYS_C008110" primary key ("ID")
    );

    alter table "INDIVIDUAL"  
        add constraint "INDIVIDUAL_LOGON_FK" 
        foreign key ("LOGONID") 
        references "LOGON"("ID") 
        on delete set null ;

--    create unique index "SYS_C008110" on "INDIVIDUAL"("ID");
    
    create table "ADVISORFIRM"(
        "ID" NUMBER(9) not null,
       "DEALERGROUPID" NUMBER(9),
       "COMPANYID" NUMBER(9),
        constraint "SYS_C008113" primary key ("ID")
    );

    alter table "ADVISORFIRM"  
        add constraint "ADVISORFIRM_COMPANY_FK" 
        foreign key ("COMPANYID") 
        references "COMPANY"("ID") 
        on delete cascade ;
    alter table "ADVISORFIRM"  
        add constraint "DEALERGROUP_ADVISORFIRM_FK" 
        foreign key ("DEALERGROUPID") 
        references "DEALERGROUP"("ID");

--    create unique index "SYS_C008113" on "ADVISORFIRM"("ID");
    
    create table "ADVISOR"(
        "ID" NUMBER(9) not null,
       "ISACTIVATED" CHAR(1) default 'N' not null,
       "INDIVIDUALID" NUMBER(9),
       "ADVISORFIRMID" NUMBER(9),
        constraint "SYS_C008117" primary key ("ID")
    );

    alter table "ADVISOR"  
        add constraint "ADVISOR_ADVISORFIRM_FK" 
        foreign key ("ADVISORFIRMID") 
        references "ADVISORFIRM"("ID") 
        on delete set null ;
    alter table "ADVISOR"  
        add constraint "ADVISOR_INDIVIDUAL_FK" 
        foreign key ("INDIVIDUALID") 
        references "INDIVIDUAL"("ID") 
        on delete set null ;

--    create unique index "SYS_C008117" on "ADVISOR"("ID");
    
--       "ISADVISORCONTACTPERSON" CHAR(1) default 'N' not null,

    create table "APPLICATION"(
        "ID" NUMBER(9) not null,
       "COMPANYID" NUMBER(9),
       "TRUSTID" NUMBER(9),
       "ADVISORID" NUMBER(9),
       "PRODUCTID" NUMBER(9),
       "NAME" VARCHAR2(74),
       "FIRSTNAME" VARCHAR2(24),
       "LASTNAME" VARCHAR2(24),
       "TELEPHONE" VARCHAR2(10),
       "EMAIL" VARCHAR2(50),
       "ADDRESS1" VARCHAR2(32),
       "SUBURB" VARCHAR2(25),
       "STATE" VARCHAR2(3),
       "POSTCODE" VARCHAR2(4),
       "TYPE" NUMBER(1) not null,
       "APPLICATIONDATE" DATE,
       "APPLICATIONAMOUNT01" NUMBER(9),
       "APPLICATIONAMOUNT02" NUMBER(9),
       "APPLICATIONAMOUNT03" NUMBER(9),
       "APPLICATIONAMOUNT04" NUMBER(9),
       "APPLICATIONAMOUNT05" NUMBER(9),
       "APPROVEDAMOUNT" NUMBER(9),
       "PUTPRICE" NUMBER(6),
       "CALLPRICE" NUMBER(6),
       "CALLUNDERLYING" VARCHAR2(2),
       "CREATIONDATE" DATE,
       "STATUS" NUMBER,
       "PAYMENTSTATUS" NUMBER,
       "ISBORROWINGFROMUBS" CHAR(1) default 'N' not null,
       "ISPURCHASINGPUTFROMUBS" CHAR(1) default 'N' not null,
       "ISIAL" CHAR(1) default 'N' not null,
       "ISUBSTOSIGHTTRUSTDEED" CHAR(1) default 'N' not null,
       "ISEITHERTOSIGN" CHAR(1) default 'N' not null,
       "ISONEOFFICERTOSIGN" CHAR(1) default 'N' not null,
       "ISDIRECTCREDIT" CHAR(1) default 'N' not null,
       "ISPAPERCOPYWANTED" CHAR(1) default 'N' not null,
       "ISPROVIDERCUSTOMER" CHAR(1) default 'N' not null,
       "ISLATEST" CHAR(1) default 'Y' not null,
       "PROVIDERUNITHOLDERNUMBER" VARCHAR2(25),
       "PROVIDERFUNDNAME" VARCHAR2(25),
       "ISUBSCUSTOMER" CHAR(1) default 'N' not null,
       "UBSUNITHOLDERNUMBER" VARCHAR2(25),
       "UBSFUNDNAME" VARCHAR2(25),
       "DDAPPLICANT" VARCHAR2(80),
       "DDABN" VARCHAR2(11),
       "DDINSTITUTION" VARCHAR2(25),
       "DDINSTITUTIONADDRESS" VARCHAR2(37),
       "DDACCOUNTNAME" VARCHAR2(80),
       "DDBSB" VARCHAR2(6),
       "DDACCOUNTNO" VARCHAR2(9),
       "ICASH" NUMBER,
       "ISHARES" NUMBER,
       "IOTHERLIQUID" NUMBER,
       "IRESIDENTIALPROPERTY" NUMBER,
       "IINVESTMENTPROPERTY" NUMBER,
       "IOTHERASSETS" NUMBER,
       "IOTHERASSETSDETAILS" VARCHAR2(50),
       "IOTHERLOANSSECURED" NUMBER,
       "ILOANSRESIDENTIALPROPERTY" NUMBER,
       "ILOANSINVESTMENTPROPERTY" NUMBER,
       "ILOANSPERSONALUNSECURED" NUMBER,
       "IGUARANTEESGRANTED" NUMBER,
       "IOTHERLIABILITIES" NUMBER,
       "IOTHERLIABILITIESDETAILS" VARCHAR2(50),
       "ISALARY" NUMBER,
       "IRENTALANDDIVIDEND" NUMBER,
       "IOTHERINCOME" NUMBER,
       "IOTHERINCOMEDETAILS" VARCHAR2(50),
       "ITAXPAYABLE" NUMBER,
       "ITAXPAYABLEDATE" DATE,
       "IINTERESTONSECUREDLOANS" NUMBER,
       "IINTERESTONUNSECUREDLOANS" NUMBER,
       "ILIVINGEXPENSES" NUMBER,
       "IOTHEREXPENSES" NUMBER,
       "GCASH" NUMBER,
       "GSHARES" NUMBER,
       "GOTHERLIQUID" NUMBER,
       "GRESIDENTIALPROPERTY" NUMBER,
       "GINVESTMENTPROPERTY" NUMBER,
       "GOTHERASSETS" NUMBER,
       "GOTHERASSETSDETAILS" VARCHAR2(50),
       "GOTHERLOANSSECURED" NUMBER,
       "GLOANSRESIDENTIALPROPERTY" NUMBER,
       "GLOANSINVESTMENTPROPERTY" NUMBER,
       "GLOANSPERSONALUNSECURED" NUMBER,
       "GGUARANTEESGRANTED" NUMBER,
       "GOTHERLIABILITIES" NUMBER,
       "GOTHERLIABILITIESDETAILS" VARCHAR2(50),
       "GSALARY" NUMBER,
       "GRENTALANDDIVIDEND" NUMBER,
       "GOTHERINCOME" NUMBER,
       "GOTHERINCOMEDETAILS" VARCHAR2(50),
       "GTAXPAYABLE" NUMBER,
       "GTAXPAYABLEDATE" DATE,
       "GINTERESTONSECUREDLOANS" NUMBER,
       "GINTERESTONUNSECUREDLOANS" NUMBER,
       "GLIVINGEXPENSES" NUMBER,
       "GOTHEREXPENSES" NUMBER,
        constraint "SYS_C008150" primary key ("ID")
    );

    alter table "APPLICATION"  
        add constraint "APPLICATION_ADVISOR_FK" 
        foreign key ("ADVISORID") 
        references "ADVISOR"("ID") 
        on delete set null ;
    alter table "APPLICATION"  
        add constraint "APPLICATION_COMPANY_FK" 
        foreign key ("COMPANYID") 
        references "COMPANY"("ID") 
        on delete set null ;
    alter table "APPLICATION"  
        add constraint "APPLICATION_PRODUCT_FK" 
        foreign key ("PRODUCTID") 
        references "PRODUCT"("ID") 
        on delete set null ;
    alter table "APPLICATION"  
        add constraint "APPLICATION_TRUST_FK" 
        foreign key ("TRUSTID") 
        references "TRUST"("ID") 
        on delete set null ;

--    create unique index "SYS_C008150" on "APPLICATION"("ID");
    
--       "ISCONTACTPERSON" CHAR(1) default 'N' not null,
    create table "INVESTORINDIVIDUAL"(
        "ID" NUMBER(9) not null,
       "INDIVIDUALID" NUMBER(9),
       "APPLICATIONID" NUMBER(9),
       "ROLE" VARCHAR2(25),
       "ISAPPLICANT" CHAR(1) default 'Y' not null,
       "ISGUARANTOR" CHAR(1) default 'N' not null,
       "ISDIRECTOR" CHAR(1) default 'N' not null,
       "ISTRUSTEE" CHAR(1) default 'N' not null,
       "ISBENEFICIARY" CHAR(1) default 'N' not null,
       "TYPEOFDIRECTOR" VARCHAR2(25),
        constraint "SYS_C008158" primary key ("ID")
    );

    alter table "INVESTORINDIVIDUAL" 
        add constraint "INVESTORIND_APPLICATION_FK" 
        foreign key ("APPLICATIONID") 
        references "APPLICATION"("ID") 
        on delete set null;
    alter table "INVESTORINDIVIDUAL"  
        add constraint "INVESTORIND_INDIVIDUAL_FK" 
        foreign key ("INDIVIDUALID") 
        references "INDIVIDUAL"("ID") 
        on delete set null;

--    create unique index "SYS_C008158" on "INVESTORINDIVIDUAL"("ID");
    
--    create table "ADVISORINDIVIDUAL"(
--        "ID" NUMBER(9) not null,
--       "ADVISORID" NUMBER(9),
--       "INDIVIDUALID" NUMBER(9),
--        constraint "SYS_C008258" primary key ("ID")
--    );

--    alter table "ADVISORINDIVIDUAL"  
--        add constraint "ADVISORIND_ADVISOR_FK" 
--        foreign key ("ADVISORID") 
--        references "ADVISOR"("ID") 
--        on delete set null ;
--    alter table "ADVISORINDIVIDUAL"  
--        add constraint "ADVISORIND_INDIVIDUAL_FK" 
--        foreign key ("INDIVIDUALID") 
--        references "INDIVIDUAL"("ID") 
--        on delete set null ;

--    create unique index "SYS_C008258" on "ADVISORINDIVIDUAL"("ID");
    
CREATE SEQUENCE  "HIBERNATE_SEQUENCE"  
MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1 
START WITH 1 NOCACHE  NOORDER  NOCYCLE;

commit;