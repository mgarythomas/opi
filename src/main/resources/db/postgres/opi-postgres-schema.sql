drop table advisor cascade;                  -- level 4
drop table applicationdirectcreditdetails;   -- level 4         -- added - new 1112
drop table bank;                             -- level 4         -- added - new 1112
drop table advisorfirm;                      -- level 3
drop table individual cascade;               -- level 2         -- level changed, was 3
drop table product cascade;                  -- level 2
drop table trust cascade;                    -- level 2         -- renamed
drop table dealergroup;                      -- level 2
drop table role;                             -- level 2         -- level changed, was 1
drop table authorities;                      -- level 2         -- 
drop table company cascade;                  -- level 1
--drop table logon;                            -- level 1         -- level changed, was 2
drop table users;                            -- level 1         -- 
drop table application cascade;              -- level 1         -- added
drop table investorindividual;               -- level 1         -- added
drop table advisorindividual;                -- level 1         -- added
drop table advisorprovider;                  -- level 1

drop sequence hibernate_sequence;

create table users(                          -- level 1 - new 1112
  username varchar(10) primary key,
  password varchar(10),
  passwordconfirmed varchar(5) default 'FALSE' not null,
  enabled varchar(5) default 'FALSE' not null,
  email varchar(40) default '' not null
);

-- acegi object
--create table logon(                          -- level 1, was 2
--  id serial primary key,       -- was numeric
--  username varchar(10),        -- might be unique
--  pwd varchar(10),
--  email varchar(40) default '' not null
--);

create table company(                        -- level 1
  id serial primary key,
  type varchar(24), -- [ FundManager, CompanyInvestor, DealerGroup, AdvisorFirm, Solicitor(Firm) ]  -- moved
  name varchar(80),             -- was 37
  tradingname varchar(80),      -- new 1112
  address1 varchar(32),         -- was 4
  address2 varchar(32),         -- new 1112
  suburb varchar(25),           -- was 4
  state varchar(3),             -- new
  postcode varchar(4),          -- was int,
  telephone varchar(20),        -- was bigint, was 10 1112
  tfn varchar(9),               -- was bigint,
  abn varchar(11),              -- was bigint,
  acn varchar(9),               -- was bigint
  arbn varchar(11),             -- new,
  incorporationcountry varchar(50), -- new, was 20 1112
  incorporationdate date        -- new
);

--create table role(                           -- level 2, was 1
--  id serial primary key,
--  logonid integer references logon on delete set null,
--  rolename varchar(12) default '' not null
--);

create table authorities(                           -- level 2 - new 1112
  username varchar(10) references users,
  authority varchar(50),
  primary key(username,authority)
);

create table dealergroup(                    -- level 2
  id serial primary key,
  afsl varchar(6), -- was integer 1112
  isdaapproved varchar(5) default 'FALSE' not null, -- new
  companyid integer references company on delete cascade
);

create table trust(                          -- level 2  -- renamed
  id serial primary key,
  companyid integer references company on delete set null, -- new
  solicitorcompanyid integer references company on delete set null, -- renamed
  solicitorname varchar(25), -- new
  issuperfund varchar(5) default 'FALSE' not null, -- new 1112
  reviewdeeds varchar(5) default 'FALSE' not null, -- new 1112
  wealthbyemployment varchar(5) default 'FALSE' not null, -- new 1112
  wealthbyinvestments varchar(5) default 'FALSE' not null, -- new 1112
  wealthbyother varchar(5) default 'FALSE' not null, -- new 1112
  wealthbyotherinfo varchar(80), -- new 1112
  beneficiaries varchar(80)
);

