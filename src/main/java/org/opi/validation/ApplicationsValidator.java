package org.opi.validation;

import org.opi.domain.Advisor;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;


/**
 * <code>Validator</code> for <code>Applications</code> forms.
 * 
 * @author Paul McLachlan
 */
public class ApplicationsValidator extends OpiValidator implements Validator {

	public boolean supports(Class clazz) {
		return Advisor.class.isAssignableFrom(clazz);
	}

	public void validate(Object obj, Errors errors) {
      Advisor advisor = (Advisor) obj;
	}

}
