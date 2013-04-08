create or replace function ReadAndLockApplication (pApplicationID in long,
                                                   pUserID in char,
                                                   pUserRole in char,
                                                   pCreateIfNecessary in char)
                                                  return types.JDBCCursor

  --   Date      Who    Action
  -- 15/ 2/07  D Smart  Converted from Sybase.
  -- 11/ 4/07  D Smart  Converted to use ID not application number.
  -- 17/ 4/07  D Smart  Retrieve FileSystemSubdirectory.
  -- 23/ 4/07  D Smart  Retrieve ProductFilePrefix.
  -- 27/ 4/07  D Smart  Retrieve Status as OPIStatus.
  --  4/ 5/07  D Smart  Change OPI Type alias to ApplicantType.
  --  8/ 5/07  D Smart  Retrieve BDM information from Individual not AdvisorProvider.
  -- 21/ 5/07  D Smart  Retrieve extra fields - mostly for Ops.     
  -- 23/ 5/07  D Smart  IsRefferedToCRC.     

as

  pragma autonomous_transaction;

  vSelectCursor types.JDBCCursor;

  vLocked char(1) := 'N';
  vOnboardingLock varchar(12);
  vCreditLock varchar(12);
  vAMLLock varchar(12);
  vMainLock varchar(12);
  vRows int;

