package com.ubs.opi.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.ubs.opi.domain.Advisor;

/**
 * <code>Validator</code> for <code>Advisorapplications</code> forms.
 *
 * @author Paul McLachlan
 */
public class AdvisorapplicationsValidator implements Validator {

   public boolean supports(Class clazz) {
		return Advisor.class.isAssignableFrom(clazz);
	}

	public void validate(Object obj, Errors errors) {
      Advisor advisor = (Advisor) obj;
      
//      if (advisor.getTransinvestortype().equals("-1"))
//            errors.rejectValue("transinvestortype", null, "Please select an Investor");
	}

	public static void validateAdvisor(Advisor advisor, Errors errors) {
	      if (advisor.getTransinvestortype().equals("-1"))
	            errors.rejectValue("transinvestortype", null, "Please select an Investor");
		}

}
