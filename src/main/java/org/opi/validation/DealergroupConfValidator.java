package org.opi.validation;

import org.opi.domain.Advisor;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;


/**
 * <code>Validator</code> for <code>Dealergroup</code> forms.
 *
 * @author Paul McLachlan
 */
public class DealergroupConfValidator extends OpiValidator implements Validator {

	public boolean supports(Class clazz) {
		return Advisor.class.isAssignableFrom(clazz);
	}

	public void validate(Object obj, Errors errors) {

		//
		// validate terms of use check-box
		//
		Advisor advisor = (Advisor) obj;

		if (!advisor.isAcceptedtermsofuse()) {
			errors.rejectValue("acceptedtermsofuse", null,
					"Must agree to terms and conditions");
		}
		//
		// populate error structures
		//
		//this.rejectMandatory(errors);
		OpiValidator.logErrors(errors);

	}
}
