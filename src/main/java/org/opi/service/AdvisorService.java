package org.opi.service;

import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Advisor;
import org.opi.domain.AdvisorDAO;
import org.opi.domain.Advisorfirm;
import org.opi.domain.Application;
import org.opi.domain.ApplicationDAO;
import org.opi.domain.ApplicationDirectCreditDetails;
import org.opi.domain.Company;
import org.opi.domain.CompanyDAO;
import org.opi.domain.Constants;
import org.opi.domain.FinancialInformation;
import org.opi.domain.FinancialInformationDao;
import org.opi.domain.Individual;
import org.opi.domain.IndividualDAO;
import org.opi.domain.Investorindividual;
import org.opi.domain.InvestorindividualDAO;
import org.opi.domain.Product;
import org.opi.domain.ProductDAO;
import org.opi.exception.IncorrectRelationshipException;


public class AdvisorService implements AdvisorServiceIF {

  public Set<Application> getApplicationsToDisplay(Advisor advisor) {
    this.advisorDAO.refresh(advisor);

    Set<Application> filteredApplications = new TreeSet<Application>(new Comparator<Application>() {
      public int compare(Application o1,
                         Application o2) {
        int res = o1.getAccountdesignation().compareToIgnoreCase(
            o2.getAccountdesignation());

        // this is to see all applications even with the same acccount 
        // designation.
        if (res == 0) {
          res = new Long(o1.getId()).compareTo(o2.getId());
        }
        
        return res;
      }
    });
    
    Set<Application> applications = advisor.getApplications();
    for (Application application : applications) {
      if (application.getStatus() != Constants.CANCELLED_STATUS) {
        filteredApplications.add(application);
      }
    }
    
    return filteredApplications;
  }
  
  public Set<Application> getApplicationsToDisplayUnique(Advisor advisor) {
    Set<Application> applications =  new TreeSet<Application>(new Comparator<Application>() {
      public int compare(Application o1,
                         Application o2) {
        int res = o1.getAccountdesignation().compareToIgnoreCase(
            o2.getAccountdesignation());

        return res;
      }
    });
    
    Set<Application> applicationsDuplicate = this.getApplicationsToDisplay(advisor);
    applications.addAll(applicationsDuplicate);
    
    return applications;
  }
  
  public Advisor loadAdvisorForEditing(long advisorId) {
    return this.advisorDAO.findByIdWithEditableDependencies(advisorId);
  }
  
  public void updateAdvisorDetails(Advisor advisor, Advisorfirm advisorfirm) {
    Advisor persistentAdvisor = this.advisorDAO.findById(advisor.getId());
    
    persistentAdvisor.setAssistantname(advisor.getAssistantname());
    persistentAdvisor.setAssistantemail(advisor.getAssistantemail());
    
    Individual persistentIndividual = persistentAdvisor.getIndividual();
    Individual transientIndividual = advisor.getIndividual();
    
    persistentIndividual.setTitle(transientIndividual.getTitle());
    persistentIndividual.setFirstname(transientIndividual.getFirstname());
    persistentIndividual.setLastname(transientIndividual.getLastname());
    persistentIndividual.setWorkphone(transientIndividual.getWorkphone());
    persistentIndividual.setMobilephone(transientIndividual.getMobilephone());
    persistentIndividual.setWorkfax(transientIndividual.getWorkfax());
    persistentIndividual.setWorkemail(transientIndividual.getWorkemail());
    
    Company persistentAdvisorFirmCompany = persistentAdvisor.getAdvisorfirm().getCompany();
    Company tranientAdvisorFirmCompany = advisorfirm.getCompany();
    
    persistentAdvisorFirmCompany.setName(tranientAdvisorFirmCompany.getName());
    persistentAdvisorFirmCompany.setAbn(tranientAdvisorFirmCompany.getAbn());
    persistentAdvisorFirmCompany.setAddress1(tranientAdvisorFirmCompany.getAddress1());
    persistentAdvisorFirmCompany.setSuburb(tranientAdvisorFirmCompany.getSuburb());
    persistentAdvisorFirmCompany.setState(tranientAdvisorFirmCompany.getState());
    persistentAdvisorFirmCompany.setPostcode(tranientAdvisorFirmCompany.getPostcode());
    
    this.advisorDAO.updateAdvisorDetails(persistentAdvisor);
  }
  
