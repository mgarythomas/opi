package org.opi.validation;

import org.opi.domain.Advisorfirm;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;


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
