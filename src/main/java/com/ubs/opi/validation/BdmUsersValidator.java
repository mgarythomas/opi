package com.ubs.opi.validation;

import java.util.Set;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.ubs.opi.domain.Advisorprovider;
import com.ubs.opi.domain.Company;

/**
 * <code>Validator</code> for <code>BdmUser</code> forms.
 *
 * @author Paul McLachlan
 */
public class BdmUsersValidator extends OpiValidator implements Validator {

	public boolean supports(Class clazz) {
		return Company.class.isAssignableFrom(clazz);
	}

   public void validate(Object obj, Errors errors) {

      Company company = (Company)obj;

//      Set<Advisorprovider> advisorproviders = company.getAdvisorproviders();
//
//      int i=0;
//      for (Advisorprovider advisorprovider : advisorproviders) {
//         if (advisorprovider.getTransbdmid().equals("1"))
//            errors.rejectValue("advisorprovidersarray[" + i
//                  + "].transbdmid", null, "Advisor " + (i + 1)
//                  + " BDM selection is Mandatory");
//         i++;
//      }
//
//      OpiValidator.logErrors(errors);


   }

   public static Errors validateBdmUsers(Company company, Errors errors) {
      Set<Advisorprovider> advisorproviders = company.getAdvisorproviders();

      int i=0;
      for (Advisorprovider advisorprovider : advisorproviders) {
    	 if (advisorprovider.getIndividual() != null)
	         if (advisorprovider.getTransbdmid().equals("1"))
	            errors.rejectValue("advisorprovidersarray[" + i
	                  + "].transbdmid", null, "BDM selection for Advisor "+ advisorprovider.getAdvisor().getIndividual().getFullname() +" is Mandatory");
         i++;
      }

      //OpiValidator.logErrors(errors);
      return errors;
   }

}
