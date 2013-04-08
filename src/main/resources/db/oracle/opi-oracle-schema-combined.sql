drop table investorindividual;
drop table advisorprovider;
drop table application;
drop table advisor;
drop table advisorfirm;
drop table individual;
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

-- Start of ACEGI Tables

CREATE TABLE "USERS" (
    "USERNAME" VARCHAR2(10) NOT NULL PRIMARY KEY,
    "PASSWORD" VARCHAR2(10) NOT NULL,
    "PASSWORDCONFIRMED" VARCHAR2(5) default 'false' not null,
    "ENABLED" VARCHAR2(5) default 'false' not null -- hibernate type boolean,yes_no,true_false
);

CREATE TABLE "AUTHORITIES" (
--    "ID" NUMBER(9) NOT NULL PRIMARY KEY,
    "USERNAME" VARCHAR2(10) NOT NULL,
    "AUTHORITY" VARCHAR2(50) NOT NULL,
    CONSTRAINT "UNIQUE_AUTH_USERNAME" UNIQUE("USERNAME","AUTHORITY")
);
alter table "AUTHORITIES"
       add constraint "AUTHORITIES_USERS_FK"
       foreign key ("USERNAME")
       references "USERS"("USERNAME")
       on delete cascade;

CREATE TABLE "ACL_OBJECT_IDENTITY" (
    "ID" NUMBER(9) NOT NULL PRIMARY KEY,
    "OBJECT_IDENTITY" VARCHAR2(250) NOT NULL, -- VARCHAR_IGNORECASE(250)
    "PARENT_OBJECT" NUMBER(32),
    "ACL_CLASS" VARCHAR2(250) NOT NULL, -- VARCHAR_IGNORECASE(250)
    CONSTRAINT "UNIQUE_OBJECT_IDENTITY" UNIQUE("OBJECT_IDENTITY"),
    FOREIGN KEY ("PARENT_OBJECT") REFERENCES "ACL_OBJECT_IDENTITY"("ID")
);

CREATE TABLE ACL_PERMISSION (
    "ID" NUMBER(9) NOT NULL PRIMARY KEY,
    "ACL_OBJECT_IDENTITY" NUMBER(32) NOT NULL,
    "RECIPIENT" VARCHAR2(100) NOT NULL, -- VARCHAR_IGNORECASE(100)
    "MASK" INTEGER NOT NULL,
    CONSTRAINT "UNIQUE_RECIPIENT" UNIQUE("ACL_OBJECT_IDENTITY", "RECIPIENT"),
    FOREIGN KEY ("ACL_OBJECT_IDENTITY") REFERENCES "ACL_OBJECT_IDENTITY"("ID")
);

-- End of ACEGI Tables

create table "COMPANY"(
   "ID" NUMBER(9) not null primary key,
   "TYPE" VARCHAR2(24),
   "NAME" VARCHAR2(80),
   "TRADINGNAME" VARCHAR2(80),
   "ADDRESS1" VARCHAR2(32),
   "ADDRESS2" VARCHAR2(32),
   "SUBURB" VARCHAR2(25),
   "STATE" VARCHAR2(3),
   "POSTCODE" VARCHAR2(4),
   "TELEPHONE" VARCHAR2(20),
   "TFN" VARCHAR2(9),
   "ABN" VARCHAR2(11),
   "ACN" VARCHAR2(9),
   "ARBN" VARCHAR2(11),
   "INCORPORATIONCOUNTRY" VARCHAR2(50),
   "INCORPORATIONDATE" DATE
);

create table "DEALERGROUP"(
   "ID" NUMBER(9) not null primary key,
   "COMPANYID" NUMBER(9),
   "AFSL" VARCHAR2(6),
   "ISDAAPPROVED" VARCHAR2(5) default 'false' not null,
   DealerGroupBonaFidesChecked VARCHAR2(5) default 'false'
);
alter table "DEALERGROUP"
   add constraint "DEALERGROUP_COMPANY_FK"
   foreign key ("COMPANYID")
   references "COMPANY"("ID")
   on delete cascade;

create table "TRUST"(
   "ID" NUMBER(9) not null primary key,
   "COMPANYID" NUMBER(9),
   "SOLICITORCOMPANYID" NUMBER(9),
   "SOLICITORNAME" VARCHAR2(25),
   "ISSUPERFUND" VARCHAR2(5) default 'false' not null,
   "REVIEWDEEDS" VARCHAR2(5) default 'false' not null,
   "WEALTHBYEMPLOYMENT" VARCHAR2(5) default 'false' not null,
   "WEALTHBYINVESTMENTS" VARCHAR2(5) default 'false' not null,
   "WEALTHBYOTHER" VARCHAR2(5) default 'false' not null,
   "WEALTHBYOTHERINFO" VARCHAR2(80)
);
alter table "TRUST"
   add constraint "TRUST_COMPANY_FK"
   foreign key ("COMPANYID")
   references "COMPANY"("ID")
   on delete set null;
