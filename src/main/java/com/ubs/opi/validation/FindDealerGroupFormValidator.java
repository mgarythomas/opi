package com.ubs.opi.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.ubs.opi.domain.Dealergroup;

public class FindDealerGroupFormValidator extends OpiValidator implements
		Validator {

	public boolean supports(Class clazz) {
      return Dealergroup.class.isAssignableFrom(clazz);
//		return true;
	}

	public void validate(Object obj, Errors errors) {
		Dealergroup dealerGrp = (Dealergroup) obj;
		// validate the AFSL
		isRequired(errors, "afsl", "AFSL");
		validateAFSL(errors, "afsl", dealerGrp.getAfsl());

		this.rejectMandatory(errors);
		OpiValidator.logErrors(errors);
	}
}
