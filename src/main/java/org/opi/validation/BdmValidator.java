package org.opi.validation;

import org.opi.domain.Individual;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;


/**
 * <code>Validator</code> for <code>BdmUser</code> forms.
 *
 * @author Paul McLachlan
 */
public class BdmValidator extends OpiValidator implements Validator {

	public boolean supports(Class clazz) {
		return Individual.class.isAssignableFrom(clazz);
	}

   public void validate(Object obj, Errors errors) {

      Individual individual = (Individual)obj;
      isRequired(errors, "firstname", "First Name");
      isRequired(errors, "lastname", "Surname");
      isRequired(errors, "workemail", "Email");
      isRequired(errors, "workphone", "Work Phone");
      isRequired(errors, "workfax", "Fax");
      //
      // Validate Email
      //
      validateEmail(errors, "workemail", individual.getWorkemail());
      //
      // populate error structures
      //
      this.rejectMandatory(errors);
      OpiValidator.logErrors(errors);

   }

}