  public void deleteApplicationOfId(Long applicationId) {
    Application application = this.applicationDAO.findById(applicationId);
    
    synchronized (this) {
      this.applicationDAO.delete(application);
    }
  }
  
  public void updateDirectCreditDetails(Application application,
                                        ApplicationDirectCreditDetails directCreditDetails)
                                 throws IncorrectRelationshipException {
    // Since one-to-one associations are preloaded (ie - not lazy), we don't
    // need to refresh.  Refreshing will cause errors because we'll then
    // have two ApplicationDirectCreditDetails objects with the same id
    // being updated.
    // this.applicationDAO.refresh(application);
    if (application.getDirectCreditDetails() != null && 
        application.getDirectCreditDetails().getId() != null && 
        directCreditDetails.getId() != null && 
        !application.getDirectCreditDetails().getId().equals(
            directCreditDetails.getId())) {
      throw new IncorrectRelationshipException("Application " + application + 
          " already has directCreditDetails: " + directCreditDetails + 
          ".  Cannot replace with " + directCreditDetails + ".");
    }
    
    directCreditDetails.setApplication(application);
    application.setDirectCreditDetails(directCreditDetails);
    
    
    this.applicationDAO.updateDirectCreditDetails(application);
    
    
  }
  
  public Application loadApplicationForEditing(Long applicationId) {
    return this.applicationDAO.findApplicationByIdWithDependencies(applicationId);
  }
  
  public Product findProductById(Long productId) {
    return this.productDAO.findById(productId);
  }
  
  public List<Product> getProductsToDisplayForTheme(String theme) {
    List<Product> products;
    
      Company provider = this.companyDAO.findProvider(theme);
//      products = new LinkedList<Product>(provider.getProducts());
      products = new LinkedList<Product>(this.productDAO.readAllProducts());

    return products;
  }
  
  public Application findApplicationById(Long applicationId) {
    return this.applicationDAO.findById(applicationId);
  }
  
