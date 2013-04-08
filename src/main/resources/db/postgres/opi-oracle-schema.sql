drop table advisor;                          -- level 4
drop sequence advisorsequence;
drop table advisorfirm;                      -- level 3
drop sequence advisorfirmsequence;
drop table individual;                       -- level 2         -- level changed, was 3
drop sequence individualsequence;
drop table product;                          -- level 2
drop sequence productsequence;
--drop table companyinvestor;                  -- level 2         -- removed
--drop sequence companyinvestorsequence;
drop table trust;                            -- level 2         -- renamed
drop sequence trustsequence;
drop table dealergroup;                      -- level 2
drop sequence dealergroupsequence;
drop table role;                             -- level 2         -- level changed, was 1
drop sequence rolesequence;
drop table company;                          -- level 1
drop sequence companysequence;
drop table logon;                            -- level 1         -- level changed, was 2
drop sequence logonsequence;
drop sequence hibernate_sequence;
--drop table investorentity;                   -- level 1         -- removed
--drop sequence investorentitysequence;

/*                                           -- removed
create table investorentity(                 -- level 1
  id number(9,0) not null primary key,
  name varchar(74),                                                        -- was 24
  address1 varchar(32),  -- new
  suburb varchar(25),    -- new
  state varchar(3),      -- new
  postcode varchar(4),   -- new
  type number(1,0) not null check (type between 0 and 5),                  -- was varchar(4) default '' not null,
       -- 0: individual, 1: individual trust, 2: corporate trust, 3: corporate, 4: super fund (corporate), 5: super fund (individual)
  -- format varchar(24), -- removed
  creationDate date
);
create sequence investorentitysequence
  start with 1 increment by 1 minvalue 1 nocache nocycle noorder;
create trigger investorentityincrement
  before insert on investorentity
  for each row
  begin
    select investorentitysequence.nextval into :new.id from dual;
  end;
/
*/

create table logon(                          -- level 1, was 2
  id number(9,0) not null primary key,
  username varchar(10),
  pwd varchar(10),
  email varchar(40) default '' not null
);
create sequence logonsequence
  start with 1 increment by 1 minvalue 1 nocache nocycle noorder;
create trigger logonincrement
  before insert on logon
  for each row
  begin
    select logonsequence.nextval into :new.id from dual;
  end;
/

create table company(                        -- level 1
  id number(9,0) not null primary key,
  type varchar(24), -- [ FundManager, CompanyInvestor, DealerGroup, AdvisorFirm, Solicitor(Firm) ]  -- moved
  name varchar(37),             -- was 24
  address1 varchar(37),         -- was 4
  suburb varchar(25),           -- was 4
  state varchar(3),             -- new
  postcode varchar(4),          -- was int,
  telephone varchar(10),        -- was bigint,
  tfn varchar(9),               -- was bigint,
  abn varchar(11),              -- was bigint,
  acn varchar(9),               -- was bigint
  arbn varchar(11),             -- new,
  incorporationcountry varchar(20), -- new
  incorporationdate date        -- new
);
create sequence companysequence
  start with 1 increment by 1 minvalue 1 nocache nocycle noorder;
create trigger companyincrement
  before insert on company
  for each row
  begin
    select companysequence.nextval into :new.id from dual;
  end;
/

create table role(                           -- level 2, was 1
  id number(9,0) not null primary key,
  logonid number(9,0),
  rolename varchar(12) default '' not null,
  constraint role_logon_fk foreign key (logonid) references logon(id) on delete set null
);
create sequence rolesequence
  start with 1 increment by 1 minvalue 1 nocache nocycle noorder;
create trigger roleincrement
  before insert on role
  for each row
  begin
    select rolesequence.nextval into :new.id from dual;
  end;
/

create table dealergroup(                    -- level 2
  id number(9,0) not null primary key,
  afsl number(9,0),
  companyid number(9,0),
  constraint dealergroup_company_fk foreign key (companyid) references company(id) on delete cascade /* xx on update cascade */
);
create sequence dealergroupsequence
  start with 1 increment by 1 minvalue 1 nocache nocycle noorder;
