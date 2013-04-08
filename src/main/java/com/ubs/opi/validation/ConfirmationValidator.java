package com.ubs.opi.validation;

//import java.text.SimpleDateFormat;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.ubs.opi.domain.Application;

/**
 * <code>Validator</code> for <code>ConfirmationValidator</code> forms.
 *
 * @author Paul McLachlan
 */
public class ConfirmationValidator extends OpiValidator implements Validator {

   public boolean supports(Class clazz) {
		return Application.class.isAssignableFrom(clazz);
	}

	public void validate(Object obj, Errors errors) {
      Application application = (Application) obj;

//         if (!application.isDeclarationunderstood())
//            errors.rejectValue("declarationunderstood", null, "Declaration confirmation required if Submitting application");
//         
//         if (!application.isApplicantidentified())
//            errors.rejectValue("applicantidentified", null,"Applicant Identification confirmation required if Submitting application");
   }

}