  public void associateAsGuarantor(Application application,
                                   Investorindividual transientGuarantor,
                                   Individual transientIndividual,
                                   FinancialInformation transientFinancialInformation) {
    Investorindividual chosenGuarantor;
    
    this.applicationDAO.refresh(application);
    
    if (application.getExternalGuarantor() != null) {
      // external guarantor exists.
      
      if (transientGuarantor.getId().longValue() == application.getExternalGuarantor().getId().longValue()) {
        // updating existing exernal guarantor
        chosenGuarantor = application.getExternalGuarantor();
        this.updateGuarantorDetails(chosenGuarantor, transientGuarantor, transientGuarantor.getIndividual());
      } else {
        // switched to internal guarantor - delete external guarantor
        Investorindividual oldGuarantor = application.getExternalGuarantor();
        this.removeAsGuarantor(oldGuarantor);
        chosenGuarantor = application.findInvestorIndividualById(transientGuarantor.getId());
        this.setAsInternalGuarantor(application, chosenGuarantor);
      }
    } else if (application.getInternalGuarantor() != null) {
      // internal guarantor exists.
      
      Investorindividual oldGuarantor = application.getInternalGuarantor();
      chosenGuarantor = application.findInvestorIndividualById(transientGuarantor.getId());
      
      if (chosenGuarantor == null) {
        // switching to new external guarantor.
        this.removeAsGuarantor(oldGuarantor);
        chosenGuarantor = this.createExternalGuarantor(application, transientGuarantor, transientGuarantor.getIndividual());
      } else if (oldGuarantor.getId().equals(chosenGuarantor.getId())) {
        // same internal guarantor - update
        // nothing to update here ...
      } else {
        // different internal guarantor - remove old associationship and create new one
        this.removeAsGuarantor(oldGuarantor);
        this.setAsInternalGuarantor(application, chosenGuarantor);
      }
    } else {
      // assume new external guarantor.
      chosenGuarantor = this.createExternalGuarantor(application, transientGuarantor, transientGuarantor.getIndividual());
    } 

    if (logger.isDebugEnabled()) {
      logger.debug("Saving guarantor's finaicial information ...");
    }
    
    this.updateGuarantorFinancialInformation(chosenGuarantor, transientFinancialInformation);
  }
  
  
  public void updateGuarantorFinancialInformation(Investorindividual guarantor,
                                                  FinancialInformation financialInformation) {
    FinancialInformation existingFinancialInformation;
    
    if (guarantor.getFinancialInformation() == null) {
      if (logger.isDebugEnabled()) {
        logger.debug("New financial data.  Creating new record first ...");
      }
      FinancialInformation newFinancialInformation = new FinancialInformation();
      
      guarantor.setFinancialInformation(newFinancialInformation);
      newFinancialInformation.setInvestorindividual(guarantor);
      
      this.financialInformationDao.save(newFinancialInformation);
      this.investorindividualDAO.update(guarantor);
      existingFinancialInformation = newFinancialInformation;
    } else {
      if (logger.isDebugEnabled()) {
        logger.debug("Updating existing financial data ...");
      }
      existingFinancialInformation = guarantor.getFinancialInformation();
    }
    
    // I do it this way so that I can control which fields are being updated.
    existingFinancialInformation.setCash(financialInformation.getCash());
    existingFinancialInformation.setShares(financialInformation.getShares());
    existingFinancialInformation.setOtherLiquid(financialInformation.getOtherLiquid());
    existingFinancialInformation.setResidentialProperty(financialInformation.getResidentialProperty());
    existingFinancialInformation.setInvestmentProperty(financialInformation.getInvestmentProperty());
    existingFinancialInformation.setOtherassets(financialInformation.getOtherassets());
    existingFinancialInformation.setOtherassetsDetails(financialInformation.getOtherassetsDetails());
    existingFinancialInformation.setOtherLoansSecured(financialInformation.getOtherLoansSecured());
    existingFinancialInformation.setLoansResProperty(financialInformation.getLoansResProperty());
    existingFinancialInformation.setLoansInvProperty(financialInformation.getLoansInvProperty());
    existingFinancialInformation.setLoansPersonalUnse(financialInformation.getLoansPersonalUnse());
    existingFinancialInformation.setGuaranteesGranted(financialInformation.getGuaranteesGranted());
    existingFinancialInformation.setOtherLiabilities(financialInformation.getOtherLiabilities());
    existingFinancialInformation.setOtherLiabilitiesDetails(financialInformation.getOtherLiabilitiesDetails());
    existingFinancialInformation.setSalary(financialInformation.getSalary());
    existingFinancialInformation.setRentalAndDividend(financialInformation.getRentalAndDividend());
    existingFinancialInformation.setOtherIncome(financialInformation.getOtherIncome());
    existingFinancialInformation.setOtherIncomeDetails(financialInformation.getOtherIncomeDetails());
    existingFinancialInformation.setTaxPayable(financialInformation.getTaxPayable());
    existingFinancialInformation.setTaxPayableDate(financialInformation.getTaxPayableDate());
    existingFinancialInformation.setIntSecuredLoans(financialInformation.getIntSecuredLoans());
    existingFinancialInformation.setIntUnsecuredLoans(financialInformation.getIntUnsecuredLoans());
    existingFinancialInformation.setLivingExpenses(financialInformation.getLivingExpenses());
    existingFinancialInformation.setOtherExpenses(financialInformation.getOtherExpenses());
    existingFinancialInformation.setOtherExpensesDetails(financialInformation.getOtherExpensesDetails());
    
    this.financialInformationDao.update(existingFinancialInformation);
  }
  
