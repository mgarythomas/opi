package com.ubs.opi.service;

import java.util.Collection;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ubs.opi.domain.Advisorprovider;
import com.ubs.opi.domain.AdvisorproviderDAO;
import com.ubs.opi.domain.Company;
import com.ubs.opi.domain.CompanyDAO;
import com.ubs.opi.domain.Individual;
import com.ubs.opi.domain.IndividualDAO;

public class BdmAdminService implements BdmAdminServiceIF {

  public Company findProviderForBdmAdmin(String username) {
    Individual individual = this.individualDAO.findBdmAdminByUsername(username);
    
    if (individual == null || StringUtils.isBlank(individual.getEmployer())) {
      throw new IllegalArgumentException("Invalid BDM Admin user: " + username);
    }
    
    Company company = this.companyDAO.findProviderUsingCriterias(individual.getEmployer());
    
    for (Advisorprovider advisorprovider : company.getAdvisorproviders()) {
      if (advisorprovider.getIndividual() != null) {
        advisorprovider.setTransbdmid("" + advisorprovider.getIndividual().getId());
      }
    }
    
    if (logger.isDebugEnabled()) {
      logger.debug("Returning provider company " + company);
    }
    
    return company;
  }
  
  public List<Individual> findBdmsForProvider(Company provider) {
    List<Individual> individuals = this.individualDAO.findBdmsByEmployer(provider.getName());
    
    if (logger.isDebugEnabled()) {
      logger.debug("Returning back " + individuals.size() + " BDMs.");
    }
    
    return individuals;
  }
  
  public void updateBdmRelationshipsForProvider(Collection<Advisorprovider> advisorProviders) {
    for (Advisorprovider advisorprovider : advisorProviders) {
       Individual individual = this.individualDAO.findById(new Long(advisorprovider.getTransbdmid()));
       advisorprovider.setIndividual(individual);
       this.advisorproviderDAO.update(advisorprovider);
    }
  }

  public void setCompanyDAO(CompanyDAO companyDAO) {
    this.companyDAO = companyDAO;
  }

  public void setIndividualDAO(IndividualDAO individualDAO) {
    this.individualDAO = individualDAO;
  }
  
  public void setAdvisorproviderDAO(AdvisorproviderDAO advisorproviderDAO) {
    this.advisorproviderDAO = advisorproviderDAO;
  }
  
  private IndividualDAO individualDAO;
  private CompanyDAO companyDAO;
  private AdvisorproviderDAO advisorproviderDAO;
  
  private static final Log logger = LogFactory.getLog(BdmAdminService.class);


}