create table product(                        -- level 2
  id serial primary key,
  providerid integer references company on delete cascade, -- check if null?
  name varchar(40), -- was 24
  type varchar(24),
  code varchar(20),
  closingdate date,
  putprice numeric(6),
  callprice numeric(6),
  callunderlying varchar(2),
  -- what is type?
  shortdesc varchar(120),
  -- what goes in shortdesc?
  hasMinimumBase varchar(5) default 'FALSE' not null, -- check (hasMinimumBase in ('Y', 'N')), -- was BIT want Boolean -- moved
  hasMinimumIncrement  varchar(5) default 'FALSE' not null, -- check (hasMinimumIncrement in ('Y', 'N')) -- was BIT want Boolean -- moved
  -- where are the above two defined?
  lowminimum numeric(9), -- new 1112
  lowincrement numeric(9), -- new 1112
  highminimum numeric(9), -- new 1112
  highincrement numeric(9), -- new 1112
  maxcommission numeric(5,3) -- new 1112
);

create table individual(                     -- level 3
  id serial primary key,
--  logonid integer references logon on delete set null,
--  username varchar(10) unique references logon(username) on delete set null, -- new 1112
  username varchar(10) references users on delete set null, -- new 1112
  title varchar(4),             -- new
  firstname varchar(24),
  middlename varchar(24),
  lastname varchar(24),
  address1 varchar(32),
  address2 varchar(32), -- new 1112
  suburb varchar(25),           -- moved
  state varchar(3),             -- new
  postcode varchar(4),          -- was int
  country varchar(50),          -- new -- was 20
  tfn varchar(9),               -- new
  abn varchar(11),               -- new
  homephone varchar(20),        -- was bigint -- renamed
  workphone varchar(20),        -- new
  mobilephone varchar(20),      -- new
  personalfax varchar(20),      -- new
  workfax varchar(20),          -- new
  personalemail varchar(50),    -- new
  workemail varchar(50),        -- new
  dateOfBirth date,
  townOfBirth varchar(24),
  countryOfBirth varchar(50),
  passportNo varchar(24),
  nationality varchar(50),
  driversLicenceNo varchar(24),
  occupation varchar(24),
  employer varchar(24)         -- new
  -- wealthbyemployment char(1) default 'N', -- not null check (wealthbyemployment in ('Y', 'N')), -- new
  -- wealthbyinvestments char(1) default 'N', -- not null check (wealthbyinvestments in ('Y', 'N')), -- new
  -- wealthbyother char(1) default 'N', -- not null check (wealthbyother in ('Y', 'N')), -- new
  -- wealthbyotherinfo varchar(80) --new
  -- type varchar(4),
  -- can be [advisor, investor, (assistant advisor), administrator]
  -- !! no it can't - an individual can be many things
);

create table advisorfirm(                    -- level 3
  id serial primary key,
  dealergroupid integer references dealergroup,
  companyid integer references company on delete cascade
);

create table advisor(                  -- level 4
  id serial primary key,
  individualid integer references individual on delete set null,
  advisorfirmid integer references advisorfirm on delete set null,
  isactivated varchar(5) default 'FALSE' not null, -- new 1112
  assistantname varchar(50), -- new 1112
  assistantemail varchar(50) -- new 1112
);

