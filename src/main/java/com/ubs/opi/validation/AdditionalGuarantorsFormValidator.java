package com.ubs.opi.validation;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.ubs.opi.domain.Constants;
import com.ubs.opi.domain.Individual;
import com.ubs.opi.domain.Investorindividual;
import com.ubs.opi.domain.Utils;
import com.ubs.opi.service.AdvisorServiceIF;
import com.ubs.opi.web.AdditionalGuarantorsForm;

/**
 * Validator for the {@link AdditionalGuarantorsForm} page.
 * 
 * @author Ana Velez
 */
public class AdditionalGuarantorsFormValidator extends OpiValidator 
                                            implements Validator {


   public boolean supports(Class clazz) {
		return Investorindividual.class.isAssignableFrom(clazz);
	}


   public void validate(Object command, Errors errors) {
     Investorindividual additionalGuarantor = (Investorindividual) command;
     
     boolean validatePersonalInformation;
     
     if (additionalGuarantor.getId().longValue() == -1) {
       // New external guarantor selected.
       validatePersonalInformation = true;
     } else {
       // Determine if selected existing external guarantor or an internal
       // guarantor.
       Investorindividual selectedInvestorindividual = 
         this.advisorService.findInvestorIndividualById(
             additionalGuarantor.getId());
       validatePersonalInformation = selectedInvestorindividual.getRole()
         .equals(Constants.GUARANTOR);
     }
     
     if (validatePersonalInformation) {
       if (logger.isDebugEnabled()) {
         logger.debug("Validating personal information of external guarantor ...");
       }
       Individual individual = additionalGuarantor.getIndividual();
       
       isRequired(errors, "individual.firstname", "First Name");
       isRequired(errors, "individual.lastname", "Last Name");
       isRequiredConditional(errors, "individual.address1", "Residential Address");
       validateResidentialAddress(errors, "individual.address1", individual.getAddress1());
       isRequiredConditional(errors, "individual.suburb", "Suburb");
       isRequiredConditional(errors, "individual.nationality", "Nationality");
       isRequiredConditional(errors, "individual.countryofbirth", "Country of Birth");
       isRequiredConditional(errors, "individual.country", "Country of Residence");
       
       if (!Utils.hasAuthority("ROLE_ADMINISTRATOR")) {
          if (individual.getCountry().equals("AUSTRALIA")) {
            isRequired(errors, "individual.state", "State is mantory");
          }
       }
       isRequiredConditional(errors, "individual.state", "State");
       isRequiredConditional(errors, "individual.postcode", "Postcode");
       validatePostcode(errors, "individual.postcode", individual.getPostcode()); 
       isRequiredConditional(errors, "individual.dateofbirth", "Date of Birth");
       isRequiredConditional(errors, "individual.occupation", "Occupation");
       
       // Source of wealth.
       
       if (!Utils.hasAuthority("ROLE_ADMINISTRATOR") &&
           Constants.FALSE.equals(additionalGuarantor.getWealthbyemployment()) && 
           Constants.FALSE.equals(additionalGuarantor .getWealthbyinvestments()) && 
           Constants.FALSE.equals(additionalGuarantor.getWealthbyother())) {
         errors.rejectValue("wealthbyemployment", null, "Source of Wealth");
       } else {
         if (Constants.TRUE.equals(additionalGuarantor.getWealthbyother())) {
           isRequiredConditional(
               errors,
               "wealthbyotherinfo",
               "Source of Wealth: If 'Other' is ticked, Information for 'Other'");
         }
       }
     }
   }

  public void setAdvisorService(AdvisorServiceIF advisorService) {
    this.advisorService = advisorService;
  }
  private static final Log logger = LogFactory.getLog(AdditionalGuarantorsFormValidator.class);

  private AdvisorServiceIF advisorService;

}