alter table "TRUST"
   add constraint "TRUST_SOLICITOR_FK"
   foreign key ("SOLICITORCOMPANYID")
   references "COMPANY"("ID")
   on delete set null;

create table "PRODUCT"(
   "ID" NUMBER(9) not null primary key,
   "PROVIDERID" NUMBER(9),
   "NAME" VARCHAR2(40),
   "TYPE" VARCHAR2(24),
   "CLOSINGDATE" DATE,
   "PUTPRICE" NUMBER(6),
   "CALLPRICE" NUMBER(6),
   "CALLUNDERLYING" VARCHAR2(2),
   "SHORTDESC" VARCHAR2(120),
   "HASMINIMUMBASE" VARCHAR2(5) default 'false' not null,
   "HASMINIMUMINCREMENT" VARCHAR2(5) default 'false' not null,
   "LOWMINIMUM" NUMBER(9),
   "LOWINCREMENT" NUMBER(9),
   "HIGHMINIMUM" NUMBER(9),
   "HIGHINCREMENT" NUMBER(9),
   "MAXCOMMISSION" NUMBER(5,3),
   ProductFilePrefix VARCHAR2(3),
   FileSystemSubdirectory VARCHAR2(25),
   AnnualInterestRate NUMBER(7,2),
   AnnualIALInterestRate NUMBER(7,2),
   PutFeesRate NUMBER(7,2)
);
alter table "PRODUCT"
   add constraint "PRODUCT"
   foreign key ("PROVIDERID")
   references "COMPANY"("ID")
   on delete cascade ;

create table "INDIVIDUAL"(
   "ID" NUMBER(9) not null primary key,
   "USERNAME" VARCHAR2(10),
   "TITLE" VARCHAR2(4),
   "FIRSTNAME" VARCHAR2(24),
   "MIDDLENAME" VARCHAR2(24),
   "LASTNAME" VARCHAR2(24),
   "ADDRESS1" VARCHAR2(32),
   "ADDRESS2" VARCHAR2(32),
   "SUBURB" VARCHAR2(25),
   "STATE" VARCHAR2(3),
   "POSTCODE" VARCHAR2(4),
   "COUNTRY" VARCHAR2(50),
   "TFN" VARCHAR2(9),
   "ABN" VARCHAR2(11),
   "HOMEPHONE" VARCHAR2(20),
   "WORKPHONE" VARCHAR2(20),
   "MOBILEPHONE" VARCHAR2(20),
   "PERSONALFAX" VARCHAR2(20),
   "WORKFAX" VARCHAR2(20),
   "PERSONALEMAIL" VARCHAR2(50),
   "WORKEMAIL" VARCHAR2(50),
   "DATEOFBIRTH" DATE,
   "TOWNOFBIRTH" VARCHAR2(24),
   "COUNTRYOFBIRTH" VARCHAR2(50),
   "PASSPORTNO" VARCHAR2(24),
   "NATIONALITY" VARCHAR2(50),
   "DRIVERSLICENCENO" VARCHAR2(24),
   "OCCUPATION" VARCHAR2(24),
   "EMPLOYER" VARCHAR2(48)
);
alter table "INDIVIDUAL"
   add constraint "INDIVIDUAL_USERS_FK"
   foreign key ("USERNAME")
   references "USERS"("USERNAME")
   on delete cascade;

create table "ADVISORFIRM"(
   "ID" NUMBER(9) not null primary key,
   "DEALERGROUPID" NUMBER(9),
   "COMPANYID" NUMBER(9)
);
alter table "ADVISORFIRM"
   add constraint "ADVISORFIRM_COMPANY_FK"
   foreign key ("COMPANYID")
   references "COMPANY"("ID")
   on delete cascade;
alter table "ADVISORFIRM"
   add constraint "DEALERGROUP_ADVISORFIRM_FK"
   foreign key ("DEALERGROUPID")
   references "DEALERGROUP"("ID");

create table "ADVISOR"(
   "ID" NUMBER(9) not null primary key,
   "ISACTIVATED" VARCHAR2(5) default 'false' not null,
   "INDIVIDUALID" NUMBER(9),
   "ADVISORFIRMID" NUMBER(9),
   "ASSISTANTNAME" VARCHAR2(50),
   "ASSISTANTEMAIL" VARCHAR2(50),
   CheckAdviserDetails VARCHAR2(5) default 'false'
);
alter table "ADVISOR"
   add constraint "ADVISOR_ADVISORFIRM_FK"
   foreign key ("ADVISORFIRMID")
   references "ADVISORFIRM"("ID")
   on delete set null;
