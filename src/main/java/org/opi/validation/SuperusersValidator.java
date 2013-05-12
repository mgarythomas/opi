package org.opi.validation;

import org.opi.domain.Superusers;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;


/**
 * <code>Validator</code> for <code>Individual</code> forms.
 *
 * @author Paul McLachlan
 */
public class SuperusersValidator extends OpiValidator implements Validator {

	public boolean supports(Class clazz) {
		return Superusers.class.isAssignableFrom(clazz);  
	}

   public void validate(Object obj, Errors errors) {

      Superusers superusers = (Superusers)obj;
//      if (superusers.getTransadvisor().getTransinvestortype().equals("-1"))
//         errors.rejectValue("transadvisor.transinvestortype", null, "Please select an Investor");
   }

   public static Errors validateSuperusers(Superusers superusers, Errors errors) { 
      if (superusers.getTransadvisor().getTransinvestortype().equals("-1"))
         errors.rejectValue("superusers.transadvisor.transinvestortype", null, "Please select an Investor");
      return errors;
   }

}
