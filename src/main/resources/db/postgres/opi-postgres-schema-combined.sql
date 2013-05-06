drop table investorindividual;
drop table advisorprovider;
drop table application;
drop table advisor cascade;
drop table advisorfirm;
drop table individual cascade;
drop table product;
drop table trust;
drop table dealergroup;
drop table acl_permission;
drop table acl_object_identity;
drop table authorities;
drop table users;
drop table company;

drop table SignificantUsers;
drop table StatusNarrative;
drop table AuditLog;

drop sequence hibernate_sequence;
drop sequence acl_object_identity_seq;	
drop sequence acl_permission_seq;

-- Start of ACEGI Tables

CREATE TABLE USERS (
    USERNAME varchar(10) NOT NULL PRIMARY KEY,
    PASSWORD varchar(10) NOT NULL,
    PASSWORDCONFIRMED varchar(5) default 'false' not null,
    ENABLED varchar(5) default 'false' not null -- hibernate type boolean,yes_no,true_false
);

CREATE TABLE AUTHORITIES (
--    ID integer NOT NULL PRIMARY KEY,
    USERNAME varchar(10) references users(username) on delete cascade,
    AUTHORITY varchar(50) NOT NULL,
    CONSTRAINT UNIQUE_AUTH_USERNAME UNIQUE(USERNAME,AUTHORITY)
);

CREATE SEQUENCE acl_object_identity_seq;	
	
CREATE TABLE ACL_OBJECT_IDENTITY (
    ID INTEGER NOT NULL DEFAULT nextval('acl_object_identity_seq') PRIMARY KEY,
    OBJECT_IDENTITY varchar(250) unique NOT NULL, -- VARCHAR_IGNORECASE(250)
    PARENT_OBJECT integer references ACL_OBJECT_IDENTITY on delete cascade,
    ACL_CLASS varchar(250) NOT NULL -- VARCHAR_IGNORECASE(250)
);

CREATE SEQUENCE acl_permission_seq;

CREATE TABLE ACL_PERMISSION (
    ID INTEGER NOT NULL DEFAULT nextval('acl_permission_seq')  PRIMARY KEY,
    ACL_OBJECT_IDENTITY integer references ACL_OBJECT_IDENTITY,
    RECIPIENT varchar(100) NOT NULL, -- VARCHAR_IGNORECASE(100)
    MASK INTEGER NOT NULL,
    CONSTRAINT UNIQUE_RECIPIENT UNIQUE(ACL_OBJECT_IDENTITY, RECIPIENT)
);

-- End of ACEGI Tables

create table COMPANY(
   ID serial primary key,
   TYPE varchar(24),
   NAME varchar(80),
   TRADINGNAME varchar(80),
   ADDRESS1 varchar(32),
   ADDRESS2 varchar(32),
   SUBURB varchar(25),
   STATE varchar(3),
   POSTCODE varchar(4),
   TELEPHONE varchar(20),
   TFN varchar(9),
   ABN varchar(11),
   ACN varchar(9),
   ARBN varchar(11),
   INCORPORATIONCOUNTRY varchar(50),
   INCORPORATIONDATE DATE
);

create table DEALERGROUP(
   ID serial primary key,
   COMPANYID integer references company on delete cascade,
   AFSL varchar(6),
   ISDAAPPROVED varchar(5) default 'false' not null, -- NOT ENTERED
   DealerGroupBonaFidesChecked varchar(5) default 'false'
);

create table TRUST (
   ID serial primary key,
   COMPANYID integer references company on delete set null,
   SOLICITORCOMPANYID  integer references company on delete set null,
   SOLICITORNAME varchar(25),
   ISSUPERFUND varchar(5) default 'false' not null,
   REVIEWDEEDS varchar(5) default 'false' not null,
   WEALTHBYEMPLOYMENT varchar(5) default 'false' not null,
   WEALTHBYINVESTMENTS varchar(5) default 'false' not null,
   WEALTHBYOTHER varchar(5) default 'false' not null,
   WEALTHBYOTHERINFO varchar(80)
);