create trigger dealergroupincrement
  before insert on dealergroup
  for each row
  begin
    select dealergroupsequence.nextval into :new.id from dual;
  end;
/

create table trust(                          -- level 2  -- renamed
  id number(9,0) not null primary key,
  companyid number(9,0), -- new
  solicitorname varchar(25), -- new
  solicitorcompanyid number(9,0), -- renamed
  constraint trust_company_fk foreign key (companyid) references company(id) on delete set null,
  constraint trust_solicitor_fk foreign key (solicitorcompanyid) references company(id) on delete set null
);
create sequence trustsequence
  start with 1 increment by 1 minvalue 1 nocache nocycle noorder;
create trigger trustincrement
  before insert on trust
  for each row
  begin
    select trustsequence.nextval into :new.id from dual;
  end;
/

/*                                           -- removed
create table companyinvestor(                -- level 2
  id number(9,0) not null primary key,
  investorentityid number(9,0),
  companyid number(9,0),
  constraint companyinv_investorentity_fk foreign key (investorentityid) references investorentity(id) on delete set null,
  constraint companyinvestor_company_fk foreign key (companyid) references company(id) on delete cascade /* xx on update cascade *//*
);
create sequence companyinvestorsequence
  start with 1 increment by 1 minvalue 1 nocache nocycle noorder;
create trigger companyinvestorincrement
  before insert on companyinvestor
  for each row
  begin
    select companyinvestorsequence.nextval into :new.id from dual;
  end;
/
*/

create table product(                        -- level 2
  id number(9,0) not null primary key,
  providerid number(9,0),
  name varchar(40), -- was 24
  type varchar(24),
  -- what is type?
  shortdesc varchar(120),
  -- what goes in shortdesc?
  hasMinimumBase char(1) default 'N' not null check (hasMinimumBase in ('Y', 'N')), -- was BIT want Boolean -- moved
  hasMinimumIncrement char(1) default 'N' not null check (hasMinimumIncrement in ('Y', 'N')), -- was BIT want Boolean -- moved
  -- where are the above two defined?
  constraint product foreign key (providerid) references company(id) on delete cascade /* xx on update cascade */
);
create sequence productsequence
  start with 1 increment by 1 minvalue 1 nocache nocycle noorder;
create trigger productincrement
  before insert on product
  for each row
  begin
    select productsequence.nextval into :new.id from dual;
  end;
/

create table individual(                     -- level 3
  id number(9,0) not null primary key,
  logonid number(9,0),
  title varchar(4),             -- new
  firstname varchar(24),
  middlename varchar(24),
  lastname varchar(24),
  address1 varchar(32),
  suburb varchar(24),           -- moved
  state varchar(3),             -- new
  postcode varchar(4),          -- was int
  country varchar(20),          -- new
  tfn varchar(9),               -- new
  abn varchar(11),               -- new
  homephone varchar(10),        -- was bigint -- renamed
  workphone varchar(10),        -- new
  mobilephone varchar(10),      -- new
  personalfax varchar(10),      -- new
  workfax varchar(10),          -- new
  personalemail varchar(50),    -- new
  workemail varchar(50),        -- new
  dateOfBirth date,
  townOfBirth varchar(24),
  countryOfBirth varchar(24),
  passportNo varchar(24),
  nationality varchar(24),
  driversLicenceNo varchar(24),
  occupation varchar(24),
  employer varchar(37),         -- new
  wealthbyemployment char(1) default 'N', -- not null check (wealthbyemployment in ('Y', 'N')), -- new
  wealthbyinvestments char(1) default 'N', -- not null check (wealthbyinvestments in ('Y', 'N')), -- new
  wealthbyother char(1) default 'N', -- not null check (wealthbyother in ('Y', 'N')), -- new
  wealthbyotherinfo varchar(80), --new
  -- type varchar(4),
  -- can be [advisor, investor, (assistant advisor), administrator]
  -- !! no it can't - an individual can be many things
  constraint individual_logon_fk foreign key (logonid) references logon(id) on delete set null
);
create sequence individualsequence
  start with 1 increment by 1 minvalue 1 nocache nocycle noorder;