  public Investorindividual createExternalGuarantor(Application application, 
                                            Investorindividual transientInvestorindividual,
                                            Individual transientIndividual) {
    if (logger.isDebugEnabled()) {
      logger.debug("Creating new external guarantor individual ...");
    }
    
    Individual individual = new Individual();
    
    // Column 1:
    individual.setTitle(transientIndividual.getTitle());
    individual.setFirstname(transientIndividual.getFirstname());
    individual.setMiddlename(transientIndividual.getMiddlename());
    individual.setLastname(transientIndividual.getLastname());
    individual.setAddress1(transientIndividual.getAddress1());
    individual.setSuburb(transientIndividual.getSuburb());
    individual.setState(transientIndividual.getState());
    individual.setPostcode(transientIndividual.getPostcode());
    individual.setCountry(transientIndividual.getCountry());
    
    // Column 2:
    individual.setPassportno(transientIndividual.getPassportno());
    individual.setNationality(transientIndividual.getNationality());
    individual.setDriverslicenceno(transientIndividual.getDriverslicenceno());
    individual.setOccupation(transientIndividual.getOccupation());
    individual.setEmployer(transientIndividual.getEmployer());
    individual.setDateofbirth(transientIndividual.getDateofbirth());
    individual.setTownofbirth(transientIndividual.getTownofbirth());
    individual.setCountryofbirth(transientIndividual.getCountryofbirth());
    individual.setTfn(transientIndividual.getTfn());

    this.individualDAO.save(individual);

    if (logger.isDebugEnabled()) {
      logger.debug("Linking new external guarantor individual to application ...");
    }
    
    Investorindividual investorindividual = new Investorindividual();
    
    investorindividual.setApplication(application);
    application.getInvestorindividuals().add(investorindividual);
    
    investorindividual.setIndividual(individual);
    individual.getInvestorindividuals().add(investorindividual);
    
    investorindividual.setRole(Constants.GUARANTOR);
    investorindividual.setIsguarantor(Constants.TRUE);
    
    investorindividual.setWealthbyemployment(transientInvestorindividual.getWealthbyemployment());
    investorindividual.setWealthbyinvestments(transientInvestorindividual.getWealthbyinvestments());
    investorindividual.setWealthbyother(transientInvestorindividual.getWealthbyother());
    investorindividual.setWealthbyotherinfo(transientInvestorindividual.getWealthbyotherinfo());
    
    this.investorindividualDAO.save(investorindividual);
    
    return investorindividual;
  }
  
  public void updateGuarantorDetails(Investorindividual guarantor, 
                                     Investorindividual transientGuarantor, 
                                     Individual transientIndividual) {
    if (!guarantor.getRole().equals(Constants.GUARANTOR)) {
      throw new IllegalArgumentException("Investoriidividual to update must be an external guarantor.");
    }

    Individual individual = guarantor.getIndividual();
    
    // Column 1:
    individual.setTitle(transientIndividual.getTitle());
    individual.setFirstname(transientIndividual.getFirstname());
    individual.setMiddlename(transientIndividual.getMiddlename());
    individual.setLastname(transientIndividual.getLastname());
    individual.setAddress1(transientIndividual.getAddress1());
    individual.setSuburb(transientIndividual.getSuburb());
    individual.setState(transientIndividual.getState());
    individual.setPostcode(transientIndividual.getPostcode());
    individual.setCountry(transientIndividual.getCountry());
    
    // Column 2:
    individual.setPassportno(transientIndividual.getPassportno());
    individual.setNationality(transientIndividual.getNationality());
    individual.setDriverslicenceno(transientIndividual.getDriverslicenceno());
    individual.setOccupation(transientIndividual.getOccupation());
    individual.setEmployer(transientIndividual.getEmployer());
    individual.setDateofbirth(transientIndividual.getDateofbirth());
    individual.setTownofbirth(transientIndividual.getTownofbirth());
    individual.setCountryofbirth(transientIndividual.getCountryofbirth());
    individual.setTfn(transientIndividual.getTfn());

    this.individualDAO.update(individual);

    Investorindividual investorindividual = guarantor;
    
    investorindividual.setWealthbyemployment(transientGuarantor.getWealthbyemployment());
    investorindividual.setWealthbyinvestments(transientGuarantor.getWealthbyinvestments());
    investorindividual.setWealthbyother(transientGuarantor.getWealthbyother());
    investorindividual.setWealthbyotherinfo(transientGuarantor.getWealthbyotherinfo());
    
    this.investorindividualDAO.update(investorindividual);
  }
  
