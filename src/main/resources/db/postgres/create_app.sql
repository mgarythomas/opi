
    create table "OPISYDP2_DBO"."APPLICATION"(
        "ID" NUMBER(9) not null,
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
       "RECORDCREATED" DATE default 'sysdate',
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
       "IOTHEREXPENSESDETAILS" VARCHAR2(50),
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
       "GOTHEREXPENSESDETAILS" VARCHAR2(50),
       "ONBOARDINGSTATUS" NUMBER default '0',
       "ONBOARDINGLASTUSER" VARCHAR2(12),
       "ONBOARDINGCOMMENTS" VARCHAR2(300),
       "ONBOARDINGHARDCOPYSIGHTED" VARCHAR2(5) default 'false',
       "DADEALERGROUP" VARCHAR2(5) default 'false',
       "CREDITSTATUS" NUMBER default '0',
       "CREDITLASTUSER" VARCHAR2(12),
       "CREDITCOMMENTS" VARCHAR2(300),
       "CASAPPROVED" VARCHAR2(5) default 'false',
       "BAYCORPSAPPROVED" VARCHAR2(5) default 'false',
       "AMLSTATUS" NUMBER default '0',
       "AMLLASTUSER" VARCHAR2(12),
       "AMLCOMMENTS" VARCHAR2(200),
       "AMLHARDCOPYSIGHTED" VARCHAR2(5) default 'false',
       "CREDITCHECKVERIFIED" VARCHAR2(5) default 'false',
       "GRIDCHECKVERIFIED" VARCHAR2(5) default 'false',
       "WORLDCHECKVERIFIED" VARCHAR2(5) default 'false',
       "GOOGLECHECKVERIFIED" VARCHAR2(5) default 'false',
       "CORPORATECHECKSVERIFIED" VARCHAR2(5) default 'false',
       "TRUSTCHECKSVERIFIED" VARCHAR2(5) default 'false',
       "OPERATIONSCOMMENTS" VARCHAR2(200),
       "BANK3RDPARTYAUTHORISATION" NUMBER default '0',
       "BILLINGAPPROVED" VARCHAR2(5) default 'false',
       "RECONCILEDBILLINGDATA" VARCHAR2(5) default 'false',
       "GENERATEDBILLINGDATA" VARCHAR2(5) default 'false',
       "AMOUNTDUEPAID" NUMBER(9,2),
       "SCHEDULEDDDDATE" DATE,
       "DDPAYMENTSUCCESSFUL" VARCHAR2(5) default 'false',
       "DDUNSUCCESSFULREASON" VARCHAR2(60),
       "INITIALPAYMENTBYCHEQUE" VARCHAR2(5) default 'false',
       "PAYMENTBYALTERNATIVEMEANS" NUMBER(9,2),
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
       "APPLICATIONDATE" DATE default 'sysdate',
       "CREATEDBY" VARCHAR2(10),
       "MODIFIEDBY" VARCHAR2(10),
       "RECORDMODIFIED" DATE,
       "SOFTCOPYRECEIVEDDATE" DATE,
       "CHEQUEFORUBSATTACHED" VARCHAR2(5) default 'false' not null,
       "CHEQUEAMOUNT" NUMBER(9,2),
       "CHEQUERETURNED" VARCHAR2(5) default 'false' not null,
       "CHEQUEACCEPTED" VARCHAR2(5) default 'false' not null,
       "ISREFERREDTOCRC" VARCHAR2(5) default 'false' not null,
       "FIRSTDDSTATUSFAILED" VARCHAR2(5) default 'false' not null,
       "FIRSTDDSTATUSSUCCEEDED" VARCHAR2(5) default 'false' not null,
       "FIRSTDDSTATUSDATE" DATE,
       "ISSECONDDD" VARCHAR2(5) default 'false' not null,
       "SECONDSCHEDULEDDDDATE" DATE,
       "SECONDDDSTATUSFAILED" VARCHAR2(5) default 'false' not null,
       "SECONDDDSTATUSSUCCEEDED" VARCHAR2(5) default 'false' not null,
       "SECONDDDSTATUSDATE" DATE,
       "ISBPAY" VARCHAR2(5) default 'false' not null,
       "BPAYREFERENCE" VARCHAR2(25),
       "BPAYSTATUSFAILED" VARCHAR2(5) default 'false' not null,
       "BPAYSTATUSSUCCEEDED" VARCHAR2(5) default 'false' not null,
       "BPAYSTATUSDATE" DATE,
       "ISDIRECTCREDIT" VARCHAR2(5) default 'false' not null,
       "DIRECTCREDITSTATUSFAILED" VARCHAR2(5) default 'false' not null,
       "DIRECTCREDITSTATUSSUCCEEDED" VARCHAR2(5) default 'false' not null,
       "DIRECTCREDITSTATUSDATE" DATE,
       "CHEQUEBANKEDDATE" DATE,
       "OPSISSUERAISEDTICKED" VARCHAR2(5) default 'false' not null,
       "OPSISSUERAISEDDATE" DATE,
       "OPSISSUERAISEDUSERID" VARCHAR2(12),
       "OPSISSUERESOLVEDTICKED" VARCHAR2(5) default 'false' not null,
       "OPSISSUERESOLVEDDATE" DATE,
       "OPSISSUERESOLVEDUSERID" VARCHAR2(12),
       "OPERATIONSCOMMENTS1" VARCHAR2(200),
       "OPERATIONSCOMMENTS2" VARCHAR2(200),
       "OPERATIONSCOMMENTS3" VARCHAR2(200),
       "OPERATIONSCOMMENTS4" VARCHAR2(200),
       "OPERATIONSCOMMENTS5" VARCHAR2(200),
       "OPERATIONSCOMMENTS6" VARCHAR2(200),
       "OPERATIONSCOMMENTS7" VARCHAR2(200),
       "OPERATIONSCOMMENTS8" VARCHAR2(200),
       "OPERATIONSCOMMENTS9" VARCHAR2(200),
       "ONBOARDINGLASTMODIFIEDDATE" DATE,
       "CREDITLASTMODIFIEDDATE" DATE,
       "AMLLASTMODIFIEDDATE" DATE,
       "OPERATIONSLASTUSER" VARCHAR2(12),
       "OPERATIONSLASTMODIFIEDDATE" DATE,
       "ADMINISTRATIONLASTUSER" VARCHAR2(12),
       "ADMINISTRATIONLASTMODIFIEDDATE" DATE,
       "MASTERLASTUSER" VARCHAR2(12),
       "MASTERLASTMODIFIEDDATE" DATE,
       "AMOUNTDUE" NUMBER(9,2),
       "NEWAMOUNTDUE" NUMBER(9,2),
       "ADVISERBONAFIDESCHECKED" VARCHAR2(5) default 'false',
       "AUTOMATICDIRECTDEBITSUPPRESSED" VARCHAR2(5) default 'false',
       "FIRSTAMOUNTRECEIVED" NUMBER(9,2),
       "AMENDEDPAYMENTAMOUNT" NUMBER(9,2),
       "INHOUSEAMOUNT" NUMBER(9,2),
        constraint "SYS_C004082" primary key ("ID")
    );

    alter table "OPISYDP2_DBO"."APPLICATION"  
        add constraint "APPLICATION_ADVISOR_FK" 
        foreign key ("ADVISORID") 
        references "OPISYDP2_DBO"."ADVISOR"("ID") 
        on delete set null ;
    alter table "OPISYDP2_DBO"."APPLICATION"  
        add constraint "APPLICATION_COMPANY_FK" 
        foreign key ("COMPANYID") 
        references "OPISYDP2_DBO"."COMPANY"("ID") 
        on delete set null ;
    alter table "OPISYDP2_DBO"."APPLICATION"  
        add constraint "APPLICATION_PRODUCT_FK" 
        foreign key ("PRODUCTID") 
        references "OPISYDP2_DBO"."PRODUCT"("ID") 
        on delete set null ;
    alter table "OPISYDP2_DBO"."APPLICATION"  
        add constraint "APPLICATION_TRUST_FK" 
        foreign key ("TRUSTID") 
        references "OPISYDP2_DBO"."TRUST"("ID") 
        on delete set null ;
    create unique index "OPISYDP2_DBO"."SYS_C004082" on "OPISYDP2_DBO"."APPLICATION"("ID");