create trigger individualincrement
  before insert on individual
  for each row
  begin
    select individualsequence.nextval into :new.id from dual;
  end;
/

create table advisorfirm(                    -- level 3
  id number(9,0) not null primary key,
  dealergroupid number(9,0),
  companyid number(9,0),
  constraint advisorfirm_company_fk foreign key (companyid) references company(id) on delete cascade, /* xx on update cascade */
  constraint dealergroup_advisorfirm_fk foreign key (dealergroupid) references dealergroup(id)
);
create sequence advisorfirmsequence
  start with 1 increment by 1 minvalue 1 nocache nocycle noorder;
create trigger advisorfirmincrement
  before insert on advisorfirm
  for each row
  begin
    select advisorfirmsequence.nextval into :new.id from dual;
  end;
/

create table advisor(                  -- level 4
  id number(9,0) not null primary key,
  individualid number(9,0),
  advisorfirmid number(9,0),
  constraint advisor_individual_fk foreign key (individualid) references individual(id) on delete set null,
  constraint advisor_advisorfirm_fk foreign key (advisorfirmid) references advisorfirm(id) on delete set null
);
create sequence advisorsequence
  start with 1 increment by 1 minvalue 1 nocache nocycle noorder;
create trigger advisorincrement
  before insert on advisor
  for each row
  begin
    select advisorsequence.nextval into :new.id from dual;
  end;
/

