package com.ubs.opi.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.ubs.opi.domain.Advisorfirm;

/**
 * <code>Validator</code> for <code>Advisorfirm</code> forms.
 *
 * @author Paul McLachlan
 */
public class AdvisorfirmValidator implements Validator {

	public boolean supports(Class clazz) {
		return Advisorfirm.class.isAssignableFrom(clazz);
	}

	public void validate(Object obj, Errors errors) {
      Advisorfirm advisorfirm = (Advisorfirm) obj;

	}

}