create table PRODUCT (
   ID serial primary key,
   PROVIDERID integer references company on delete cascade,
   NAME varchar(40),
   TYPE varchar(24),
   CODE varchar(20),
   CLOSINGDATE DATE,
   PUTPRICE numeric(6),
   CALLPRICE numeric(6),
   CALLUNDERLYING varchar(2),
   SHORTDESC varchar(120),
   HASMINIMUMBASE varchar(5) default 'false' not null,
   HASMINIMUMINCREMENT varchar(5) default 'false' not null,
   LOWMINIMUM integer,
   LOWINCREMENT integer,
   HIGHMINIMUM integer,
   HIGHINCREMENT integer,
   MAXCOMMISSION numeric(5,3),
   ProductFilePrefix varchar(3),
   FileSystemSubdirectory varchar(25),
   AnnualInterestRate numeric(7,2),
   AnnualIALInterestRate numeric(7,2),
   PutFeesRate numeric(7,2)
);

create table INDIVIDUAL(
   ID serial primary key,
   USERNAME varchar(10) references users on delete cascade,
   TITLE varchar(4),
   FIRSTNAME varchar(24),
   MIDDLENAME varchar(24),
   LASTNAME varchar(24),
   ADDRESS1 varchar(32),
   ADDRESS2 varchar(32),
   SUBURB varchar(25),
   STATE varchar(3),
   POSTCODE varchar(4),
   COUNTRY varchar(50),
   TFN varchar(9),
   ABN varchar(11),
   HOMEPHONE varchar(20),
   WORKPHONE varchar(20),
   MOBILEPHONE varchar(20),
   PERSONALFAX varchar(20),
   WORKFAX varchar(20),
   PERSONALEMAIL varchar(50),
   WORKEMAIL varchar(50),
   DATEOFBIRTH DATE,
   TOWNOFBIRTH varchar(24),
   COUNTRYOFBIRTH varchar(50),
   PASSPORTNO varchar(24),
   NATIONALITY varchar(50),
   DRIVERSLICENCENO varchar(24),
   OCCUPATION varchar(24),
   EMPLOYER varchar(48)
);

create table ADVISORFIRM(
   ID serial primary key,
   DEALERGROUPID integer references dealergroup,
   COMPANYID integer references company
);

create table ADVISOR(
   ID serial primary key,
   ISACTIVATED varchar(5) default 'false' not null,
   INDIVIDUALID integer references individual on delete set null,
   ADVISORFIRMID integer references advisorfirm on delete set null,
   ASSISTANTNAME varchar(50),
   ASSISTANTEMAIL varchar(50),
   CheckAdviserDetails varchar(5) default 'false'
);

create table ADVISORPROVIDER (
   ID serial primary key,
   ADVISORID integer references advisor on delete cascade,
   PROVIDERID integer references company on delete cascade,
   INDIVIDUALID integer references individual on delete set null,
   FIRSTNAME varchar(24),                  -- BDM obsolete
   MIDDLENAME varchar(24),                 -- BDM obsolete
   LASTNAME varchar(24),                   -- BDM obsolete
   TELEPHONE varchar(20),                  -- BDM obsolete
   EMAIL varchar(50),                      -- BDM obsolete
   ADVISORnumeric varchar(12)
);

