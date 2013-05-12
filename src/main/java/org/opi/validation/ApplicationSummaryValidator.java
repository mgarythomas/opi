package org.opi.validation;

//import java.text.SimpleDateFormat;
import org.opi.domain.Application;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;


/**
 * <code>Validator</code> for <code>ApplicationSummary</code> forms.
 *
 * @author Paul McLachlan
 */
public class ApplicationSummaryValidator extends OpiValidator implements Validator {

   public boolean supports(Class clazz) {
		return Application.class.isAssignableFrom(clazz);
	}

	public void validate(Object obj, Errors errors) {
      Application application = (Application) obj;
      // application validation
   }

}