create table application(               -- level 5
  id serial primary key,
  companyid integer references company on delete set null,
  trustid integer references trust on delete set null,
  advisorid integer references advisor on delete set null,
  productid integer references product on delete set null,

--  name varchar(74),                                                        -- was 24
--  address1 varchar(32),  -- new
--  suburb varchar(25),    -- new
--  state varchar(3),      -- new
--  postcode varchar(4),   -- new
--  type numeric(1,0) not null check (type between 0 and 5),                  -- was varchar(4) default '' not null,
       -- 0: individual, 1: individual trust, 2: corporate trust, 3: corporate, 4: super fund (corporate), 5: super fund (individual)
--  applicationDate date,
--  amount int,

-- Start of New
  commission numeric(5, 3),
  applicationnumber varchar(12),
  clientnumber varchar(12),
  accountdesignation varchar(80),
  firstname varchar(24),
  middlename varchar(24),
  lastname varchar(24),
  homephone varchar(20),
  workphone varchar(20),
  email varchar(50),
  fax varchar(20),
  address1 varchar(32),
  address2 varchar(32),
  suburb varchar(25),
  state varchar(3),
  postcode varchar(4),
  country varchar(50),
  type numeric(1, 0) not null, 
  applicationamount01 numeric(9,0),
  applicationamount02 numeric(9,0),
  applicationamount03 numeric(9,0),
  applicationamount04 numeric(9,0),
  applicationamount05 numeric(9,0),
  approvedamount01 numeric(9,0),
  approvedamount02 numeric(9,0),
  approvedamount03 numeric(9,0),
  approvedamount04 numeric(9,0),
  approvedamount05 numeric(9,0),
  recordCreated date,
-- end of New

  status  numeric(22, 0), -- int,            -- renamed
  paymentstatus  numeric(22, 0), -- int,            -- new
  isBorrowingFromUbs varchar(5) default 'FALSE' not null, -- check (isBorrowingFromUbs in ('Y', 'N')), -- char(1) -- was BIT want Boolean
  isPurchasingPutFromUbs varchar(5) default 'FALSE' not null, -- check (isPurchasingPutFromUbs in ('Y', 'N')), -- was BIT want Boolean
  isIAL varchar(5) default 'FALSE' not null, -- check (isIAL in ('Y', 'N')), -- new
  isEitherToSign varchar(5) default 'FALSE' not null, -- check (isEitherToSign in ('Y', 'N')), -- was BIT want Boolean

  ispapercopywanted varchar(5) default 'FALSE' not null, -- new
  isprovidercustomer varchar(5) default 'FALSE' not null, -- new
  islatest varchar(5) default 'FALSE' not null, -- new
  reinvestdistribution varchar(5) default 'FALSE' not null, -- new
  directcreditdistribution varchar(5) default 'FALSE' not null, -- new
  
--  isUbsToSightTrustDeed char(1) default 'N' not null check (isUbsToSightTrustDeed in ('Y', 'N')), -- was BIT want Boolean
--  isOneOfficerToSign char(1) default 'N' not null check (isOneOfficerToSign in ('Y', 'N')), -- new
--  isDirectCredit char(1) default 'N' not null check (isDirectCredit in ('Y', 'N')), -- new
--  isPaperCopyWanted char(1) default 'N' not null check (isPaperCopyWanted in ('Y', 'N')), -- replaces next line
  --financialReportSendMethod varchar(24), replaced by previous
--  isProviderCustomer char(1) default 'N' not null check (isproviderCustomer in ('Y', 'N')), -- new

  providerunitholdernumber varchar(25), -- new

  providerfundname varchar(25), -- new
  isUBSCustomer varchar(5) default 'FALSE' not null, -- check (isUBSCustomer in ('Y', 'N')), -- new
  ubsunitholdernumber varchar(25), -- new -- was numeric
  ubsfundname varchar(25), -- new
  --yearTaxPayable date, -- removed
  ddApplicant varchar(80), -- new
  ddABN varchar(11), -- new
  ddInstitution varchar(80), -- new
  ddInstitutionAddress varchar(37), -- new
  ddinstitutionpostcode varchar(4), -- new
  ddinstitutionstate varchar(3), -- new
  ddinstitutionsuburb varchar(25), -- new
  ddAccountName varchar(80), -- new
  ddBSB varchar(6), -- new
  ddAccountNo varchar(11), -- new
  ddAccountType varchar(80),
  -- assets
  iCash numeric(22, 0),
  iShares numeric(22, 0),
  iOtherLiquid numeric(22, 0), -- moved
  iResidentialProperty numeric(22, 0),
  iInvestmentProperty numeric(22, 0),
  iOtherAssets numeric(22, 0), -- new
  iOtherAssetsDetails varchar(50), -- new
  -- liabilities
  iOtherLoansSecured numeric(22, 0), -- moved
  iLoansResidentialProperty numeric(22, 0),
  iLoansInvestmentProperty numeric(22, 0),
  iLoansPersonalUnsecured numeric(22, 0), -- spelling fixed
  iGuaranteesGranted numeric(22, 0),
  iOtherLiabilities numeric(22, 0), -- new
  iOtherLiabilitiesDetails varchar(50), -- new
  -- income
  iSalary numeric(22, 0),
  iRentalAndDividend numeric(22, 0),
  iOtherIncome numeric(22, 0), -- moved
  iOtherIncomeDetails varchar(50), -- new
  iTaxPayable numeric(22, 0),
  iTaxPayableDate date, -- new
  -- expenditure
  iInterestOnSecuredLoans numeric(22, 0),
  iInterestOnUnsecuredLoans numeric(22, 0),
  iLivingExpenses numeric(22, 0),
  iOtherExpenses numeric(22, 0),
  iOtherExpensesDetails varchar(50), -- new
  
  -- see FinancialInformation
  -- assets
  gCash numeric(22, 0),
  gShares numeric(22, 0),
  gOtherLiquid numeric(22, 0), -- moved
  gResidentialProperty numeric(22, 0),
  gInvestmentProperty numeric(22, 0),
  gOtherAssets numeric(22, 0), -- new
  gOtherAssetsDetails varchar(50), -- new
  -- liabilities
  gOtherLoansSecured numeric(22, 0), -- moved
  gLoansResidentialProperty numeric(22, 0),
  gLoansInvestmentProperty numeric(22, 0),
  gLoansPersonalUnsecured numeric(22, 0), -- spelling fixed
  gGuaranteesGranted numeric(22, 0),
  gOtherLiabilities numeric(22, 0), -- new
  gOtherLiabilitiesDetails varchar(50), -- new
  -- income
  gSalary numeric(22, 0),
  gRentalAndDividend numeric(22, 0),
  gOtherIncome numeric(22, 0), -- moved
  gOtherIncomeDetails varchar(50), -- new
  gTaxPayable numeric(22, 0),
  gTaxPayableDate date, -- new
  -- expenditure
  gInterestOnSecuredLoans numeric(22, 0),
  gInterestOnUnsecuredLoans numeric(22, 0),
  gLivingExpenses numeric(22, 0),
  gOtherExpenses numeric(22, 0),
  gOtherExpensesDetails varchar(50), -- new
  
-- Start of New  
  onboardingstatus numeric(22, 0),
  onboardinglastuser varchar(12),
  onboardingcomments varchar(300),
  onboardinghardcopysighted varchar(5),
  dadealergroup varchar(5),
  creditstatus numeric(22, 0),
  creditlastuser varchar(12),
  creditcomments varchar(300),
  casapproved varchar(5),
  baycorpsapproved varchar(5),
  amlstatus numeric(22, 0),
  amllastuser varchar(12),
  amlcomments varchar(200),
  amlhardcopysighted varchar(5),
  creditcheckverified varchar(5),
  gridcheckverified varchar(5),
  worldcheckverified varchar(5),
  googlecheckverified varchar(5),
  corporatechecksverified varchar(5),
  trustchecksverified varchar(5),
  operationscomments varchar(200),
  bank3rdpartyauthorisation numeric(22, 0),
  billingapproved varchar(5),
  reconciledbillingdata varchar(5),
  generatedbillingdata varchar(5),
  amountduepaid varchar(10),
  scheduleddddate date,
  ddpaymentsuccessful varchar(5),
  ddunsuccessfulreason varchar(60),
  initialpaymentbycheque varchar(5),
  paymentbyalternativemeans numeric(9),
  conductedbilling varchar(5),
  generatedapprovalletter varchar(5),
  generatedrejectionletter varchar(5),
  administrationcomments varchar(200),
  onboardinginfo1satisfied varchar(5),
  onboardinginfo1commentary varchar(250),
  onboardinginfo2satisfied varchar(5),
  onboardinginfo2commentary varchar(250),
  onboardinginfo3satisfied varchar(5),
  onboardinginfo3commentary varchar(250),
  creditinfo1satisfied varchar(5),
  creditinfo1commentary varchar(250),
  creditinfo2satisfied varchar(5),
  creditinfo2commentary varchar(250),
  creditinfo3satisfied varchar(5),
  creditinfo3commentary varchar(250),
  amlinfo1satisfied varchar(5),
  amlinfo1commentary varchar(250),
  amlinfo2satisfied varchar(5),
  amlinfo2commentary varchar(250),
  amlinfo3satisfied varchar(5),
  amlinfo3commentary varchar(250),
  onboardinginfonotyetchecked varchar(5),
  creditinfonotyetchecked varchar(5),
  amlinfonotyetchecked varchar(5),
  baycorprecordcreated varchar(5),
  asiccompanysearch varchar(5),
  atoregistration varchar(5),
  trustdeedapproved varchar(5),
  applicant1approved varchar(5),
  applicant1material varchar(5),
  applicant1immaterial varchar(5),
  applicant1nohit varchar(5),
  applicant1notapplicable varchar(5),
  applicant2approved varchar(5),
  applicant2material varchar(5),
  applicant2immaterial varchar(5),
  applicant2nohit varchar(5),
  applicant2notapplicable varchar(5),
  companyapproved varchar(5),
  companymaterial varchar(5),
  companyimmaterial varchar(5),
  companynohit varchar(5),
  companynotapplicable varchar(5),
  otherpersonsapproved varchar(5),
  otherpersonsmaterial varchar(5),
  otherpersonsimmaterial varchar(5),
  otherpersonsnohit varchar(5),
  otherpersonsnotapplicable varchar(5),
  informationnotificationdate date,
  conditionalnotificationdate date,
  approvalnotificationdate date,
  applicationwithdrawn varchar(5),
  applicationdeleted varchar(5),
  baycorp1filecreated varchar(5),
  gridcheck1approved varchar(5),
  worldcheck1approved varchar(5),
  googlecheck1approved varchar(5),
  asicdirector1check varchar(5),
  asicbeneficiary1check varchar(5),
  baycorp2filecreated varchar(5),
  gridcheck2approved varchar(5),
  worldcheck2approved varchar(5),
  googlecheck2approved varchar(5),
  asicdirector2check varchar(5),
  asicbeneficiary2check varchar(5),
  superfundregistrationcheck varchar(5),
  notificationdate date,
  onboardinglock varchar(12),
  creditlock varchar(12),
  amllock varchar(12),
  mainlock varchar(12),
  applicationdate date,
  createdby varchar(10),
  modifiedby varchar(10),
  recordModified date,
  softcopyreceiveddate date,
  chequeforubsattached varchar(5),
--  chequeamount
  chequereturned varchar(5),
  chequeaccepted varchar(5),
  isreferredtocrc varchar(5),
  firstddstatusfailed varchar(5),
  firstddstatussucceeded varchar(5),
  firstddstatusdate date,
  isseconddd varchar(5),
  secondscheduleddddate date,
  secondddstatusfailed varchar(5),
  secondddstatussucceeded varchar(5),
  secondddstatusdate date,
  isbpay varchar(5),
  bpayreference varchar(25),
  bpaystatusfailed varchar(5),
  bpaystatussucceeded varchar(5),
  bpaystatusdate date,
  isdirectcredit varchar(5),
  directcreditstatusfailed varchar(5),
  directcreditstatussucceeded varchar(5),
  directcreditstatusdate date,
  chequebankeddate date,
  opsissueraisedticked varchar(5),
  opsissueraiseddate date,
  opsissueraiseduserid varchar(12), 
  opsissueresolvedticked varchar(5),
  opsissueresolveddate date,
  opsissueresolveduserid varchar(12),
  operationscomments1 varchar(200),
  operationscomments2 varchar(200),
  operationscomments3 varchar(200),
  operationscomments4 varchar(200),
  operationscomments5 varchar(200),
  operationscomments6 varchar(200),
  operationscomments7 varchar(200),
  operationscomments8 varchar(200),
  operationscomments9 varchar(200),
  onboardinglastmodifieddate date,
  creditlastmodifieddate date,
  amllastmodifieddate date,
  operationslastuser varchar(12),
  operationslastmodifieddate date,
  administrationlastuser varchar(12),
  administrationlastmodifieddate date,
  masterlastuser varchar(12),
  masterlastmodifieddate date,
  adviserbonafideschecked varchar(5),
  automaticdirectdebitsuppressed varchar(5)
-- End New
);