begin

  select OnboardingLock, CreditLock, AMLLock, MainLock
         into vOnboardingLock, vCreditLock, vAMLLock, vMainLock
         from Application
         where ID = pApplicationID
         for update;
  vRows := sql%rowcount;
  --if (vRows = 0) and (pCreateIfNecessary = 'Y') then
  --  insert into Application (ApplicationNumber) values (pApplicationNumber);
  --  vRows := 1;
  --end if;
  if vRows = 1 then
    if vMainLock is not null then
      vLocked := 'Y';
    else
      if pUserRole = 'Onboarding' then
        if vOnboardingLock is not null then
          vLocked := 'Y';
        else
          update Application set OnboardingLock = pUserID where ID = pApplicationID;
        end if;
      elsif pUserRole = 'Credit' then
        if vCreditLock is not null then
          vLocked := 'Y';
        else
          update Application set CreditLock = pUserID where ID = pApplicationID;
        end if;
      elsif pUserRole = 'AML' then
        if vAMLLock is not null then
          vLocked := 'Y';
        else
          update Application set AMLLock = pUserID where ID = pApplicationID;
        end if;
      elsif (vOnboardingLock is not null) or
            (vCreditLock is not null) or
            (vAMLLock is not null) then
        vLocked := 'Y';
      else
        update Application set MainLock = pUserID where ID = pApplicationID;
      end if;
    end if;
  end if;
  commit;

  open vSelectCursor for
    select
      case when vLocked = 'Y' then 'Locked' else 'OK' end as ReadStatus,
      DealerGroup.IsDAApproved,
      DealerGroup.AFSL,
      DealerGroupCompany.Name as DealerGroupName,
      Advisor.AssistantName as AdvisorAssistantName,
      Advisor.AssistantEMail as AdvisorAssistantEMail,
      AdvisorIndividual.FirstName as AdvisorFirstName,
      AdvisorIndividual.LastName as AdvisorLastName,
      AdvisorIndividual.WorkEmail as AdvisorEmail,
      AdvisorIndividual.WorkPhone as AdvisorPhone,
      AdvisorFirmCompany.Name as AdvisorCompanyName,
      AdvisorFirmCompany.Address1 as AdvisorAddress1,
      AdvisorFirmCompany.Address2 as AdvisorAddress2,
      AdvisorFirmCompany.Suburb as AdvisorSuburb,
      AdvisorFirmCompany.State as AdvisorState,
      AdvisorFirmCompany.PostCode as AdvisorPostcode,
      AdvisorProvider.AdvisorNumber,
      BDMIndividual.FirstName as BDMFirstName,
      BDMIndividual.LastName as BDMLastName,
      BDMIndividual.WorkPhone as BDMPhone,
      BDMIndividual.WorkEMail as BDMEMail,
      CompanyCompany.Name as CompanyName,
      CompanyCompany.TradingName as CompanyTradingName,
      CompanyCompany.TFN as CompanyTFN,
      CompanyCompany.ABN as CompanyABN,
      CompanyCompany.IncorporationCountry as CompanyIncorporationCountry,
      CompanyCompany.IncorporationDate as CompanyIncorporationDate,
      TrustCompany.Name as TrustName,
      TrustCompany.TFN as TrustTFN,
      TrustCompany.ABN as TrustABN,
      TrustCompany.ARBN as TrustARBN,
      Trust.IsSuperFund as TrustIsSuperFund,
      Trust.SolicitorName as TrustSolicitorName,
      Trust.ReviewDeeds as TrustReviewDeeds,
      Trust.WealthByEmployment as TrustWealthByEmployment,
      Trust.WealthByInvestments as TrustWealthByInvestments,
      Trust.WealthByOther as TrustWealthByOther,
      Trust.WealthByOtherInfo as TrustWealthByOtherInfo,
      Product.ProductFilePrefix,
      Product.FileSystemSubdirectory,
      Application.ID as ApplicationID,
      Application.Type as ApplicantType,
      Application.Type as ApplicationType,  -- temporary for backwards compatibility
      Application.Commission,
      Application.ApplicationNumber,
      Application.ClientNumber,
      Application.ApplicationAmount01,
      Application.ApplicationAmount02,
      Application.ApplicationAmount03,
      Application.ApplicationAmount04,
      Application.ApplicationAmount05,
      Application.ApprovedAmount01,
      Application.ApprovedAmount02,
      Application.ApprovedAmount03,
      Application.ApprovedAmount04,
      Application.ApprovedAmount05,
      Application.AccountDesignation,
      Application.FirstName ContactFirstName,
      Application.MiddleName ContactMiddleName,
      Application.LastName ContactLastName,
      Application.Address1 PostalAddress1,
      Application.Address2 PostalAddress2,
      Application.Suburb PostalSuburb,
      Application.State PostalState,
      Application.PostCode PostalPostcode,
      Application.Country PostalCountry,
      Application.HomePhone,
      Application.WorkPhone,
      Application.EMail,
      Application.FAX,
      Application.IsBorrowingFromUBS,
      Application.IsPurchasingPutFromUbs,
      Application.IsIAL,
      Application.iCash,
      Application.iShares,
      Application.iOtherLiquid,
      Application.iResidentialProperty,
      Application.iInvestmentProperty,
      Application.iOtherAssets,
      Application.iOtherAssetsDetails,
      Application.iOtherLoansSecured,
      Application.iLoansResidentialProperty,
      Application.iLoansInvestmentProperty,
      Application.iLoansPersonalUnsecured,
      Application.iGuaranteesGranted,
      Application.iOtherLiabilities,
      Application.iOtherLiabilitiesDetails,
      Application.iSalary,
      Application.iRentalAndDividend,
      Application.iOtherIncome,
      Application.iOtherIncomeDetails,
      Application.iTaxPayable,
      Application.iTaxPayableDate,
      Application.iInterestOnSecuredLoans,
      Application.iInterestOnUnsecuredLoans,
      Application.iLivingExpenses,
      Application.iOtherExpenses,
      Application.iOtherExpensesDetails,
      Application.gCash,
      Application.gShares,
      Application.gOtherLiquid,
      Application.gResidentialProperty,
      Application.gInvestmentProperty,
      Application.gOtherAssets,
      Application.gOtherAssetsDetails,
      Application.gOtherLoansSecured,
      Application.gLoansResidentialProperty,
      Application.gLoansInvestmentProperty,
      Application.gLoansPersonalUnsecured,
      Application.gGuaranteesGranted,
      Application.gOtherLiabilities,
      Application.gOtherLiabilitiesDetails,
      Application.gSalary,
      Application.gRentalAndDividend,
      Application.gOtherIncome,
      Application.gOtherIncomeDetails,
      Application.gTaxPayable,
      Application.gTaxPayableDate,
      Application.gInterestOnSecuredLoans,
      Application.gInterestOnUnsecuredLoans,
      Application.gLivingExpenses,
      Application.gOtherExpenses,
      Application.gOtherExpensesDetails,
      Application.DDApplicant,
      Application.DDABN,
      Application.DDInstitution,
      Application.DDInstitutionAddress,
      Application.DDInstitutionSuburb,
      Application.DDInstitutionState,
      Application.DDInstitutionPostCode,
      Application.DDAccountName,
      Application.DDBSB,
      Application.DDAccountNo,
      Application.ReinvestDistribution,
      Application.DirectCreditDistribution,
      Application.IsPaperCopyWanted,
      Application.IsProviderCustomer,
      Application.ProviderUnitHolderNumber,
      Application.ProviderFundName,
      Application.IsUBSCustomer,
      Application.UBSUnitHolderNumber,
      Application.UBSFundName,
      Application.IsEitherToSign,

      Application.Status as OPIStatus,
      Application.OnboardingStatus,
      Application.OnboardingComments,
      Application.OnboardingHardCopySighted,
      Application.CreditStatus,
      Application.CreditComments,
      Application.CASApproved,
      Application.BaycorpsApproved,
      Application.AMLStatus,
      Application.AMLComments,
      Application.AMLHardCopySighted,
      Application.SoftCopyReceivedDate,
      Application.CreditCheckVerified,
      Application.GridCheckVerified,
      Application.WorldCheckVerified,
      Application.GoogleCheckVerified,
      Application.CorporateChecksVerified,
      Application.TrustChecksVerified,
      Application.OperationsComments,
      Application.Bank3rdPartyAuthorisation,
      Application.BillingApproved,
      Application.ReconciledBillingData,
      Application.GeneratedBillingData,
      Application.AmountDuePaid,
      Application.ScheduledDDDate,
      Application.DDPaymentSuccessful,
      Application.DDUnsuccessfulReason,
      Application.InitialPaymentByCheque,
      Application.PaymentByAlternativeMeans,
      Application.ChequeForUBSAttached,
      Application.ChequeAmount,
      Application.ChequeReturned,
      Application.ChequeAccepted,
      Application.ConductedBilling,
      Application.GeneratedApprovalLetter,
      Application.GeneratedRejectionLetter,
      Application.AdministrationComments,
      Application.OnboardingInfo1Satisfied,
      Application.OnboardingInfo1Commentary,
      Application.OnboardingInfo2Satisfied,
      Application.OnboardingInfo2Commentary,
      Application.OnboardingInfo3Satisfied,
      Application.OnboardingInfo3Commentary,
      Application.CreditInfo1Satisfied,
      Application.CreditInfo1Commentary,
      Application.CreditInfo2Satisfied,
      Application.CreditInfo2Commentary,
      Application.AMLInfo1Satisfied,
      Application.AMLInfo1Commentary,
      Application.OnboardingInfoNotYetChecked,
      Application.CreditInfoNotYetChecked,
      Application.AMLInfoNotYetChecked,
      Application.IsReferredToCRC,
      Application.BaycorpRecordCreated,
      Application.ASICCompanySearch,
      Application.ATORegistration,
      Application.TrustDeedApproved,
      Application.Applicant1Approved,
      Application.Applicant1Material,
      Application.Applicant1Immaterial,
      Application.Applicant1NoHit,
      Application.Applicant1NotApplicable,
      Application.Applicant2Approved,
      Application.Applicant2Material,
      Application.Applicant2Immaterial,
      Application.Applicant2NoHit,
      Application.Applicant2NotApplicable,
      Application.CompanyApproved,
      Application.CompanyMaterial,
      Application.CompanyImmaterial,
      Application.CompanyNoHit,
      Application.CompanyNotApplicable,
      Application.OtherPersonsApproved,
      Application.OtherPersonsMaterial,
      Application.OtherPersonsImmaterial,
      Application.OtherPersonsNoHit,
      Application.OtherPersonsNotApplicable,
      Application.InformationNotificationDate,
      Application.ConditionalNotificationDate,
      Application.ApprovalNotificationDate,
      Application.ApplicationWithdrawn,
      Application.ApplicationDeleted,
      Application.OnboardingLock,
      Application.CreditLock,
      Application.AMLLock,
      Application.MainLock,
      Application.RecordCreated
    from Application
         inner join Product on Application.ProductID = Product.ID
           inner join Company Provider on Product.ProviderID = Provider.ID
         inner join Advisor on Application.AdvisorID = Advisor.ID
           inner join Individual AdvisorIndividual on Advisor.IndividualID = AdvisorIndividual.ID
           inner join AdvisorFirm on Advisor.AdvisorFirmID = AdvisorFirm.ID
             inner join Company AdvisorFirmCompany on AdvisorFirm.CompanyID = AdvisorFirmCompany.ID
             inner join DealerGroup on AdvisorFirm.DealerGroupID = DealerGroup.ID
               inner join Company DealerGroupCompany on DealerGroup.CompanyID = DealerGroupCompany.ID
           left join AdvisorProvider on AdvisorProvider.AdvisorID = Advisor.ID and AdvisorProvider.ProviderID = Provider.ID
             left join Individual BDMIndividual on AdvisorProvider.IndividualID = BDMIndividual.ID
         left join Company CompanyCompany on Application.CompanyID = CompanyCompany.ID
         left join Trust on Application.TrustID = Trust.ID
           left join Company TrustCompany on Trust.CompanyID = TrustCompany.ID
           left join Company SolicitorCompany on Trust.SolicitorCompanyID = SolicitorCompany.ID
    where Application.ID = pApplicationID;
  return vSelectCursor;

end ReadAndLockApplication;

--select ReadAndLockApplication ('1049', 'auser', 'Administration', 'N') from dual;
--select ReadAndLockApplication ('1049', 'auser', 'Administration', 'N') from dual;

--select ReadAndLockApplication ('1049', 'auser', 'Credit', 'N') from dual;
--select ReadAndLockApplication ('1049', 'buser', 'Credit', 'N') from dual;

--select ReadAndLockApplication ('1049', 'auser', 'Onboarding', 'Y') from dual;
--selectReadAndLockApplication ('1049', 'auser', 'Onboarding', 'Y') from dual;

/
