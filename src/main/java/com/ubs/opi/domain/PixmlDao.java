package com.ubs.opi.domain;

import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

import com.ubs.opi.service.Pixml;

public class PixmlDao extends JdbcDaoSupport implements Pixml
{
  private static final DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
  
   static final Log log = LogFactory.getLog(PixmlDao.class);
   public String DEF_APPLICATION_BY_ID_QUERY;
   public String DEF_APPLICANTS_BY_ID_QUERY;

   // private static Connection sConnection;

   //private static Statement sStatement;

   protected ResultSet sRS = null;

   private SimpleXMLFile sXMLFile; // = new SimpleXMLFile();

   private String id;

   public void executeQuery(String sql)
   {
      try
      {
         //System.out.println("SQL: " + sql);
         Statement sStatement = getDataSource().getConnection().createStatement();
         log.info("SQL: " + sql);
         sRS = sStatement.executeQuery(sql);
      } catch (Exception exception)
      {
         log.error("Database access error", exception);
         //System.err.println("Database access error: " + exception);
         // Runtime.getRuntime ().halt (21);
      }
   }

  public void retrieveApplicationInformation ()
  {
    String DEF_APPLICATION_BY_ID_QUERY = "select " +
    "DealerGroupCompany.Name DealerGroupName, " +
    "DealerGroup.IsDAApproved, " +
    "AdvisorIndividual.FirstName AdvisorFirstName, " +
    "AdvisorIndividual.LastName AdvisorLastName, " +
    "Advisor.AssistantName AdvisorAssistantName, " +
    "AdvisorIndividual.WorkEmail AdvisorEmail, " +
    "AdvisorIndividual.WorkPhone AdvisorPhone, " +
    "AdvisorFirmCompany.Name AdvisorCompanyName, " +
    "AdvisorFirmCompany.Address1 AdvisorAddress1, " +
    "AdvisorFirmCompany.Address2 AdvisorAddress2, " +
    "AdvisorFirmCompany.Suburb AdvisorSuburb, " +
    "AdvisorFirmCompany.State AdvisorState, " +
    "AdvisorFirmCompany.PostCode AdvisorPostcode, " +
    "AdvisorProvider.AdvisorNumber, " +
    "CompanyCompany.Name CompanyName, " +
    "CompanyCompany.TFN CompanyTFN, " +
    "CompanyCompany.ABN CompanyABN, " +
    "CompanyCompany.ACN CompanyACN, " +
    "CompanyCompany.ARBN CompanyARBN, " +
    "CompanyCompany.IncorporationCountry CompanyCountry, " +
    "CompanyCompany.IncorporationDate CompanyDate, " +
    "TrustCompany.Name TrustName, " +
    "TrustCompany.TFN TrustTFN, " +
    "TrustCompany.ABN TrustABN, " +
    "TrustCompany.ACN TrustACN, " +
    "TrustCompany.ARBN TrustARBN, " +
    "Trust.reviewdeeds TrustReviewDeeds, " +
    "Trust.WealthByEmployment TrustWealthByEmployment, " +
    "Trust.WealthByInvestments TrustWealthByInvestments, " +
    "Trust.WealthByOther TrustWealthByOther, " +
    "Trust.WealthByOtherInfo TrustWealthByOtherInfo, " +
    "Trust.Beneficiaries TrustBeneficiaries, " +
    "Application.Type, " +
    "Application.Status, " +
    "Application.Commission, " +
    "Application.ApplicationAmount01, " +
    "Application.ApplicationAmount02, " +
    "Application.ApplicationAmount03, " +
    "Application.ApplicationAmount04, " +
    "Application.ApplicationAmount05, " +
    "Application.AccountDesignation, " +
    "Application.FirstName ContactFirstName, " +
    "Application.LastName ContactLastName, " +
    "Application.Address1 PostalAddress1, " +
    "Application.Address2 PostalAddress2, " +
    "Application.Suburb PostalSuburb, " +
    "Application.State PostalState, " +
    "Application.PostCode PostalPostcode, " +
    "Application.Country PostalCountry, " +
    "Application.HomePhone, " +
    "Application.WorkPhone, " +
    "Application.EMail, " +
    "Application.FAX, " +
    "Application.IsBorrowingFromUBS, " +
    "Application.IsPurchasingPutFromUbs, " +
    "Application.IsIAL, " +
    "Application.iCash, " +
    "Application.iShares, " +
    "Application.iOtherLiquid, " +
    "Application.iResidentialProperty, " +
    "Application.iInvestmentProperty, " +
    "Application.iOtherAssets, " +
    "Application.iOtherAssetsDetails, " +
    "Application.iOtherLoansSecured, " +
    "Application.iLoansResidentialProperty, " +
    "Application.iLoansInvestmentProperty, " +
    "Application.iLoansPersonalUnsecured, " +
    "Application.iGuaranteesGranted, " +
    "Application.iOtherLiabilities, " +
    "Application.iOtherLiabilitiesDetails, " +
    "Application.iSalary, " +
    "Application.iRentalAndDividend, " +
    "Application.iOtherIncome, " +
    "Application.iOtherIncomeDetails, " +
    "Application.iTaxPayable, " +
    "Application.iTaxPayableDate, " +
    "Application.iInterestOnSecuredLoans, " +
    "Application.iInterestOnUnsecuredLoans, " +
    "Application.iLivingExpenses, " +
    "Application.iOtherExpenses, " +
    "Application.iOtherExpensesDetails, " +
    "Application.gCash, " +
    "Application.gShares, " +
    "Application.gOtherLiquid, " +
    "Application.gResidentialProperty, " +
    "Application.gInvestmentProperty, " +
    "Application.gOtherAssets, " +
    "Application.gOtherAssetsDetails, " +
    "Application.gOtherLoansSecured, " +
    "Application.gLoansResidentialProperty, " +
    "Application.gLoansInvestmentProperty, " +
    "Application.gLoansPersonalUnsecured, " +
    "Application.gGuaranteesGranted, " +
    "Application.gOtherLiabilities, " +
    "Application.gOtherLiabilitiesDetails, " +
    "Application.gSalary, " +
    "Application.gRentalAndDividend, " +
    "Application.gOtherIncome, " +
    "Application.gOtherIncomeDetails, " +
    "Application.gTaxPayable, " +
    "Application.gTaxPayableDate, " +
    "Application.gInterestOnSecuredLoans, " +
    "Application.gInterestOnUnsecuredLoans, " +
    "Application.gLivingExpenses, " +
    "Application.gOtherExpenses, " +
    "Application.gOtherExpensesDetails, " +
    "Application.DDApplicant, " +
    "Application.DDABN, " +
    "Application.DDInstitution, " +
    "Application.DDInstitutionAddress, " +
    "Application.DDInstitutionSuburb, " +
    "Application.DDInstitutionPostCode, " +
    "Application.DDInstitutionState, " +
    "Application.DDAccountName, " +
    "Application.DDBSB, " +
    "Application.DDAccountNo, " +
    "Application.DDAccountType, " +
    "Application.ReinvestDistribution, " +
    "Application.DirectCreditDistribution, " +
    "Application.IsPaperCopyWanted, " +
    "Application.IsProviderCustomer, " +
    "Application.ProviderUnitHolderNumber, " +
    "Application.ProviderFundName, " +
    "Application.IsUBSCustomer, " +
    "Application.UBSUnitHolderNumber, " +
    "Application.UBSFundName, " +
    "Application.IsEitherToSign " +
  "from Application " +
       "inner join Product on Application.ProductID = Product.ID " +
         "inner join Company Provider on Product.ProviderID = Provider.ID " +
       "inner join Advisor on Application.AdvisorID = Advisor.ID " +
         "inner join Individual AdvisorIndividual on Advisor.IndividualID = AdvisorIndividual.ID " +
         "inner join AdvisorFirm on Advisor.AdvisorFirmID = AdvisorFirm.ID " +
           "inner join Company AdvisorFirmCompany on AdvisorFirm.CompanyID = AdvisorFirmCompany.ID " +
           "inner join DealerGroup on AdvisorFirm.DealerGroupID = DealerGroup.ID " +
             "inner join Company DealerGroupCompany on DealerGroup.CompanyID = DealerGroupCompany.ID " +
         "left join AdvisorProvider on AdvisorProvider.AdvisorID = Advisor.ID and AdvisorProvider.ProviderID = Provider.ID " +
       "left join Company CompanyCompany on Application.CompanyID = CompanyCompany.ID " +
       "left join Trust on Application.TrustID = Trust.ID " +
         "left join Company TrustCompany on Trust.CompanyID = TrustCompany.ID " +
         "left join Company SolicitorCompany on Trust.SolicitorCompanyID = SolicitorCompany.ID " +
  "where Application.ID = " + id;

    executeQuery (DEF_APPLICATION_BY_ID_QUERY);

    sXMLFile.putQuery ("APPLICATION", sRS);

  }

