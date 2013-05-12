package org.opi.validation;

import java.util.Set;

import org.opi.domain.Application;
import org.opi.domain.Constants;
import org.opi.domain.Investorindividual;
import org.opi.domain.Utils;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;


/**
 * <code>Validator</code> for <code>Advisorfirm</code> forms.
 * 
 * @author Paul McLachlan
 */
public class BeneficiaryFormValidator extends OpiValidator implements Validator {

	public boolean supports(Class clazz) {
		return Application.class.isAssignableFrom(clazz);
	}

	@SuppressWarnings("unchecked")
	public static void validateBeneficiarys(Application application,
			Errors errors) {

		Set<Investorindividual> individuals = application
				.getInvestorindividuals();
		int i = 0;
		int x = 0;

		for (Investorindividual individual : individuals) {

			if ((Constants.TRUE.equals(individual.getIsbeneficiary()))
					&& (Constants.FALSE.equals(individual.getIsapplicant()))) {
				x++;

				isRequired(errors, "investorindividualsarray[" + i
						+ "].individual.firstname", "Beneficial Owner " + x
						+ " First Name");
				isRequired(errors, "investorindividualsarray[" + i
						+ "].individual.lastname", "Beneficial Owner " + x
						+ " Last Name");
				isRequiredConditional(errors, "investorindividualsarray[" + i
						+ "].individual.address1", "Beneficial Owner " + x + " Residential Address");
				isRequiredConditional(errors, "investorindividualsarray[" + i
						+ "].individual.suburb", "Beneficial Owner " + x
						+ " Suburb");
				if (!Utils.hasAuthority("ROLE_ADMINISTRATOR")) {
					if (individual.getIndividual().getCountry().equals("AUSTRALIA"))
						isRequired(errors, "investorindividuals[" + i + "].individual.state", "Beneficial Owner " + x + " State");
				}
//				isRequiredConditional(errors, "investorindividualsarray[" + i
//						+ "].individual.state", "Beneficial Owner " + x
//						+ " State");
				isRequiredConditional(errors, "investorindividualsarray[" + i
						+ "].individual.postcode", "Beneficial Owner " + x
						+ " Postcode");
				validatePostcode(errors, "investorindividualsarray[" + i
						+ "].individual.postcode", individual.getIndividual()
						.getPostcode());
				isRequiredConditional(errors, "investorindividualsarray[" + i
						+ "].individual.dateofbirth", "Beneficial Owner " + x
						+ " Date of Birth");

            isRequiredConditional(errors, "investorindividualsarray[" + i
                  + "].individual.occupation", "Beneficial Owner " + x
                  + ": Occupation");
            isRequiredConditional(errors, "investorindividualsarray[" + i
                  + "].individual.nationality", "Beneficial Owner " + x
                  + ": Nationality");
            isRequiredConditional(errors, "investorindividualsarray[" + i
                    + "].individual.townofbirth", "Beneficial Owner " + x
                    + ": Place of Birth"); 
            isRequiredConditional(errors, "investorindividualsarray[" + i
                  + "].individual.countryofbirth", "Beneficial Owner " + x
                  + ": Country of Birth"); 
            isRequiredConditional(errors, "investorindividualsarray[" + i
                  + "].individual.country", "Beneficial Owner " + x
                  + ": Country of Residence");
				if (!Utils.hasAuthority("ROLE_ADMINISTRATOR")
						&& Constants.FALSE.equals(individual
								.getWealthbyemployment())
						&& Constants.FALSE.equals(individual
								.getWealthbyinvestments())
						&& Constants.FALSE
								.equals(individual.getWealthbyother())) {
					errors.rejectValue("investorindividualsarray[" + i
							+ "].wealthbyemployment", null, "Beneficial Owner "
							+ x + " Source of Wealth is Mandatory");
				} else {
					if (Constants.TRUE.equals(individual.getWealthbyother())) {
						isRequiredConditional(
								errors,
								"investorindividualsarray[" + i
										+ "].wealthbyotherinfo",
								"Beneficial Owner "
										+ x
										+ ": Source of Wealth: If 'Other' is ticked, Information for 'Other'");
					}
				}
			}
			i++;
		}
		// reset index
		application.setBeneficiaryindex(0);
	}

	@SuppressWarnings("unchecked")
	public void validate(Object obj, Errors errors) {
		Application application = (Application) obj;

		// Set<Investorindividual> individuals = application
		// .getInvestorindividuals();
		// int i = 0;
		//
		// for (Investorindividual individual : individuals) {
		//
		// if ((Constants.TRUE.equals(individual.getIsbeneficiary()))
		// && (Constants.FALSE.equals(individual.getIsapplicant()))) {
		//
		// isRequired(errors, "investorindividualsarray[" + i
		// + "].individual.firstname", "Beneficial Owner " + (i + 1)
		// + " First Name");
		// isRequired(errors, "investorindividualsarray[" + i
		// + "].individual.lastname", "Beneficial Owner " + (i + 1)
		// + " Last Name");
		// isRequired(errors, "investorindividualsarray[" + i
		// + "].individual.address1", "Beneficial Owner " + (i + 1)
		// + " Residential Address");
		// isRequired(errors,
		// "investorindividualsarray[" + i + "].individual.suburb",
		// "Beneficial Owner " + (i + 1) + " Suburb");
		// isRequired(errors, "investorindividualsarray[" + i +
		// "].individual.state",
		// "Beneficial Owner " + (i + 1) + " State");
		// isRequired(errors, "investorindividualsarray[" + i
		// + "].individual.postcode", "Beneficial Owner " + (i + 1)
		// + " Postcode");
		// validatePostcode(errors, "investorindividualsarray[" + i
		// + "].individual.postcode", individual.getIndividual()
		// .getPostcode());
		// isRequired(errors, "investorindividualsarray[" + i
		// + "].individual.dateofbirth", "Beneficial Owner " + (i + 1)
		// + " Date of Birth");
		//
		//				
		// }
		// i++;
		// }
		// reset index
		application.setBeneficiaryindex(0);
	}
}