  public void removeAsGuarantor(Investorindividual oldGuarantor) {
    if (oldGuarantor.getRole().equals(Constants.GUARANTOR)) {
      if (logger.isDebugEnabled()) {
        logger.debug("Guarantor to remove is external, so deleting ...");
      }
      
      Individual individual = oldGuarantor.getIndividual();
      individual.getInvestorindividuals().remove(oldGuarantor); // throws lazy error.
      oldGuarantor.setIndividual(null);
      this.individualDAO.delete(individual);

      FinancialInformation financialInformation = oldGuarantor.getFinancialInformation();
      financialInformation.setInvestorindividual(null);
      oldGuarantor.setFinancialInformation(null);
      this.financialInformationDao.delete(financialInformation);

      Application application = oldGuarantor.getApplication();
      oldGuarantor.setApplication(null);
      application.getInvestorindividuals().remove(oldGuarantor);
      this.investorindividualDAO.delete(oldGuarantor);
      
      this.applicationDAO.update(application);
    } else {
      if (logger.isDebugEnabled()) {
        logger.debug("Guarantor to remove is internal, so updating flags ...");
      }
      oldGuarantor.setIsguarantor(Constants.FALSE);
      this.investorindividualDAO.update(oldGuarantor);

      FinancialInformation financialInformation = oldGuarantor.getFinancialInformation();
      financialInformation.setInvestorindividual(null);
      oldGuarantor.setFinancialInformation(null);
      this.financialInformationDao.delete(financialInformation);
    }
  }
  
  public void removeAdditionalGuarantor(Application application) {
    this.applicationDAO.refresh(application);
    if (application.getExternalGuarantor() != null) {
      this.removeAsGuarantor(application.getExternalGuarantor());
    } else if (application.getInternalGuarantor() != null) {
      this.removeAsGuarantor(application.getInternalGuarantor());
    }
  }
  
  public void setAsInternalGuarantor(Application application,
                                     Investorindividual chosenGuarantor) {
    chosenGuarantor.setIsguarantor(Constants.TRUE);
    this.investorindividualDAO.update(chosenGuarantor);
  }
  
  public Investorindividual findInvestorIndividualById(Long investorindividualId) {
    return this.investorindividualDAO.findById(investorindividualId);
  }
  
  public void setApplicationDAO(ApplicationDAO applicationDAO) {
    this.applicationDAO = applicationDAO;
  }

  public void setAdvisorDAO(AdvisorDAO advisorDAO) {
    this.advisorDAO = advisorDAO;
  }
  
  public void setProductDAO(ProductDAO productDAO) {
    this.productDAO = productDAO;
  }

  public void setCompanyDAO(CompanyDAO companyDAO) {
    this.companyDAO = companyDAO;
  }

  public void setFinancialInformationDao(FinancialInformationDao financialInformationDao) {
    this.financialInformationDao = financialInformationDao;
  }

  public void setIndividualDAO(IndividualDAO individualDAO) {
    this.individualDAO = individualDAO;
  }

  public void setInvestorindividualDAO(InvestorindividualDAO investorindividualDAO) {
    this.investorindividualDAO = investorindividualDAO;
  }
  
  private ApplicationDAO applicationDAO;
  private AdvisorDAO advisorDAO;
  private ProductDAO productDAO;
  private CompanyDAO companyDAO;
  private FinancialInformationDao financialInformationDao;
  private IndividualDAO individualDAO;
  private InvestorindividualDAO investorindividualDAO;
  
  private static final Log logger = LogFactory.getLog(AdvisorService.class);
}
