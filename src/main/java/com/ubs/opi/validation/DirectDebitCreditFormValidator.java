package com.ubs.opi.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.ubs.opi.domain.Application;
import com.ubs.opi.domain.Constants;

/**
 * <code>Validator</code> for <code>Applications</code> forms.
 * 
 * @author Paul McLachlan
 */
public class DirectDebitCreditFormValidator extends OpiValidator implements Validator {

	public boolean supports(Class clazz) {
		return Application.class.isAssignableFrom(clazz);
	}

	public void validate(Object obj, Errors errors) {
		Application application = (Application) obj;
    
    if (!application.getProduct().getCode().equals("citibank1") && !application.getProduct().getCode().equals("citibank2")) {
      this.validateDirectDebitDetails(application, errors);
    }
    
    if (!application.getProduct().getCode().equals("hfa")) {
      this.validateDirectCreditDetails(application, errors);
    }

	}

  private void validateDirectCreditDetails(Application application,
                                           Errors errors) {

    // Validate account details.
    
    isRequiredConditional(errors, "directCreditDetails.accountName", "Name of Account");
    isRequiredConditional(errors, "directCreditDetails.accountType", "Account Type");
    isRequiredConditional(errors, "directCreditDetails.bsb", "BSB");
    // replace BSB details with valid format.
    application.getDirectCreditDetails().setBsb(validateBSB(errors, "directCreditDetails.bsb", application.getDirectCreditDetails().getBsb()));
    isRequiredConditional(errors, "directCreditDetails.accountNumber", "A/C Number");
    // replace account number with valid format.
    application.getDirectCreditDetails().setAccountNumber(validateACNo(errors, "directCreditDetails.accountNumber", application.getDirectCreditDetails().getAccountNumber()));
    
    //
    // validate Institution details
    //
    isRequiredConditional(errors, "directCreditDetails.institution", "Financial Institution Name");
    isRequiredConditional(errors, "directCreditDetails.institutionAddress", "Branch Address");
    isRequiredConditional(errors, "directCreditDetails.institutionSuburb", "Branch Suburb");
    isRequiredConditional(errors, "directCreditDetails.institutionPostcode", "Branch Postcode");
    // replace postcode with valid format.
    validatePostcode(errors, "directCreditDetails.institutionPostcode", application.getDirectCreditDetails().getInstitutionPostcode());
    isRequiredConditional(errors, "directCreditDetails.institutionState", "Branch State");
    
  }

  private void validateDirectDebitDetails(Application application,
                                          Errors errors) {
    //
    // validate Institution details
    //
    isRequiredConditional(errors, "ddinstitution", "Financial Institution Name");
    isRequiredConditional(errors, "ddinstitutionaddress", "Branch Address");
    isRequiredConditional(errors, "ddinstitutionsuburb", "Branch Suburb");
    isRequiredConditional(errors, "ddinstitutionpostcode", "Branch Postcode");
    validatePostcode(errors, "ddinstitutionpostcode", application
        .getDdinstitutionpostcode());
    isRequiredConditional(errors, "ddinstitutionsuburb", "Branch State");
    //
    // validate acct details
    //
    isRequiredConditional(errors, "ddaccountname", "Name of Account");
    isRequiredConditional(errors, "ddbsb", "BSB");
    application.setDdbsb(validateBSB(errors, "ddbsb", application
        .getDdbsb()));
    isRequiredConditional(errors, "ddaccountno", "A/C Number");
    application.setDdaccountno(validateACNo(errors, "ddaccountno",
        application.getDdaccountno()));
    //
    //
    //
    if (Constants.TRUE.equals(application.getReinvestdistribution())
        && Constants.TRUE.equals(application.getDirectcreditdistribution())) {
      errors.rejectValue("reinvestdistribution", null,
          "Select only one cash distribution option.");

    }
  }
}
