package com.ubs.opi.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.ubs.opi.domain.Advisor;
import com.ubs.opi.domain.Users;

/**
 * <code>Validator</code> for <code>Advisorapplications</code> forms.
 *
 * @author Paul McLachlan
 */
public class ChangepasswordValidator extends OpiValidator implements Validator {

   public boolean supports(Class clazz) {
		return Advisor.class.isAssignableFrom(clazz);
	}

	public void validate(Object obj, Errors errors) {
      Advisor advisor = (Advisor) obj;
      
      Users users = advisor.getIndividual().getUsers();

      isRequired(errors, "individual.users.password", "New Password"); 
      isRequired(errors, "individual.users.checkpassword", "Retype New Password");

      if (users.getPassword().length() > 10)
      {
         errors.rejectValue("individual.users.password", null, "must be less than 10 characters in length");  
      }
      if (users.getPassword().length() < 6)
      {
         errors.rejectValue("individual.users.password", null, "must be greater than 6 characters in length");  
      }
      if (!users.getPassword().equals(users.getCheckpassword()))
      {
         errors.rejectValue("individual.users.password", null, "Retyped Password does not match Password");  
      }
	}

}