alter table "ADVISOR"
   add constraint "ADVISOR_INDIVIDUAL_FK"
   foreign key ("INDIVIDUALID")
   references "INDIVIDUAL"("ID")
   on delete set null;

create table "ADVISORPROVIDER" (
   "ID" NUMBER(9) not null primary key,
   "ADVISORID" NUMBER(9),
   "PROVIDERID" NUMBER(9),
   "INDIVIDUALID" NUMBER(9),
   "FIRSTNAME" VARCHAR2(24),                  -- BDM obsolete
   "MIDDLENAME" VARCHAR2(24),                 -- BDM obsolete
   "LASTNAME" VARCHAR2(24),                   -- BDM obsolete
   "TELEPHONE" VARCHAR2(20),                  -- BDM obsolete
   "EMAIL" VARCHAR2(50),                      -- BDM obsolete
   "ADVISORNUMBER" VARCHAR2(12)
);
alter table "ADVISORPROVIDER"
   add constraint "ADVISORPROVIDER_ADVISOR_FK"
   foreign key ("ADVISORID")
   references "ADVISOR"("ID")
   on delete cascade;
alter table "ADVISORPROVIDER"
   add constraint "ADVISORPROVIDER_PROVIDER_FK"
   foreign key ("PROVIDERID")
   references "COMPANY"("ID")
   on delete cascade;
alter table "ADVISORPROVIDER"
   add constraint "ADVISORPROVIDER_INDIVIDUAL_FK"
   foreign key ("INDIVIDUALID")
   references "INDIVIDUAL"("ID")
   on delete set null;

