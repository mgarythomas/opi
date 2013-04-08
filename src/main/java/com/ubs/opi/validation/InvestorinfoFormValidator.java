package com.ubs.opi.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.ubs.opi.domain.Application;

/**
 * <code>Validator</code> for <code>Applications</code> forms.
 *
 * @author Paul McLachlan
 */
public class InvestorinfoFormValidator extends OpiValidator implements Validator {

	public boolean supports(Class clazz) {
		return Application.class.isAssignableFrom(clazz);
	}

	public void validate(Object obj, Errors errors) {
		Application application = (Application) obj;
	}
}

