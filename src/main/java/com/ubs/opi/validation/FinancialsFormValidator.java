package com.ubs.opi.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.ubs.opi.domain.Application;

/**
 * <code>Validator</code> for <code>Applications</code> forms.
 * 
 * @author Paul McLachlan
 */
public class FinancialsFormValidator extends OpiValidator implements Validator {

	public boolean supports(Class clazz) {
		return Application.class.isAssignableFrom(clazz);
	}

	public void validate(Object obj, Errors errors) {
		Application application = (Application) obj;
		//
		// Applicants
		//
		if (application.getIotherassets() > 0) {
			isRequired(errors, "iotherassetsdetails",
					"Applicants: If Other Assets is populated, Other Asset details");
		}
		if (application.getIotherliabilities() > 0) {
			isRequired(errors, "iotherliabilitiesdetails",
					"Applicants: If Other Liabilities is populated, Other Liabilities details");
		}
		if (application.getIotherincome() > 0) {
			isRequired(errors, "iotherincomedetails",
					"Applicants: If Other Income is populated, Other Income");
		}
		if (application.getIotherexpenses() > 0) {
			isRequired(errors, "iotherexpensesdetails",
					"Applicants: If Other Expenses is populated, Other Expenses");
		}
		//
		// Guarantors
		//
		if (application.getCompany() != null) {

			if (application.getGotherassets() > 0) {
				isRequired(errors, "gotherassetsdetails",
						"Guarantors: If Other Assets is populated, Other Asset");
			}
			if (application.getGotherliabilities() > 0) {
				isRequired(errors, "gotherliabilitiesdetails",
						"Guarantors: If Other Liabilities is populated, Other Liabilities");
			}
			if (application.getGotherincome() > 0) {
				isRequired(errors, "gotherincomedetails",
						"Guarantors: If Other Income is populated, Other Income");
			}
			if (application.getGotherexpenses() > 0) {
				isRequired(errors, "gotherexpensesdetails",
						"Guarantors: If Other Expenses is populated, Other Expenses");
			}
		}

      OpiValidator.logErrors(errors);
	}
}