create table "APPLICATION"(
   "ID" NUMBER(9) not null primary key,
   "COMPANYID" NUMBER(9),
   "TRUSTID" NUMBER(9),
   "ADVISORID" NUMBER(9),
   "PRODUCTID" NUMBER(9),
   "COMMISSION" NUMBER(5,3),
   "APPLICATIONNUMBER" VARCHAR2(12),
   "CLIENTNUMBER" VARCHAR2(12),
   "ACCOUNTDESIGNATION" VARCHAR2(80),
   "FIRSTNAME" VARCHAR2(24),
   "MIDDLENAME" VARCHAR2(24),
   "LASTNAME" VARCHAR2(24),
   "HOMEPHONE" VARCHAR2(20),
   "WORKPHONE" VARCHAR2(20),
   "EMAIL" VARCHAR2(50),
   "FAX" VARCHAR2(20),
   "ADDRESS1" VARCHAR2(32),
   "ADDRESS2" VARCHAR2(32),
   "SUBURB" VARCHAR2(25),
   "STATE" VARCHAR2(3),
   "POSTCODE" VARCHAR2(4),
   "COUNTRY" VARCHAR2(50),
   "TYPE" NUMBER(1) not null,
   "APPLICATIONDATE" DATE,
   "APPLICATIONAMOUNT01" NUMBER(9),
   "APPLICATIONAMOUNT02" NUMBER(9),
   "APPLICATIONAMOUNT03" NUMBER(9),
   "APPLICATIONAMOUNT04" NUMBER(9),
   "APPLICATIONAMOUNT05" NUMBER(9),
   "APPROVEDAMOUNT01" NUMBER(9),
   "APPROVEDAMOUNT02" NUMBER(9),
   "APPROVEDAMOUNT03" NUMBER(9),
   "APPROVEDAMOUNT04" NUMBER(9),
   "APPROVEDAMOUNT05" NUMBER(9),
   --SoftCopyReceivedDate DATE,                                                 -- should be here, see lower
   --"RECORDCREATED" DATE default 'sysdate',                                    -- should have default, but filled by OPI instead
   "RECORDCREATED" DATE,
   "STATUS" NUMBER,
   "PAYMENTSTATUS" NUMBER,
   "ISBORROWINGFROMUBS" VARCHAR2(5) default 'false' not null,
   "ISPURCHASINGPUTFROMUBS" VARCHAR2(5) default 'false' not null,
   "ISIAL" VARCHAR2(5) default 'false' not null,
   "ISEITHERTOSIGN" VARCHAR2(5) default 'false' not null,
   "ISPAPERCOPYWANTED" VARCHAR2(5) default 'false' not null,
   "ISPROVIDERCUSTOMER" VARCHAR2(5) default 'false' not null,
   "ISLATEST" VARCHAR2(5) default 'true' not null,
   "REINVESTDISTRIBUTION" VARCHAR2(5) default 'false' not null,
   "DIRECTCREDITDISTRIBUTION" VARCHAR2(5) default 'false' not null,
   "PROVIDERUNITHOLDERNUMBER" VARCHAR2(25),
   "PROVIDERFUNDNAME" VARCHAR2(25),
   "ISUBSCUSTOMER" VARCHAR2(5) default 'false' not null,
   "UBSUNITHOLDERNUMBER" VARCHAR2(25),
   "UBSFUNDNAME" VARCHAR2(25),
   "DDAPPLICANT" VARCHAR2(80),
   "DDABN" VARCHAR2(11),
   "DDINSTITUTION" VARCHAR2(80),
   "DDINSTITUTIONADDRESS" VARCHAR2(80),
   "DDINSTITUTIONPOSTCODE" VARCHAR2(4),
   "DDINSTITUTIONSTATE" VARCHAR2(3),
   "DDINSTITUTIONSUBURB" VARCHAR2(25),
   "DDACCOUNTNAME" VARCHAR2(80),
   "DDBSB" VARCHAR2(6),
   "DDACCOUNTNO" VARCHAR2(10),
   -- assets
   "ICASH" NUMBER,
   "ISHARES" NUMBER,
   "IOTHERLIQUID" NUMBER,
   "IRESIDENTIALPROPERTY" NUMBER,
   "IINVESTMENTPROPERTY" NUMBER,
   "IOTHERASSETS" NUMBER,
   "IOTHERASSETSDETAILS" VARCHAR2(50),
   -- liabilities
   "IOTHERLOANSSECURED" NUMBER,
   "ILOANSRESIDENTIALPROPERTY" NUMBER,
   "ILOANSINVESTMENTPROPERTY" NUMBER,
   "ILOANSPERSONALUNSECURED" NUMBER,
   "IGUARANTEESGRANTED" NUMBER,
   "IOTHERLIABILITIES" NUMBER,
   "IOTHERLIABILITIESDETAILS" VARCHAR2(50),
   -- income
   "ISALARY" NUMBER,
   "IRENTALANDDIVIDEND" NUMBER,
   "IOTHERINCOME" NUMBER,
   "IOTHERINCOMEDETAILS" VARCHAR2(50),
   "ITAXPAYABLE" NUMBER,
   "ITAXPAYABLEDATE" DATE,
   -- expenditure
   "IINTERESTONSECUREDLOANS" NUMBER,
   "IINTERESTONUNSECUREDLOANS" NUMBER,
   "ILIVINGEXPENSES" NUMBER,
   "IOTHEREXPENSES" NUMBER,
   "IOTHEREXPENSESDETAILS" VARCHAR2(50),
   -- assets
   "GCASH" NUMBER,
   "GSHARES" NUMBER,
   "GOTHERLIQUID" NUMBER,
   "GRESIDENTIALPROPERTY" NUMBER,
   "GINVESTMENTPROPERTY" NUMBER,
   "GOTHERASSETS" NUMBER,
   "GOTHERASSETSDETAILS" VARCHAR2(50),
   -- liabilities
   "GOTHERLOANSSECURED" NUMBER,
   "GLOANSRESIDENTIALPROPERTY" NUMBER,
   "GLOANSINVESTMENTPROPERTY" NUMBER,
   "GLOANSPERSONALUNSECURED" NUMBER,
   "GGUARANTEESGRANTED" NUMBER,
   "GOTHERLIABILITIES" NUMBER,
   "GOTHERLIABILITIESDETAILS" VARCHAR2(50),
   -- income
   "GSALARY" NUMBER,
   "GRENTALANDDIVIDEND" NUMBER,
   "GOTHERINCOME" NUMBER,
   "GOTHERINCOMEDETAILS" VARCHAR2(50),
   "GTAXPAYABLE" NUMBER,
   "GTAXPAYABLEDATE" DATE,
   -- expenditure
   "GINTERESTONSECUREDLOANS" NUMBER,
   "GINTERESTONUNSECUREDLOANS" NUMBER,
   "GLIVINGEXPENSES" NUMBER,
   "GOTHEREXPENSES" NUMBER,
   "GOTHEREXPENSESDETAILS" VARCHAR2(50),
   -- PISA internal fields
   "ONBOARDINGSTATUS" INTEGER DEFAULT 0,
   "ONBOARDINGLASTUSER" VARCHAR2(12),
   --OnboardingLastModifiedDate Date,                                           -- should be here, see lower
   "ONBOARDINGCOMMENTS" VARCHAR2(600),
   "ONBOARDINGHARDCOPYSIGHTED" VARCHAR2(5) default 'false',
   --AdviserBonaFidesChecked VARCHAR2(5) default 'false',                       -- should be here, see lower
   "DADEALERGROUP" VARCHAR2(5) default 'false',
   "CREDITSTATUS" INTEGER DEFAULT 0,
   "CREDITLASTUSER" VARCHAR2(12),
   --CreditLastModifiedDate Date,                                               -- should be here, see lower
   "CREDITCOMMENTS" VARCHAR2(600),
   "CASAPPROVED" VARCHAR2(5) default 'false',
   "BAYCORPSAPPROVED" VARCHAR2(5) default 'false',
   --IsReferredToCRC VARCHAR2(5) default 'false'                                -- should be here, see lower
   "AMLSTATUS" INTEGER DEFAULT 0,
   "AMLLASTUSER" VARCHAR2(12),
   --AMLLastModifiedDate Date,                                                  -- should be here, see lower
   "AMLCOMMENTS" VARCHAR2(200),
   "AMLHARDCOPYSIGHTED" VARCHAR2(5) default 'false',
   "CREDITCHECKVERIFIED" VARCHAR2(5) default 'false',
   "GRIDCHECKVERIFIED" VARCHAR2(5) default 'false',
   "WORLDCHECKVERIFIED" VARCHAR2(5) default 'false',
   "GOOGLECHECKVERIFIED" VARCHAR2(5) default 'false',
   "CORPORATECHECKSVERIFIED" VARCHAR2(5) default 'false',
   "TRUSTCHECKSVERIFIED" VARCHAR2(5) default 'false',
   --OperationsLastUser VARCHAR2(12),                                           -- should be here, see lower
   --OperationsLastModifiedDate DATE,                                           -- should be here, see lower
   --AdministrationLastUser VARCHAR2(12),                                       -- should be here, see lower
   --AdministrationLastModifiedDate DATE,                                       -- should be here, see lower
   --MasterLastUser VARCHAR2(12),                                               -- should be here, see lower
   --MasterLastModifiedDate DATE,                                               -- should be here, see lower
   "OPERATIONSCOMMENTS" VARCHAR2(200),
   --OperationsComments1 VARCHAR2(200),                                         -- should be here, see lower
   --OperationsComments2 VARCHAR2(200),                                         -- should be here, see lower
   --OperationsComments3 VARCHAR2(200),                                         -- should be here, see lower
   --OperationsComments4 VARCHAR2(200),                                         -- should be here, see lower
   --OperationsComments5 VARCHAR2(200),                                         -- should be here, see lower
   --OperationsComments6 VARCHAR2(200),                                         -- should be here, see lower
   --OperationsComments7 VARCHAR2(200),                                         -- should be here, see lower
   --OperationsComments8 VARCHAR2(200),                                         -- should be here, see lower
   --OperationsComments9 VARCHAR2(200),                                         -- should be here, see lower
   "BANK3RDPARTYAUTHORISATION" INTEGER DEFAULT 0,
   "BILLINGAPPROVED" VARCHAR2(5) default 'false',
   --AutomaticDirectDebitSuppressed VARCHAR2(5) default 'false',                -- should be here, see lower
   "RECONCILEDBILLINGDATA" VARCHAR2(5) default 'false',
   "GENERATEDBILLINGDATA" VARCHAR2(5) default 'false',
   "AMOUNTDUEPAID" NUMBER(9,2),
   --AmountDue NUMBER(9,2),                                                     -- should be removed, see lower
   --NewAmountDue NUMBER(9,2),                                                  -- should be removed, see lower
   --FirstAmountReceived NUMBER(9,2),                                           -- should be here, see lower
   --AmendedPaymentAmount NUMBER(9,2),                                          -- should be here, see lower
   --InHouseAmount NUMBER(9,2),                                                 -- should be here, see lower
   "SCHEDULEDDDDATE" DATE,
   "DDPAYMENTSUCCESSFUL" VARCHAR2(5) default 'false',
   "DDUNSUCCESSFULREASON" VARCHAR2(100),
   --FirstDDStatusFailed VARCHAR2(5) default 'false',                           -- should be here, see lower
   --FirstDDStatusSucceeded VARCHAR2(5) default 'false',                        -- should be here, see lower
   --FirstDDStatusDate DATE,                                                    -- should be here, see lower
   --IsSecondDD VARCHAR2(5) default 'false' not null,                           -- should be here, see lower
   --SecondScheduledDDDate DATE,                                                -- should be here, see lower
   --SecondDDStatusFailed VARCHAR2(5) default 'false',                          -- should be here, see lower
   --SecondDDStatusSucceeded VARCHAR2(5) default 'false',                       -- should be here, see lower
   --SecondDDStatusDate DATE,                                                   -- should be here, see lower
   --IsBPay VARCHAR2(5) default 'false' not null,                               -- should be here, see lower
   --BPayReference VARCHAR2(25),                                                -- should be here, see lower
   --BPayStatusFailed VARCHAR2(5) default 'false',                              -- should be here, see lower
   --BPayStatusSucceeded VARCHAR2(5) default 'false',                           -- should be here, see lower
   --BPayStatusDate DATE,                                                       -- should be here, see lower
   --IsDirectCredit VARCHAR2(5) default 'false',                                -- should be here, see lower
   --DirectCreditStatusFailed VARCHAR2(5) default 'false',                      -- should be here, see lower
   --DirectCreditStatusSucceeded VARCHAR2(5) default 'false',                   -- should be here, see lower
   --DirectCreditStatusDate DATE,                                               -- should be here, see lower
   --ChequeBankedDate DATE,                                                     -- should be here, see lower
   --OpsIssueRaisedTicked VARCHAR2(5) default 'false',                          -- should be here, see lower
   --OpsIssueRaisedDate DATE,                                                   -- should be here, see lower
   --OpsIssueRaisedUserID VARCHAR2(12),                                         -- should be here, see lower
   --OpsIssueResolvedTicked VARCHAR2(5) default 'false',                        -- should be here, see lower
   --OpsIssueResolvedDate DATE,                                                 -- should be here, see lower
   --OpsIssueResolvedUserID VARCHAR2(12),                                       -- should be here, see lower
   "INITIALPAYMENTBYCHEQUE" VARCHAR2(5) default 'false',
   "PAYMENTBYALTERNATIVEMEANS" NUMBER(9,2),
   --ChequeForUBSAttached VARCHAR2(5) default 'false',                          -- should be here, see lower
   --ChequeAmount NUMBER(9,2),                                                  -- should be here, see lower
   --ChequeReturned VARCHAR2(5) default 'false',                                -- should be here, see lower
   --ChequeAccepted VARCHAR2(5) default 'false',                                -- should be here, see lower
   "CONDUCTEDBILLING" VARCHAR2(5) default 'false',
   "GENERATEDAPPROVALLETTER" VARCHAR2(5) default 'false',
   "GENERATEDREJECTIONLETTER" VARCHAR2(5) default 'false',
   "ADMINISTRATIONCOMMENTS" VARCHAR2(200),
   "ONBOARDINGINFO1SATISFIED" VARCHAR2(5) default 'false',
   "ONBOARDINGINFO1COMMENTARY" VARCHAR2(250),
   "ONBOARDINGINFO2SATISFIED" VARCHAR2(5) default 'false',
   "ONBOARDINGINFO2COMMENTARY" VARCHAR2(250),
   "ONBOARDINGINFO3SATISFIED" VARCHAR2(5) default 'false',
   "ONBOARDINGINFO3COMMENTARY" VARCHAR2(250),
   "CREDITINFO1SATISFIED" VARCHAR2(5) default 'false',
   "CREDITINFO1COMMENTARY" VARCHAR2(250),
   "CREDITINFO2SATISFIED" VARCHAR2(5) default 'false',
   "CREDITINFO2COMMENTARY" VARCHAR2(250),
   "CREDITINFO3SATISFIED" VARCHAR2(5) default 'false',
   "CREDITINFO3COMMENTARY" VARCHAR2(250),
   "AMLINFO1SATISFIED" VARCHAR2(5) default 'false',
   "AMLINFO1COMMENTARY" VARCHAR2(250),
   "AMLINFO2SATISFIED" VARCHAR2(5) default 'false',
   "AMLINFO2COMMENTARY" VARCHAR2(250),
   "AMLINFO3SATISFIED" VARCHAR2(5) default 'false',
   "AMLINFO3COMMENTARY" VARCHAR2(250),
   "ONBOARDINGINFONOTYETCHECKED" VARCHAR2(5) default 'false',
   "CREDITINFONOTYETCHECKED" VARCHAR2(5) default 'false',
   "AMLINFONOTYETCHECKED" VARCHAR2(5) default 'false',
   "BAYCORPRECORDCREATED" VARCHAR2(5) default 'false',
   "ASICCOMPANYSEARCH" VARCHAR2(5) default 'false',
   "ATOREGISTRATION" VARCHAR2(5) default 'false',
   "TRUSTDEEDAPPROVED" VARCHAR2(5) default 'false',
   "APPLICANT1APPROVED" VARCHAR2(5) default 'false',
   "APPLICANT1MATERIAL" VARCHAR2(5) default 'false',
   "APPLICANT1IMMATERIAL" VARCHAR2(5) default 'false',
   "APPLICANT1NOHIT" VARCHAR2(5) default 'false',
   "APPLICANT1NOTAPPLICABLE" VARCHAR2(5) default 'false',
   "APPLICANT2APPROVED" VARCHAR2(5) default 'false',
   "APPLICANT2MATERIAL" VARCHAR2(5) default 'false',
   "APPLICANT2IMMATERIAL" VARCHAR2(5) default 'false',
   "APPLICANT2NOHIT" VARCHAR2(5) default 'false',
   "APPLICANT2NOTAPPLICABLE" VARCHAR2(5) default 'false',
   "COMPANYAPPROVED" VARCHAR2(5) default 'false',
   "COMPANYMATERIAL" VARCHAR2(5) default 'false',
   "COMPANYIMMATERIAL" VARCHAR2(5) default 'false',
   "COMPANYNOHIT" VARCHAR2(5) default 'false',
   "COMPANYNOTAPPLICABLE" VARCHAR2(5) default 'false',
   "OTHERPERSONSAPPROVED" VARCHAR2(5) default 'false',
   "OTHERPERSONSMATERIAL" VARCHAR2(5) default 'false',
   "OTHERPERSONSIMMATERIAL" VARCHAR2(5) default 'false',
   "OTHERPERSONSNOHIT" VARCHAR2(5) default 'false',
   "OTHERPERSONSNOTAPPLICABLE" VARCHAR2(5) default 'false',
   "INFORMATIONNOTIFICATIONDATE" DATE,
   "CONDITIONALNOTIFICATIONDATE" DATE,
   "APPROVALNOTIFICATIONDATE" DATE,
   "APPLICATIONWITHDRAWN" VARCHAR2(5) default 'false',
   "APPLICATIONDELETED" VARCHAR2(5) default 'false',
   "BAYCORP1FILECREATED" VARCHAR2(5) default 'false',
   "GRIDCHECK1APPROVED" VARCHAR2(5) default 'false',
   "WORLDCHECK1APPROVED" VARCHAR2(5) default 'false',
   "GOOGLECHECK1APPROVED" VARCHAR2(5) default 'false',
   "ASICDIRECTOR1CHECK" VARCHAR2(5) default 'false',
   "ASICBENEFICIARY1CHECK" VARCHAR2(5) default 'false',
   "BAYCORP2FILECREATED" VARCHAR2(5) default 'false',
   "GRIDCHECK2APPROVED" VARCHAR2(5) default 'false',
   "WORLDCHECK2APPROVED" VARCHAR2(5) default 'false',
   "GOOGLECHECK2APPROVED" VARCHAR2(5) default 'false',
   "ASICDIRECTOR2CHECK" VARCHAR2(5) default 'false',
   "ASICBENEFICIARY2CHECK" VARCHAR2(5) default 'false',
   "SUPERFUNDREGISTRATIONCHECK" VARCHAR2(5) default 'false',
   "NOTIFICATIONDATE" DATE,
   "ONBOARDINGLOCK" VARCHAR2(12),
   "CREDITLOCK" VARCHAR2(12),
   "AMLLOCK" VARCHAR2(12),
   "MAINLOCK" VARCHAR2(12),
   "CREATEDBY" VARCHAR2(10),
   "MODIFIEDBY" VARCHAR2(10),
   "RecordModified" date
   SoftCopyReceivedDate DATE,                                                   -- see above for preferred position
   ChequeForUBSAttached VARCHAR2(5) default 'false' not null,                   -- see above for preferred position
   ChequeAmount NUMBER(9,2),                                                    -- see above for preferred position
   ChequeReturned VARCHAR2(5) default 'false' not null,                         -- see above for preferred position
   ChequeAccepted VARCHAR2(5) default 'false' not null,                         -- see above for preferred position
   IsReferredToCRC VARCHAR2(5) default 'false' not null,                        -- see above for preferred position
   AmountDue NUMBER(9,2),                                                       -- to be removed
   NewAmountDue NUMBER(9,2),                                                    -- to be removed
   FirstDDStatusFailed VARCHAR2(5) default 'false' not null,                    -- see above for preferred position
   FirstDDStatusSucceeded VARCHAR2(5) default 'false' not null,                 -- see above for preferred position
   FirstDDStatusDate DATE,                                                      -- see above for preferred position
   IsSecondDD VARCHAR2(5) default 'false' not null,                             -- see above for preferred position
   SecondScheduledDDDate DATE,                                                  -- see above for preferred position
   SecondDDStatusFailed VARCHAR2(5) default 'false' not null,                   -- see above for preferred position
   SecondDDStatusSucceeded VARCHAR2(5) default 'false' not null,                -- see above for preferred position
   SecondDDStatusDate DATE,                                                     -- see above for preferred position
   IsBPay VARCHAR2(5) default 'false' not null,                                 -- see above for preferred position
   BPayReference VARCHAR2(25),                                                  -- see above for preferred position
   BPayStatusFailed VARCHAR2(5) default 'false' not null,                       -- see above for preferred position
   BPayStatusSucceeded VARCHAR2(5) default 'false' not null,                    -- see above for preferred position
   BPayStatusDate DATE,                                                         -- see above for preferred position
   IsDirectCredit VARCHAR2(5) default 'false' not null,                         -- see above for preferred position
   DirectCreditStatusFailed VARCHAR2(5) default 'false' not null,               -- see above for preferred position
   DirectCreditStatusSucceeded VARCHAR2(5) default 'false' not null,            -- see above for preferred position
   DirectCreditStatusDate DATE,                                                 -- see above for preferred position
   ChequeBankedDate DATE,                                                       -- see above for preferred position
   OpsIssueRaisedTicked VARCHAR2(5) default 'false' not null,                   -- see above for preferred position
   OpsIssueRaisedDate DATE,                                                     -- see above for preferred position
   OpsIssueRaisedUserID VARCHAR2(12),                                           -- see above for preferred position
   OpsIssueResolvedTicked VARCHAR2(5) default 'false' not null,                 -- see above for preferred position
   OpsIssueResolvedDate DATE,                                                   -- see above for preferred position
   OpsIssueResolvedUserID VARCHAR2(12),                                         -- see above for preferred position
   OperationsComments1 VARCHAR2(200),                                           -- see above for preferred position
   OperationsComments2 VARCHAR2(200),                                           -- see above for preferred position
   OperationsComments3 VARCHAR2(200),                                           -- see above for preferred position
   OperationsComments4 VARCHAR2(200),                                           -- see above for preferred position
   OperationsComments5 VARCHAR2(200),                                           -- see above for preferred position
   OperationsComments6 VARCHAR2(200),                                           -- see above for preferred position
   OperationsComments7 VARCHAR2(200),                                           -- see above for preferred position
   OperationsComments8 VARCHAR2(200),                                           -- see above for preferred position
   OperationsComments9 VARCHAR2(200),                                           -- see above for preferred position
   OnboardingLastModifiedDate Date,                                             -- see above for preferred position
   CreditLastModifiedDate Date,                                                 -- see above for preferred position
   AMLLastModifiedDate Date,                                                    -- see above for preferred position
   OperationsLastUser VARCHAR2(12),                                             -- see above for preferred position
   OperationsLastModifiedDate DATE,                                             -- see above for preferred position
   AdministrationLastUser VARCHAR2(12),                                         -- see above for preferred position
   AdministrationLastModifiedDate DATE,                                         -- see above for preferred position
   MasterLastUser VARCHAR2(12),                                                 -- see above for preferred position
   MasterLastModifiedDate DATE,                                                 -- see above for preferred position
   AdviserBonaFidesChecked VARCHAR2(5) default 'false',                         -- see above for preferred position
   AutomaticDirectDebitSuppressed VARCHAR2(5) default 'false',                  -- see above for preferred position
   FirstAmountReceived NUMBER(9,2),                                             -- see above for preferred position
   AmendedPaymentAmount NUMBER(9,2),                                            -- see above for preferred position
   InHouseAmount NUMBER(9,2)                                                    -- see above for preferred position
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

create table "INVESTORINDIVIDUAL"(
   "ID" NUMBER(9) not null primary key,
   "INDIVIDUALID" NUMBER(9),
   "APPLICATIONID" NUMBER(9),
   "ROLE" VARCHAR2(25),                               -- xxxxxxxxxx  probably not wanted anymore
   "ISAPPLICANT" VARCHAR2(5) default 'true' not null,
   "ISGUARANTOR" VARCHAR2(5) default 'false' not null,
   "ISDIRECTOR" VARCHAR2(5) default 'false' not null,
   "ISSOLEDIRECTOR" VARCHAR2(5) default 'false' not null,     -- subordinate to ISDIRECTOR
   "ISCOMPANYSECRETARY" VARCHAR2(5) default 'false' not null, -- could also be a director
   "ISTRUSTEE" VARCHAR2(5) default 'false' not null,
   "ISBENEFICIARY" VARCHAR2(5) default 'false' not null,
   "WEALTHBYEMPLOYMENT" VARCHAR2(5) default 'false' not null,
   "WEALTHBYINVESTMENTS" VARCHAR2(5) default 'false' not null,
   "WEALTHBYOTHER" VARCHAR2(5) default 'false' not null,
   "WEALTHBYOTHERINFO" VARCHAR2(80)
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

create table SignificantUsers(
  UserID VARCHAR2(12) not null primary key,
  UserRole VARCHAR2(20) not null
);

create table StatusNarrative(
  StatusValue number(2) not null primary key,
  StatusText VARCHAR2(50) not null
);

create table AuditLog(
  UserID VARCHAR2(12) not null,
  Identification VARCHAR2(80) not null,
  Description VARCHAR2(2000) not null,
  RecordCreated date default sysdate
);

CREATE SEQUENCE  "HIBERNATE_SEQUENCE"
MINVALUE 1 MAXVALUE 1.00000000000000E+27 INCREMENT BY 1
START WITH 1 NOCACHE  NOORDER  NOCYCLE;

commit;