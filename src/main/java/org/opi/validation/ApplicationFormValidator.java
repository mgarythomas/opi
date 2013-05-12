package org.opi.validation;

import org.opi.domain.Application;
import org.opi.domain.Constants;
import org.opi.domain.Product;
import org.opi.domain.Utils;
import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;


//import org.springframework.validation.ValidationUtils;

/**
 * <code>Validator</code> for <code>Applications</code> forms.
 * 
 * @author Paul McLachlan
 */
public class ApplicationFormValidator extends OpiValidator implements Validator {

//	private static final long MIN_UBS_LOAN_AMT = 50000;
//
//	private static final long UBS_LOAN_INC = 10000;

	public boolean supports(Class clazz) {
		return Application.class.isAssignableFrom(clazz);
	}

	public void validate(Object obj, Errors errors) {
		Application application = (Application) obj;
		Product product = application.getProduct();
		// application validation
    
		if (!Utils.hasAuthority("ROLE_ADMINISTRATOR")) {
      if (product.getCode().equals("hfa")) {
  			if (application.getIsborrowingfromubs().equals(Constants.TRUE)) {
  
          OpiValidator.isValidAmount(errors, "applicationamount01",
  						"applicationamount01", application.getApplicationamount01(), product.getHighincrement(), product.getLowincrement());
          OpiValidator.isValidAmount(errors, "applicationamount02",
  						"applicationamount02", application.getApplicationamount02(), product.getHighincrement(), product.getLowincrement());
          OpiValidator.isValidAmount(errors, "applicationamount03",
  						"applicationamount03", application.getApplicationamount03(), product.getHighincrement(), product.getLowincrement());
  			} else {
          OpiValidator.isValidAmount(errors, "applicationamount01", 
  						"applicationamount01", application.getApplicationamount01(), product.getLowminimum(), product.getLowincrement());
          OpiValidator.isValidAmount(errors, "applicationamount02",
  						"applicationamount02", application.getApplicationamount02(), product.getLowminimum(), product.getLowincrement());
          OpiValidator.isValidAmount(errors, "applicationamount03",
  						"applicationamount03", application.getApplicationamount03(), product.getLowminimum(), product.getLowincrement());
  
  			}
        if (application.getApplicationamounttotal() < product
            .getHighminimum() || application.getApplicationamounttotal() == 0) {

          errors
              .rejectValue(
                  "applicationamounttotal",
                  "errors.low-amount",
                  new Object[] {
                      new DefaultMessageSourceResolvable(
                          "applicationamounttotal"),
                      new String(""
                          + product.getHighminimum()) },
                  "applicationamounttotal"
                      + " must be more than " + "$50,000");

        }

      } else if (product.getCode().equals("citibank1") || product.getCode().equals("citibank2")) {
        OpiValidator.isValidAmount(errors, "applicationamount01",
            "applicationamount01", application.getApplicationamount01(), product.getHighincrement(), product.getLowincrement());
        if (application.getApplicationamounttotal() < product
            .getHighminimum() || application.getApplicationamounttotal() == 0) {

          errors.rejectValue("applicationamounttotal", "errors.low-amount", new Object[] {
                      new DefaultMessageSourceResolvable("applicationamounttotal"),
                      product.getHighminimum() },
                  "applicationamounttotal must be more than " + "$50,000");

        }

      }
		}
		//
		// Validate adviser commission
		//
		double com = application.getCommission();
		double max_com = product.getMaxcommission();

		if (com > max_com) {
			errors.rejectValue("commission", "commission",
					"Max Adviser Commission is 3%");
		} else {
			validateDPs(errors, "commission", application.getCommission());
		}
	}

}