create table investorindividual(             -- level 6, was 4
  id serial primary key,
  applicationid integer references application on delete set null,                 -- re-point
  individualid integer references individual on delete set null,
  role varchar(25), -- new 1112
  isApplicant varchar(5) default 'FALSE' not null, -- new 1112
  isGuarantor varchar(5) default 'FALSE' not null, -- check (isGuarantor in ('Y', 'N')), -- was BIT want Boolean
  isdirector varchar(5) default 'FALSE' not null, -- new 1112
  issoledirector varchar(5) default 'FALSE' not null, -- new 1112
  iscompanysecretary varchar(5) default 'FALSE' not null, -- new 1112
  istrustee varchar(5) default 'FALSE' not null, -- new 1112
  isbeneficiary varchar(5) default 'FALSE' not null, -- new 1112
  wealthbyemployment varchar(5) default 'FALSE' not null, -- new 1112
  wealthbyinvestments varchar(5) default 'FALSE' not null, -- new 1112
  wealthbyother varchar(5) default 'FALSE' not null, -- new 1112
  wealthbyotherinfo varchar(80) -- new 1112
--  typeOfDirector varchar(25) -- was 12
);

-- Maps to the 'gXxxxxx' onboarding stuff of the Application
-- i.e financials of the individual for this application
create table FinancialInformation(             -- level 6, was 4
    investorindividualid integer references investorindividual on delete set null,
    cash  numeric(22, 0),
    shares numeric(22, 0),
    otherLiquid numeric(22, 0),
    residentialProperty numeric(22, 0),
    investmentProperty numeric(22, 0),
    otherassets numeric(22, 0),
    otherassetsDetails varchar(50),
    otherLoansSecured numeric(22, 0),
    loansResProperty numeric(22, 0),
    loansInvProperty numeric(22, 0),
    loansPersonalUnse numeric(22, 0),
    guaranteesGranted numeric(22, 0),
    otherLiabilities numeric(22, 0),
    otherLiabilitiesDetails varchar(50),
    salary varchar(50),
    rentalAndDividend numeric(22, 0),
    otherIncome numeric(22, 0),
    otherIncomeDetails varchar(50),
    taxPayable numeric(22, 0),
    taxPayableDate date,
    intSecuredLoans numeric(22, 0),
    intUnsecuredLoans numeric(22, 0),
    livingExpenses numeric(22, 0),
    otherExpenses numeric(22, 0),
    otherExpensesDetails varchar(50)
);

create table advisorindividual(             -- level 6
  id serial primary key,
  individualid integer references individual on delete set null,
  advisorid integer references advisor on delete set null                 -- re-point
);

-- new 1112
create table advisorprovider(             -- level 6
  id serial primary key,
  advisorid integer references advisor on delete set null,
  providerid integer references company on delete set null,
  individualid integer references individual on delete set null,
  advisornumber varchar(12)
);

  -- level 6 (check) -- a bank in other words - new 1112
create table applicationdirectcreditdetails(
  applicationid integer references application on delete set null,                 -- re-point
  bsb varchar(5),
  accountName varchar(80),
  accountType varchar(24),
  accountNumber varchar(9),
  institution varchar(80),
  institutionAddress varchar(80),
  institutionSuburb varchar(24),
  institutionPostcode varchar(4),
  institutionState varchar(3)
);

create table bank(
  applicationid integer references application on delete set null,                 -- new 1112
  bsb varchar(6) primary key,
  type varchar(24),
  name varchar(80),
  address1 varchar(80),
  suburb varchar(25),
  state varchar(3),
  postcode varchar(4),
  telephone varchar(20)
);

create sequence hibernate_sequence
  start 1 increment 1 minvalue 1;

commit;