create table APPLICATION(
   ID serial primary key,
   COMPANYID integer references company on delete set null,
   TRUSTID integer references trust on delete set null,
   ADVISORID integer references advisor on delete set null,
   PRODUCTID integer references product on delete set null,
   COMMISSION numeric(5,3),
   APPLICATIONnumeric varchar(12),
   CLIENTnumeric varchar(12),
   ACCOUNTDESIGNATION varchar(80),
   FIRSTNAME varchar(24),
   MIDDLENAME varchar(24),
   LASTNAME varchar(24),
   HOMEPHONE varchar(20),
   WORKPHONE varchar(20),
   EMAIL varchar(50),
   FAX varchar(20),
   ADDRESS1 varchar(32),
   ADDRESS2 varchar(32),
   SUBURB varchar(25),
   STATE varchar(3),
   POSTCODE varchar(4),
   COUNTRY varchar(50),
   TYPE numeric(1) not null,
   APPLICATIONDATE DATE,
   APPLICATIONAMOUNT01 integer,
   APPLICATIONAMOUNT02 integer,
   APPLICATIONAMOUNT03 integer,
   APPLICATIONAMOUNT04 integer,
   APPLICATIONAMOUNT05 integer,
   APPROVEDAMOUNT01 integer,
   APPROVEDAMOUNT02 integer,
   APPROVEDAMOUNT03 integer,
   APPROVEDAMOUNT04 integer,
   APPROVEDAMOUNT05 integer,
-- SoftCopyReceivedDate DATE,                                                 -- should be here, see lower
-- RECORDCREATED DATE default 'sysdate',                                    -- should have default, but filled by OPI instead
   RECORDCREATED date,
   STATUS numeric,
   PAYMENTSTATUS numeric,
   ISBORROWINGFROMUBS varchar(5) default 'false' not null,
   ISPURCHASINGPUTFROMUBS varchar(5) default 'false' not null,
   ISIAL varchar(5) default 'false' not null,
   ISEITHERTOSIGN varchar(5) default 'false' not null,
   ISPAPERCOPYWANTED varchar(5) default 'false' not null,
   ISPROVIDERCUSTOMER varchar(5) default 'false' not null,
   ISLATEST varchar(5) default 'true' not null,
   REINVESTDISTRIBUTION varchar(5) default 'false' not null,
   DIRECTCREDITDISTRIBUTION varchar(5) default 'false' not null,
   PROVIDERUNITHOLDERnumeric varchar(25),
   PROVIDERFUNDNAME varchar(25),
   ISUBSCUSTOMER varchar(5) default 'false' not null,
   UBSUNITHOLDERnumeric varchar(25),
   UBSFUNDNAME varchar(25),
   DDAPPLICANT varchar(80),
   DDABN varchar(11),
   DDINSTITUTION varchar(80),
   DDINSTITUTIONADDRESS varchar(80),
   DDINSTITUTIONPOSTCODE varchar(4),
   DDINSTITUTIONSTATE varchar(3),
   DDINSTITUTIONSUBURB varchar(25),
   DDACCOUNTNAME varchar(80),
   DDBSB varchar(6),
   DDACCOUNTNO varchar(10),
   -- assets
   ICASH numeric,
   ISHARES numeric,
   IOTHERLIQUID numeric,
   IRESIDENTIALPROPERTY numeric,
   IINVESTMENTPROPERTY numeric,
   IOTHERASSETS numeric,
   IOTHERASSETSDETAILS varchar(50),
   -- liabilities
   IOTHERLOANSSECURED numeric,
   ILOANSRESIDENTIALPROPERTY numeric,
   ILOANSINVESTMENTPROPERTY numeric,
   ILOANSPERSONALUNSECURED numeric,
   IGUARANTEESGRANTED numeric,
   IOTHERLIABILITIES numeric,
   IOTHERLIABILITIESDETAILS varchar(50),
   -- income
   ISALARY numeric,
   IRENTALANDDIVIDEND numeric,
   IOTHERINCOME numeric,
   IOTHERINCOMEDETAILS varchar(50),
   ITAXPAYABLE numeric,
   ITAXPAYABLEDATE date,
   -- expenditure
   IINTERESTONSECUREDLOANS numeric,
   IINTERESTONUNSECUREDLOANS numeric,
   ILIVINGEXPENSES numeric,
   IOTHEREXPENSES numeric,
   IOTHEREXPENSESDETAILS varchar(50),
   -- assets
   GCASH numeric,
   GSHARES numeric,
   GOTHERLIQUID numeric,
   GRESIDENTIALPROPERTY numeric,
   GINVESTMENTPROPERTY numeric,
   GOTHERASSETS numeric,
   GOTHERASSETSDETAILS varchar(50),
   -- liabilities
   GOTHERLOANSSECURED numeric,
   GLOANSRESIDENTIALPROPERTY numeric,
   GLOANSINVESTMENTPROPERTY numeric,
   GLOANSPERSONALUNSECURED numeric,
   GGUARANTEESGRANTED numeric,
   GOTHERLIABILITIES numeric,
   GOTHERLIABILITIESDETAILS varchar(50),
   -- income
   GSALARY numeric,
   GRENTALANDDIVIDEND numeric,
   GOTHERINCOME numeric,
   GOTHERINCOMEDETAILS varchar(50),
   GTAXPAYABLE numeric,
   GTAXPAYABLEDATE date,
   -- expenditure
   GINTERESTONSECUREDLOANS numeric,
   GINTERESTONUNSECUREDLOANS numeric,
   GLIVINGEXPENSES numeric,
   GOTHEREXPENSES numeric,
   GOTHEREXPENSESDETAILS varchar(50),
   -- PISA internal fields
   ONBOARDINGSTATUS INTEGER DEFAULT 0,
   ONBOARDINGLASTUSER varchar(12),
   --OnboardingLastModifiedDate Date,                                           -- should be here, see lower
   ONBOARDINGCOMMENTS varchar(600),
   ONBOARDINGHARDCOPYSIGHTED varchar(5) default 'false',
   --AdviserBonaFidesChecked varchar(5) default 'false',                       -- should be here, see lower
   DADEALERGROUP varchar(5) default 'false',
   CREDITSTATUS INTEGER DEFAULT 0,
   CREDITLASTUSER varchar(12),
   --CreditLastModifiedDate Date,                                               -- should be here, see lower
   CREDITCOMMENTS varchar(600),
   CASAPPROVED varchar(5) default 'false',
   BAYCORPSAPPROVED varchar(5) default 'false',
   --IsReferredToCRC varchar(5) default 'false'                                -- should be here, see lower
   AMLSTATUS INTEGER DEFAULT 0,
   AMLLASTUSER varchar(12),
   --AMLLastModifiedDate Date,                                                  -- should be here, see lower
   AMLCOMMENTS varchar(200),
   AMLHARDCOPYSIGHTED varchar(5) default 'false',
   CREDITCHECKVERIFIED varchar(5) default 'false',
   GRIDCHECKVERIFIED varchar(5) default 'false',
   WORLDCHECKVERIFIED varchar(5) default 'false',
   GOOGLECHECKVERIFIED varchar(5) default 'false',
   CORPORATECHECKSVERIFIED varchar(5) default 'false',
   TRUSTCHECKSVERIFIED varchar(5) default 'false',
   --OperationsLastUser varchar(12),                                           -- should be here, see lower
   --OperationsLastModifiedDate DATE,                                           -- should be here, see lower
   --AdministrationLastUser varchar(12),                                       -- should be here, see lower
   --AdministrationLastModifiedDate DATE,                                       -- should be here, see lower
   --MasterLastUser varchar(12),                                               -- should be here, see lower
   --MasterLastModifiedDate DATE,                                               -- should be here, see lower
   OPERATIONSCOMMENTS varchar(200),
   --OperationsComments1 varchar(200),                                         -- should be here, see lower
   --OperationsComments2 varchar(200),                                         -- should be here, see lower
   --OperationsComments3 varchar(200),                                         -- should be here, see lower
   --OperationsComments4 varchar(200),                                         -- should be here, see lower
   --OperationsComments5 varchar(200),                                         -- should be here, see lower
   --OperationsComments6 varchar(200),                                         -- should be here, see lower
   --OperationsComments7 varchar(200),                                         -- should be here, see lower
   --OperationsComments8 varchar(200),                                         -- should be here, see lower
   --OperationsComments9 varchar(200),                                         -- should be here, see lower
   BANK3RDPARTYAUTHORISATION INTEGER DEFAULT 0,
   BILLINGAPPROVED varchar(5) default 'false',
   --AutomaticDirectDebitSuppressed varchar(5) default 'false',                -- should be here, see lower
   RECONCILEDBILLINGDATA varchar(5) default 'false',
   GENERATEDBILLINGDATA varchar(5) default 'false',
   AMOUNTDUEPAID numeric(9,2),
   --AmountDue numeric(9,2),                                                     -- should be removed, see lower
   --NewAmountDue numeric(9,2),                                                  -- should be removed, see lower
   --FirstAmountReceived numeric(9,2),                                           -- should be here, see lower
   --AmendedPaymentAmount numeric(9,2),                                          -- should be here, see lower
   --InHouseAmount numeric(9,2),                                                 -- should be here, see lower
   SCHEDULEDDDDATE date,
   DDPAYMENTSUCCESSFUL varchar(5) default 'false',
   DDUNSUCCESSFULREASON varchar(100),
   --FirstDDStatusFailed varchar(5) default 'false',                           -- should be here, see lower
   --FirstDDStatusSucceeded varchar(5) default 'false',                        -- should be here, see lower
   --FirstDDStatusDate DATE,                                                    -- should be here, see lower
   --IsSecondDD varchar(5) default 'false' not null,                           -- should be here, see lower
   --SecondScheduledDDDate DATE,                                                -- should be here, see lower
   --SecondDDStatusFailed varchar(5) default 'false',                          -- should be here, see lower
   --SecondDDStatusSucceeded varchar(5) default 'false',                       -- should be here, see lower
   --SecondDDStatusDate DATE,                                                   -- should be here, see lower
   --IsBPay varchar(5) default 'false' not null,                               -- should be here, see lower
   --BPayReference varchar(25),                                                -- should be here, see lower
   --BPayStatusFailed varchar(5) default 'false',                              -- should be here, see lower
   --BPayStatusSucceeded varchar(5) default 'false',                           -- should be here, see lower
   --BPayStatusDate DATE,                                                       -- should be here, see lower
   --IsDirectCredit varchar(5) default 'false',                                -- should be here, see lower
   --DirectCreditStatusFailed varchar(5) default 'false',                      -- should be here, see lower
   --DirectCreditStatusSucceeded varchar(5) default 'false',                   -- should be here, see lower
   --DirectCreditStatusDate DATE,                                               -- should be here, see lower
   --ChequeBankedDate DATE,                                                     -- should be here, see lower
   --OpsIssueRaisedTicked varchar(5) default 'false',                          -- should be here, see lower
   --OpsIssueRaisedDate DATE,                                                   -- should be here, see lower
   --OpsIssueRaisedUserID varchar(12),                                         -- should be here, see lower
   --OpsIssueResolvedTicked varchar(5) default 'false',                        -- should be here, see lower
   --OpsIssueResolvedDate DATE,                                                 -- should be here, see lower
   --OpsIssueResolvedUserID varchar(12),                                       -- should be here, see lower
   INITIALPAYMENTBYCHEQUE varchar(5) default 'false',
   PAYMENTBYALTERNATIVEMEANS numeric(9,2),
   --ChequeForUBSAttached varchar(5) default 'false',                          -- should be here, see lower
   --ChequeAmount numeric(9,2),                                                  -- should be here, see lower
   --ChequeReturned varchar(5) default 'false',                                -- should be here, see lower
   --ChequeAccepted varchar(5) default 'false',                                -- should be here, see lower
   CONDUCTEDBILLING varchar(5) default 'false',
   GENERATEDAPPROVALLETTER varchar(5) default 'false',
   GENERATEDREJECTIONLETTER varchar(5) default 'false',
   ADMINISTRATIONCOMMENTS varchar(200),
   ONBOARDINGINFO1SATISFIED varchar(5) default 'false',
   ONBOARDINGINFO1COMMENTARY varchar(250),
   ONBOARDINGINFO2SATISFIED varchar(5) default 'false',
   ONBOARDINGINFO2COMMENTARY varchar(250),
   ONBOARDINGINFO3SATISFIED varchar(5) default 'false',
   ONBOARDINGINFO3COMMENTARY varchar(250),
   CREDITINFO1SATISFIED varchar(5) default 'false',
   CREDITINFO1COMMENTARY varchar(250),
   CREDITINFO2SATISFIED varchar(5) default 'false',
   CREDITINFO2COMMENTARY varchar(250),
   CREDITINFO3SATISFIED varchar(5) default 'false',
   CREDITINFO3COMMENTARY varchar(250),
   AMLINFO1SATISFIED varchar(5) default 'false',
   AMLINFO1COMMENTARY varchar(250),
   AMLINFO2SATISFIED varchar(5) default 'false',
   AMLINFO2COMMENTARY varchar(250),
   AMLINFO3SATISFIED varchar(5) default 'false',
   AMLINFO3COMMENTARY varchar(250),
   ONBOARDINGINFONOTYETCHECKED varchar(5) default 'false',
   CREDITINFONOTYETCHECKED varchar(5) default 'false',
   AMLINFONOTYETCHECKED varchar(5) default 'false',
   BAYCORPRECORDCREATED varchar(5) default 'false',
   ASICCOMPANYSEARCH varchar(5) default 'false',
   ATOREGISTRATION varchar(5) default 'false',
   TRUSTDEEDAPPROVED varchar(5) default 'false',
   APPLICANT1APPROVED varchar(5) default 'false',
   APPLICANT1MATERIAL varchar(5) default 'false',
   APPLICANT1IMMATERIAL varchar(5) default 'false',
   APPLICANT1NOHIT varchar(5) default 'false',
   APPLICANT1NOTAPPLICABLE varchar(5) default 'false',
   APPLICANT2APPROVED varchar(5) default 'false',
   APPLICANT2MATERIAL varchar(5) default 'false',
   APPLICANT2IMMATERIAL varchar(5) default 'false',
   APPLICANT2NOHIT varchar(5) default 'false',
   APPLICANT2NOTAPPLICABLE varchar(5) default 'false',
   COMPANYAPPROVED varchar(5) default 'false',
   COMPANYMATERIAL varchar(5) default 'false',
   COMPANYIMMATERIAL varchar(5) default 'false',
   COMPANYNOHIT varchar(5) default 'false',
   COMPANYNOTAPPLICABLE varchar(5) default 'false',
   OTHERPERSONSAPPROVED varchar(5) default 'false',
   OTHERPERSONSMATERIAL varchar(5) default 'false',
   OTHERPERSONSIMMATERIAL varchar(5) default 'false',
   OTHERPERSONSNOHIT varchar(5) default 'false',
   OTHERPERSONSNOTAPPLICABLE varchar(5) default 'false',
   INFORMATIONNOTIFICATIONDATE date,
   CONDITIONALNOTIFICATIONDATE date,
   APPROVALNOTIFICATIONDATE date,
   APPLICATIONWITHDRAWN varchar(5) default 'false',
   APPLICATIONDELETED varchar(5) default 'false',
   BAYCORP1FILECREATED varchar(5) default 'false',
   GRIDCHECK1APPROVED varchar(5) default 'false',
   WORLDCHECK1APPROVED varchar(5) default 'false',
   GOOGLECHECK1APPROVED varchar(5) default 'false',
   ASICDIRECTOR1CHECK varchar(5) default 'false',
   ASICBENEFICIARY1CHECK varchar(5) default 'false',
   BAYCORP2FILECREATED varchar(5) default 'false',
   GRIDCHECK2APPROVED varchar(5) default 'false',
   WORLDCHECK2APPROVED varchar(5) default 'false',
   GOOGLECHECK2APPROVED varchar(5) default 'false',
   ASICDIRECTOR2CHECK varchar(5) default 'false',
   ASICBENEFICIARY2CHECK varchar(5) default 'false',
   SUPERFUNDREGISTRATIONCHECK varchar(5) default 'false',
   NOTIFICATIONDATE date,
   ONBOARDINGLOCK varchar(12),
   CREDITLOCK varchar(12),
   AMLLOCK varchar(12),
   MAINLOCK varchar(12),
   CREATEDBY varchar(10),
   MODIFIEDBY varchar(10),
   RecordModified date,
   SoftCopyReceivedDate date,                                                   -- see above for preferred position
   ChequeForUBSAttached varchar(5) default 'false' not null,                   -- see above for preferred position
   ChequeAmount numeric(9,2),                                                    -- see above for preferred position
   ChequeReturned varchar(5) default 'false' not null,                         -- see above for preferred position
   ChequeAccepted varchar(5) default 'false' not null,                         -- see above for preferred position
   IsReferredToCRC varchar(5) default 'false' not null,                        -- see above for preferred position
   AmountDue numeric(9,2),                                                       -- to be removed
   NewAmountDue numeric(9,2),                                                    -- to be removed
   FirstDDStatusFailed varchar(5) default 'false' not null,                    -- see above for preferred position
   FirstDDStatusSucceeded varchar(5) default 'false' not null,                 -- see above for preferred position
   FirstDDStatusDate date,                                                      -- see above for preferred position
   IsSecondDD varchar(5) default 'false' not null,                             -- see above for preferred position
   SecondScheduledDDDate date,                                                  -- see above for preferred position
   SecondDDStatusFailed varchar(5) default 'false' not null,                   -- see above for preferred position
   SecondDDStatusSucceeded varchar(5) default 'false' not null,                -- see above for preferred position
   SecondDDStatusDate date,                                                     -- see above for preferred position
   IsBPay varchar(5) default 'false' not null,                                 -- see above for preferred position
   BPayReference varchar(25),                                                  -- see above for preferred position
   BPayStatusFailed varchar(5) default 'false' not null,                       -- see above for preferred position
   BPayStatusSucceeded varchar(5) default 'false' not null,                    -- see above for preferred position
   BPayStatusDate date,                                                         -- see above for preferred position
   IsDirectCredit varchar(5) default 'false' not null,                         -- see above for preferred position
   DirectCreditStatusFailed varchar(5) default 'false' not null,               -- see above for preferred position
   DirectCreditStatusSucceeded varchar(5) default 'false' not null,            -- see above for preferred position
   DirectCreditStatusDate date,                                                 -- see above for preferred position
   ChequeBankedDate date,                                                       -- see above for preferred position
   OpsIssueRaisedTicked varchar(5) default 'false' not null,                   -- see above for preferred position
   OpsIssueRaisedDate date,                                                     -- see above for preferred position
   OpsIssueRaisedUserID varchar(12),                                           -- see above for preferred position
   OpsIssueResolvedTicked varchar(5) default 'false' not null,                 -- see above for preferred position
   OpsIssueResolvedDate date,                                                   -- see above for preferred position
   OpsIssueResolvedUserID varchar(12),                                         -- see above for preferred position
   OperationsComments1 varchar(200),                                           -- see above for preferred position
   OperationsComments2 varchar(200),                                           -- see above for preferred position
   OperationsComments3 varchar(200),                                           -- see above for preferred position
   OperationsComments4 varchar(200),                                           -- see above for preferred position
   OperationsComments5 varchar(200),                                           -- see above for preferred position
   OperationsComments6 varchar(200),                                           -- see above for preferred position
   OperationsComments7 varchar(200),                                           -- see above for preferred position
   OperationsComments8 varchar(200),                                           -- see above for preferred position
   OperationsComments9 varchar(200),                                           -- see above for preferred position
   OnboardingLastModifiedDate date,                                             -- see above for preferred position
   CreditLastModifiedDate date,                                                 -- see above for preferred position
   AMLLastModifiedDate date,                                                    -- see above for preferred position
   OperationsLastUser varchar(12),                                             -- see above for preferred position
   OperationsLastModifiedDate date,                                             -- see above for preferred position
   AdministrationLastUser varchar(12),                                         -- see above for preferred position
   AdministrationLastModifiedDate date,                                         -- see above for preferred position
   MasterLastUser varchar(12),                                                 -- see above for preferred position
   MasterLastModifiedDate date,                                                 -- see above for preferred position
   AdviserBonaFidesChecked varchar(5) default 'false',                         -- see above for preferred position
   AutomaticDirectDebitSuppressed varchar(5) default 'false',                  -- see above for preferred position
   FirstAmountReceived numeric(9,2),                                             -- see above for preferred position
   AmendedPaymentAmount numeric(9,2),                                            -- see above for preferred position
   InHouseAmount numeric(9,2)                                                    -- see above for preferred position
);

