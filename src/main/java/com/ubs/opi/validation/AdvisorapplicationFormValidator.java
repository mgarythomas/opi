package com.ubs.opi.validation;

import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.ubs.opi.domain.Application;
import com.ubs.opi.domain.Company;
import com.ubs.opi.domain.Constants;
import com.ubs.opi.domain.Investorindividual;
import com.ubs.opi.domain.Trust;
import com.ubs.opi.domain.Utils;

/**
 * <code>Validator</code> for <code>Advisorapplications</code> forms.
 * 
 * @author Paul McLachlan
 */
public class AdvisorapplicationFormValidator extends OpiValidator implements
		Validator {

   private static final Log log = LogFactory.getLog(AdvisorapplicationFormValidator.class);

   public boolean supports(Class clazz) {
		return Application.class.isAssignableFrom(clazz);
	}


   @SuppressWarnings("unchecked")
   public void validate(Object obj, Errors errors) {
     log.info("not actually doing anything in the validate() method");      
   }

      @SuppressWarnings("unchecked")
   public static void validateDesignate(Application application,
         Errors errors) {
   
   		//
		// Validate Acct Designation
		//
		isRequired(errors, "accountdesignation", "Account Name");
		validateAcctDesignateName(errors, "accountdesignation", application
				.getAccountdesignation());
		isRequiredConditional(errors, "firstname", "Contact Person First Name");
		isRequiredConditional(errors, "lastname", "Contact Person Surname");
		isRequiredConditional(errors, "homephone", "Contact Telephone");
		isRequiredConditional(errors, "address1", "Postal Address");
		isRequiredConditional(errors, "suburb", "Suburb");
		isRequiredConditional(errors, "postcode", "Postcode");
      isRequiredConditional(errors, "country", "Country ");
		if (!Utils.hasAuthority("ROLE_ADMINISTRATOR")) {
			if (application.getCountry().equals("AUSTRALIA"))
				isRequired(errors, "state", "State");
		}
		validatePostcode(errors, "postcode", application.getPostcode());
		//
		// Validate Company
		//
		if (application.getCompany() != null) {
			isRequired(errors, "company.name", "Company Name");
			Company co = application.getCompany();
      if (StringUtils.isBlank(co.getAbn()) &&
          StringUtils.isBlank(co.getAcn()) &&
          StringUtils.isBlank(co.getArbn())) {
        errors.reject(null, "ABN, ACN or ARBN must be entered.");
      } else {
        if (!StringUtils.isBlank(co.getAbn())) {
    			co.setAbn(validateABN(errors, "company.abn", application
    					.getCompany().getAbn()));
        }
        if (!StringUtils.isBlank(co.getAcn())) {
          co.setAbn(validateACN(errors, "company.acn", application
              .getCompany().getAbn()));
        }
        if (!StringUtils.isBlank(co.getArbn())) {
          co.setArbn(validateARBN(errors, "company.arbn", application
              .getCompany().getAbn()));
        }
      }
      if (application.getProduct().getCode().equals("hfa")) {
        co.setTfn(validateTFN(errors, "company.tfn", co.getTfn()));
      }
      if (application.getProduct().getCode().equals("hfa")) {
        isRequiredConditional(errors, "company.incorporationcountry",
          "Country of Incorporation");
      }
			isRequiredConditional(errors, "company.incorporationdate",
					"Date of Incorp");
		}
		//
		// Validate Trust
		//
		if (application.getTrust() != null) {
			isRequired(errors, "trust.companyByCompanyid.name",
					"Trust / Super Fund Name");
			Trust trust = application.getTrust();
			//
			// The validation for the Trust ABN field should be that
			// it is mandatory if the super fund box is checked
			// (i.e. if the trust is a super fund then must provide the ABN)
			//
			if (Constants.TRUE.equals(trust.getIssuperfund())) {
				isRequiredConditional(errors, "trust.companyByCompanyid.abn",
						"If Trust a Super Fund, ABN");
			}
			// isRequired(errors, "trust.companyByCompanyid.arbn", "ARBN");

			Company co = trust.getCompanyByCompanyid();
			co.setAbn(validateABN(errors, "trust.companyByCompanyid.abn", co
					.getAbn()));
			co.setArbn(validateARBN(errors, "trust.companyByCompanyid.arbn", co
					.getArbn()));
      if (application.getProduct().getCode().equals("hfa")) {
  			co.setTfn(validateTFN(errors, "trust.companyByCompanyid.tfn", co
  					.getTfn()));
      }
      
			//
			// src of wealth
			//
      if (application.getProduct().getCode().equals("hfa")) {
  			if (!Utils.hasAuthority("ROLE_ADMINISTRATOR")
  					&& Constants.FALSE.equals(trust.getWealthbyemployment())
  					&& Constants.FALSE.equals(trust.getWealthbyinvestments())
  					&& Constants.FALSE.equals(trust.getWealthbyother())) {
  				errors.rejectValue("trust.wealthbyemployment", null,
  						"Trust: Source of Wealth is Mandatory");
  			} else {
  				if (Constants.TRUE.equals(trust.getWealthbyother())) {
  					isRequiredConditional(errors, "trust.wealthbyotherinfo",
  							"Trust: Source of Wealth: If 'Other' is ticked, Information for 'Other'");
  				}
  			}
      }
		}

		OpiValidator.logErrors(errors);
		//
		// reset application counter
		//
		application.setApplicantindex(0);
	}

	@SuppressWarnings("unchecked")
	public static void validateIndividuals(Application application,
			Errors errors) {
		// Application application = (Application) obj;

		boolean isGuarantorSet = false;
		boolean isSoleDirectorSet = false;

		if ((application.getCompany() != null)) {
			Set<Investorindividual> individuals = application
					.getInvestorindividuals();
			//
			// Loop through looking for Guarantor setting
			//
			int idx = 0;
			for (Investorindividual investorindividual : individuals) {
				//
				// test for sole directors
				//
				if (Constants.TRUE.equals(investorindividual
						.getIssoledirector())) {
					isSoleDirectorSet = true;
					//
					// TODO FIXME not getting set
					//
					investorindividual.setIsguarantor(Constants.TRUE);
				}
				//
				// test for guarantors
				//
				if (Constants.TRUE.equals(investorindividual.getIsguarantor())) {
					isGuarantorSet = true;
					idx++;
				}
			}
      
      if (!isSoleDirectorSet && (application.getType() == Constants.CORPORATE_TYPE || application.getType() == Constants.CORPORATE_TRUST_TYPE) && application.getInvestorindividuals().size() < 2) {
        errors.rejectValue("investorindividuals[0].issoledirector", null,
              "Cannot proceed with less than 2 directors unless one director is marked as Sole Director.");
      }
      
			//
			// Loop through errors
			//
			Investorindividual[] investorindividualarray = application.getInvestorindividualsarray();
         if (!Utils.hasAuthority("ROLE_ADMINISTRATOR")) {
   			if (!isGuarantorSet) {
   				for (int i = 0; i < investorindividualarray.length; i++) {
   					errors.rejectValue("investorindividuals[" + i
   							+ "].isguarantor", null,
   							"At least one of the Directors must be guarantor.");
   				}
   
   			}
         }
		}

		Set<Investorindividual> individuals = application
				.getInvestorindividuals();
		int i = 0;

		for (Investorindividual individual : individuals) {

			if ((application.getCompany() != null) 
               && (Constants.FALSE.equals(individual.getIsdirector())
					|| (isSoleDirectorSet && Constants.FALSE.equals(individual.getIssoledirector()))))
				continue;

			isRequired(errors, "investorindividuals[" + i
					+ "].individual.firstname", "Applicant " + (i + 1)
					+ ": First Name");
			isRequired(errors, "investorindividuals[" + i
					+ "].individual.lastname", "Applicant " + (i + 1)
					+ ": Last Name");
			isRequiredConditional(errors, "investorindividuals[" + i
					+ "].individual.address1", "Applicant " + (i + 1)
					+ ": Residential Address");
			validateResidentialAddress(errors, "investorindividuals[" + i
					+ "].individual.address1", individual.getIndividual()
					.getAddress1());
			isRequiredConditional(errors, "investorindividuals[" + i
					+ "].individual.suburb", "Applicant " + (i + 1)
					+ ": Suburb");
      if (application.getProduct().getCode().equals("hfa")) {
           isRequiredConditional(errors, "investorindividuals[" + i
                 + "].individual.nationality", "Applicant " + (i + 1)
                 + ": Nationality");
      }
         isRequiredConditional(errors, "investorindividuals[" + i
               + "].individual.townofbirth", "Applicant " + (i + 1)
               + ": Town of Birth"); 
         isRequiredConditional(errors, "investorindividuals[" + i
                 + "].individual.countryofbirth", "Applicant " + (i + 1)
                 + ": Country of Birth"); 
         isRequiredConditional(errors, "investorindividuals[" + i
               + "].individual.country", "Applicant " + (i + 1)
               + ": Country of Residence");
			if (!Utils.hasAuthority("ROLE_ADMINISTRATOR")) {
				if (individual.getIndividual().getCountry().equals("AUSTRALIA"))
					isRequired(errors, "investorindividuals[" + i + "].individual.state", "Applicant " + (i + 1) + ": State");
			}
			isRequiredConditional(errors, "investorindividuals[" + i
					+ "].individual.state", "Applicant " + (i + 1) + ": State");
			isRequiredConditional(errors, "investorindividuals[" + i
					+ "].individual.postcode", "Applicant " + (i + 1)
					+ ": Postcode");
			validatePostcode(errors, "investorindividuals[" + i
					+ "].individual.postcode", individual.getIndividual()
					.getPostcode()); 
			isRequiredConditional(errors, "investorindividuals[" + i
					+ "].individual.dateofbirth", "Applicant " + (i + 1)
					+ ": Date of Birth");

         isRequiredConditional(errors, "investorindividuals[" + i
					+ "].individual.occupation", "Applicant " + (i + 1)
					+ ": Occupation");

			//
			// src of wealth
			//
			if (application.getProduct().getCode().equals("hfa") && 
          !Utils.hasAuthority("ROLE_ADMINISTRATOR") && 
          Constants.FALSE.equals(individual.getWealthbyemployment()) && 
          Constants.FALSE.equals(individual .getWealthbyinvestments()) && 
          Constants.FALSE.equals(individual.getWealthbyother())) {
				errors.rejectValue("investorindividuals[" + i
						+ "].wealthbyemployment", null, "Applicant " + (i + 1)
						+ ": Source of Wealth is Mandatory");
			} else {
				if (Constants.TRUE.equals(individual.getWealthbyother())) {
					isRequiredConditional(
							errors,
							"investorindividuals[" + i + "].wealthbyotherinfo",
							"Applicant "
									+ (i + 1)
									+ ": Source of Wealth: If 'Other' is ticked, Information for 'Other'");
				}
			}

			i++;
		}
      OpiValidator.logErrors(errors);
	}   
   

}
