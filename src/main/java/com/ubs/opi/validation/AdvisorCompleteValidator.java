package com.ubs.opi.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import org.springframework.web.util.WebUtils;

import com.ubs.opi.domain.Advisor;
import com.ubs.opi.domain.Advisorfirm;
import com.ubs.opi.domain.Company;
import com.ubs.opi.domain.Dealergroup;

/**
 * <code>Validator</code> for <code>Advisor</code> forms.
 *
 * @author Paul McLachlan
 */
public class AdvisorCompleteValidator extends OpiValidator implements Validator {

   public boolean supports(Class clazz) {
      return Advisor.class.isAssignableFrom(clazz);
   }

   //
   // Advisor validation
   //
   public static void advisorValidate(Advisor advisor, Errors errors) {
      isRequired(errors, "individual.firstname", "First Name");
      isRequired(errors, "individual.lastname", "Surname");
      isRequired(errors, "individual.workemail", "Email");
      isRequiredConditional(errors, "individual.workphone", "Work Phone");
      isRequiredConditional(errors, "individual.workfax", "Fax");
      //
      // Validate Email
      //
      OpiValidator.validateEmail(errors, "individual.workemail", advisor.getIndividual().getWorkemail());
   }

   public void validate(Object obj, Errors errors) {
      this.mandatoryCounter = 0;
      Advisor advisor = (Advisor) obj;
      //
      // dealergroup validation
      //
      isRequired(errors, "advisorfirm.dealergroup.company.name", "Dealer Group Name");
      isRequired(errors, "advisorfirm.dealergroup.afsl", "AFSL");
      isRequired(errors, "advisorfirm.dealergroup.company.abn", "ABN");
      //
      // validate ABN & AFSL
      //
      Dealergroup dg = advisor.getAdvisorfirm().getDealergroup();
      dg.setAfsl(validateAFSL(errors, "advisorfirm.dealergroup.afsl", dg.getAfsl()));
      dg.getCompany().setAbn(validateABN(errors, "advisorfirm.dealergroup.company.abn", dg.getCompany().getAbn()));

      //
      // Advisorfirm validation
      //
      isRequired(errors, "advisorfirm.company.name", "Business Name");
      isRequiredConditional(errors, "advisorfirm.company.address1", "Postal Address");
      isRequiredConditional(errors, "advisorfirm.company.suburb", "Suburb");
      isRequiredConditional(errors, "advisorfirm.company.postcode", "Postcode");
      //
      // Validate ABN
      //
      Company firm = advisor.getAdvisorfirm().getCompany();

      firm.setAbn(validateABN(errors, "advisorfirm.company.abn", firm.getAbn()));

      //
      // Advisor validation
      //
//      isRequired(errors, "individual.firstname", "First Name");
//      isRequired(errors, "individual.lastname", "Surname");
//      isRequired(errors, "individual.workemail", "Email");
//      isRequiredConditional(errors, "individual.workphone", "Work Phone");
//      isRequiredConditional(errors, "individual.workfax", "Fax");
//      //
//      // Validate Email
//      //
//      validateEmail(errors, "individual.workemail", advisor.getIndividual().getWorkemail());

      //
      // populate error structures
      //
      this.rejectMandatory(errors);
      OpiValidator.logErrors(errors);

   }

}
