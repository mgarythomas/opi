package com.ubs.opi.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.ubs.opi.domain.Guruusers;

/**
 * <code>Validator</code> for <code>Individual</code> forms.
 *
 * @author Paul McLachlan
 */
public class GuruusersValidator extends OpiValidator implements Validator {

	public boolean supports(Class clazz) {
		return Guruusers.class.isAssignableFrom(clazz);  
	}

   public void validate(Object obj, Errors errors) {

      Guruusers guruusers = (Guruusers)obj;
   }

   public static Errors validateSuperusers(Guruusers guruusers, Errors errors) { 
      return errors;
   }

}