create table application(               -- level 5
  id number(9,0) not null primary key,
  companyid number(9,0),
  trustid number(9,0),
  advisorid number(9,0),
  -- investorentityid number(9,0), -- removed
  productid number(9,0),
  name varchar(74),                                                        -- was 24
  address1 varchar(32),  -- new
  suburb varchar(25),    -- new
  state varchar(3),      -- new
  postcode varchar(4),   -- new
  type number(1,0) not null check (type between 0 and 5),                  -- was varchar(4) default '' not null,
       -- 0: individual, 1: individual trust, 2: corporate trust, 3: corporate, 4: super fund (corporate), 5: super fund (individual)
  applicationDate date,
  amount int,
  status int,            -- renamed
  isBorrowingFromUbs char(1) default 'N' not null check (isBorrowingFromUbs in ('Y', 'N')), -- was BIT want Boolean
  isPurchasingPutFromUbs char(1) default 'N' not null check (isPurchasingPutFromUbs in ('Y', 'N')), -- was BIT want Boolean
  isIAL char(1) default 'N' not null check (isIAL in ('Y', 'N')), -- new
  isUbsToSightTrustDeed char(1) default 'N' not null check (isUbsToSightTrustDeed in ('Y', 'N')), -- was BIT want Boolean
  isEitherToSign char(1) default 'N' not null check (isEitherToSign in ('Y', 'N')), -- was BIT want Boolean
  isOneOfficerToSign char(1) default 'N' not null check (isOneOfficerToSign in ('Y', 'N')), -- new
  isDirectCredit char(1) default 'N' not null check (isDirectCredit in ('Y', 'N')), -- new
  isPaperCopyWanted char(1) default 'N' not null check (isPaperCopyWanted in ('Y', 'N')), -- replaces next line
  --financialReportSendMethod varchar(24), replaced by previous
  isProviderCustomer char(1) default 'N' not null check (isproviderCustomer in ('Y', 'N')), -- new
  providerunitholdernumber varchar(25), -- new
  providerfundname varchar(25), -- new
  isUBSCustomer char(1) default 'N' not null check (isUBSCustomer in ('Y', 'N')), -- new
  ubsunitholdernumber varchar(25), -- new
  ubsfundname varchar(25), -- new
  --yearTaxPayable date, -- removed
  ddApplicant varchar(80), -- new
  ddABN varchar(11), -- new
  ddInstitution varchar(25), -- new
  ddInstitutionAddress varchar(37), -- new
  ddAccountName varchar(80), -- new
  ddBSB varchar(6), -- new
  ddAccountNo varchar(9), -- new
  -- assets
  iCash int,
  iShares int,
  iOtherLiquid int, -- moved
  iResidentialProperty int,
  iInvestmentProperty int,
  iOtherAssets int, -- new
  iOtherAssetsDetails varchar(50), -- new
  -- liabilities
  iOtherLoansSecured int, -- moved
  iLoansResidentialProperty int,
  iLoansInvestmentProperty int,
  iLoansPersonalUnsecured int, -- spelling fixed
  iGuaranteesGranted int,
  iOtherLiabilities int, -- new
  iOtherLiabilitiesDetails varchar(50), -- new
  -- income
  iSalary int,
  iRentalAndDividend int,
  iOtherIncome int, -- moved
  iOtherIncomeDetails varchar(50), -- new
  iTaxPayable int,
  iTaxPayableDate date, -- new
  -- expenditure
  iInterestOnSecuredLoans int,
  iInterestOnUnsecuredLoans int,
  iLivingExpenses int,
  iOtherExpenses int,
  -- assets
  gCash int,
  gShares int,
  gOtherLiquid int, -- moved
  gResidentialProperty int,
  gInvestmentProperty int,
  gOtherAssets int, -- new
  gOtherAssetsDetails varchar(50), -- new
  -- liabilities
  gOtherLoansSecured int, -- moved
  gLoansResidentialProperty int,
  gLoansInvestmentProperty int,
  gLoansPersonalUnsecured int, -- spelling fixed
  gGuaranteesGranted int,
  gOtherLiabilities int, -- new
  gOtherLiabilitiesDetails varchar(50), -- new
  -- income
  gSalary int,
  gRentalAndDividend int,
  gOtherIncome int, -- moved
  gOtherIncomeDetails varchar(50), -- new
  gTaxPayable int,
  gTaxPayableDate date, -- new
  -- expenditure
  gInterestOnSecuredLoans int,
  gInterestOnUnsecuredLoans int,
  gLivingExpenses int,
  gOtherExpenses int,
  constraint application_company_fk foreign key (companyid) references company(id) on delete set null,
  constraint application_trust_fk foreign key (trustid) references trust(id) on delete set null,
  constraint application_advisor_fk foreign key (advisorid) references advisor(id) on delete set null,
  constraint application_product_fk foreign key (productid) references product(id) on delete set null
);
create sequence applicationsequence
  start with 1 increment by 1 minvalue 1 nocache nocycle noorder;
create trigger applicationincrement
  before insert on application
  for each row
  begin
    select applicationsequence.nextval into :new.id from dual;
  end;
/

create table investorindividual(             -- level 6, was 4
  id number(9,0) not null primary key,
  individualid number(9,0),
  applicationid number(9,0),                 -- re-point
  isGuarantor char(1) default 'N' not null check (isGuarantor in ('Y', 'N')), -- was BIT want Boolean
  typeOfDirector varchar(25), -- was 12
  constraint investorind_individual_fk foreign key (individualid) references individual(id) on delete set null,
  constraint investorind_application_fk foreign key (applicationid) references application(id) on delete set null
);

create sequence investorindividualsequence
  start with 1 increment by 1 minvalue 1 nocache nocycle noorder;
create trigger investorindividualincrement
  before insert on investorindividual
  for each row
  begin
    select investorindividualsequence.nextval into :new.id from dual;
  end;
/

create table advisorindividual(             -- level 6
  id number(9,0) not null primary key,
  individualid number(9,0),
  advisorid number(9,0),                 -- re-point
  constraint advisorind_individual_fk foreign key (individualid) references individual(id) on delete set null,
  constraint advisorind_advisor_fk foreign key (advisorid) references advisor(id) on delete set null
);

create sequence hibernate_sequence
  start with 1 increment by 1 minvalue 1 nocache nocycle noorder;

commit;
