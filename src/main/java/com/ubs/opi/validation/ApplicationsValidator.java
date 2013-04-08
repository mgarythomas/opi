package com.ubs.opi.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.ubs.opi.domain.Advisor;

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