  public void retrieveApplicantInformation (String applicantFlag, String xmlKey)
  {
    String DEF_APPLICANTS_BY_ID_QUERY = "select " +
    "InvestorIndividual.IsApplicant, " +
    "InvestorIndividual.IsGuarantor, " +
    "InvestorIndividual.IsDirector, " +
    "InvestorIndividual.IsSoleDirector, " +
    "InvestorIndividual.IsCompanySecretary, " +
    "InvestorIndividual.IsTrustee, " +
    "InvestorIndividual.IsBeneficiary, " +
    "Individual.Title, " +
    "Individual.FirstName, " +
    "Individual.MiddleName, " +
    "Individual.LastName, " +
    "Individual.Address1, " +
    "Individual.Address2, " +
    "Individual.Suburb, " +
    "Individual.State, " +
    "Individual.Postcode, " +
    "Individual.Country, " +
    "Individual.TFN, " +
    "Individual.ABN, " +
    "Individual.DateOfBirth, " +
    "Individual.TownOfBirth, " +
    "Individual.CountryOfBirth, " +
    "Individual.PassportNo, " +
    "Individual.Nationality, " +
    "Individual.DriversLicenceNo, " +
    "Individual.Occupation, " +
    "Individual.Employer, " +
    "InvestorIndividual.WealthByEmployment, " +
    "InvestorIndividual.WealthByInvestments, " +
    "InvestorIndividual.WealthByOther, " +
    "InvestorIndividual.WealthByOtherInfo " +
  "from InvestorIndividual " +
       "inner join Individual on InvestorIndividual.IndividualID = Individual.ID " +
  "where InvestorIndividual.ApplicationID = " + id + " and " +
        "InvestorIndividual.IsApplicant = '" + applicantFlag + "' " +
  "order by InvestorIndividual.ID";

    executeQuery (DEF_APPLICANTS_BY_ID_QUERY);

    sXMLFile.putQuery (xmlKey, sRS);
  }

  public String createXml(String id)
  {
     setId(id);
     retrieveApplicationInformation();
     retrieveApplicantInformation("true", "APPLICANT");
     retrieveApplicantInformation("false", "BENEFICIALOWNER");
     
     sXMLFile.startKey("MISC", 0);
     sXMLFile.putItem("DATE_TODAY", dateFormat.format(new Date()));
     sXMLFile.endKey();
     
     sXMLFile.close();
     return sXMLFile.getFilename();
  }

  public String getId()
  {
     return id;
  }
  
  public void setId(String id)
  {
     this.id = id;
     sXMLFile = new SimpleXMLFile(id);
  }

}
