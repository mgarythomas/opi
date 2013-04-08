package com.ubs.opi.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.ubs.opi.domain.Dealergroup;

/**
 * <code>Validator</code> for <code>Advisorfirm</code> forms.
 *
 * @author Paul McLachlan
 */
public class AdvisorfirmsValidator implements Validator {

	public boolean supports(Class clazz) {
		return Dealergroup.class.isAssignableFrom(clazz);
	}

	public void validate(Object obj, Errors errors) {
      Dealergroup dealergroup = (Dealergroup) obj;

	}

}
