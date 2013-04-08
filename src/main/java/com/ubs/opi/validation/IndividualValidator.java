package com.ubs.opi.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.ubs.opi.domain.Investorindividual;

/**
 * <code>Validator</code> for <code>Individual</code> forms.
 *
 * @author Paul McLachlan
 */
public class IndividualValidator extends OpiValidator implements Validator {

	public boolean supports(Class clazz) {
		return Investorindividual.class.isAssignableFrom(clazz);
	}

   public void validate(Object obj, Errors errors) {

      this.validateIndividual((Investorindividual)obj, errors);
   }

}