create table INVESTORINDIVIDUAL (
   ID serial primary key,
   INDIVIDUALID integer references individual on delete set null,
   APPLICATIONID integer references application on delete set null,
   ROLE varchar(25),                               -- xxxxxxxxxx  probably not wanted anymore
   ISAPPLICANT varchar(5) default 'true' not null,
   ISGUARANTOR varchar(5) default 'false' not null,
   ISDIRECTOR varchar(5) default 'false' not null,
   ISSOLEDIRECTOR varchar(5) default 'false' not null,     -- subordinate to ISDIRECTOR
   ISCOMPANYSECRETARY varchar(5) default 'false' not null, -- could also be a director
   ISTRUSTEE varchar(5) default 'false' not null,
   ISBENEFICIARY varchar(5) default 'false' not null,
   WEALTHBYEMPLOYMENT varchar(5) default 'false' not null,
   WEALTHBYINVESTMENTS varchar(5) default 'false' not null,
   WEALTHBYOTHER varchar(5) default 'false' not null,
   WEALTHBYOTHERINFO varchar(80)
);

create table SignificantUsers(
  UserID varchar(12) not null primary key,
  UserRole varchar(20) not null
);

create table StatusNarrative(
  StatusValue numeric(2) not null primary key,
  StatusText varchar(50) not null
);

create table AuditLog(
  UserID varchar(12) not null,
  Identification varchar(80) not null,
  Description varchar(2000) not null,
  RecordCreated date default now()
);

-- CREATE SEQUENCE  HIBERNATE_SEQUENCE
-- MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1
-- START WITH 1 NOCACHE  NOORDER  NOCYCLE;

create sequence hibernate_sequence
  start 1 increment 1 minvalue 1;

commit;
