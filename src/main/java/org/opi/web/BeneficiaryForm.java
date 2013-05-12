package org.opi.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Application;
import org.opi.domain.Constants;
import org.opi.domain.Individual;
import org.opi.domain.Investorindividual;
import org.opi.domain.Utils;
import org.opi.validation.BeneficiaryFormValidator;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;


/**
 * JavaBean form controller that is used to add a new <code>Advisor</code> with Role.type "Advisor" to the system.
 *
 * @author Paul McLachlan
 */
public class BeneficiaryForm extends AbstractOpiForm {

   private static final Log log = LogFactory.getLog(BeneficiaryForm.class);

   long indexcnt = Constants.NEW_DOMAIN_ID;

   public BeneficiaryForm() {
		setCommandName("application");
		// need a session to hold the formBackingObject
		setSessionForm(true);
	}

	/** Method creates a new <code>Application</code> for a particular <code>Advisor</code> info */
	protected Object formBackingObject(HttpServletRequest request) throws ServletException {

      Application application = null;
      boolean newBeneficiary;

      application = this.getApplication(request, true);

      try
      {
         newBeneficiary = ServletRequestUtils.getRequiredBooleanParameter(request, "newbeneficiary");
         if (newBeneficiary)
         {
            Investorindividual investorindividual = new Investorindividual();
            investorindividual.setIndividual(new Individual());
            investorindividual.setIsbeneficiary(Constants.TRUE);
            investorindividual.setIsapplicant(Constants.FALSE);
            investorindividual.setRole(Constants.BENEFICFIARY);
            investorindividual.setApplication(application);
            application.setBeneficiary(investorindividual);
            application.addInvestorindividual(investorindividual);
            application.addBeneficiary(investorindividual);
//            application.createBeneficiaries();
         }
      } catch (ServletRequestBindingException e)
      {
         log.info("newbeneficiary = null!");
      }

      return application;
   }

   @Override
   protected Map referenceData(HttpServletRequest request) throws Exception {
       Map<String, Object> ref = new HashMap<String, Object>();
       ref.put("titles", Utils.getTitles());
       ref.put("states", Utils.getStates());
       ref.put("defaultcountries", Utils.getDefaultCountries());
       ref.put("countries", Utils.getCountries());
       ref.put("nationalities", Utils.getNationalities());
       ref.put("startpage", StringUtils.removeStart(super.getUserStartView(request), "redirect:/"));
       return ref;
   }

	/** Method inserts a new <code>Advisor</code>. */
	//protected ModelAndView onSubmit(Object command) throws ServletException {
      protected ModelAndView onSubmit(
            HttpServletRequest request, HttpServletResponse response, Object command, BindException errors)
            throws Exception {
      Application application = (Application) command;
      application.setBeneficiaryindex(0);

      Map<String, Object> model = new HashMap<String, Object>();

      try
      {
         String investorindex = ServletRequestUtils.getRequiredStringParameter(request, "investorindex");

         if ( !investorindex.equals("null") ) // WebUtils.hasSubmitParameter(request, "remove"))
         {
            int i = ServletRequestUtils.getRequiredIntParameter(request, "investorindex");

            application.setBeneficiary(null);
            getOpi().removeInvestor(application, i); // persist all changes


            WebUtils.setSessionAttribute(request, "application", application);
            log.info("setSessionAttribute Application; id="+application.getStatus()+" investors="+application.getInvestorindividuals().size()+" accountdesignation="+application.getAccountdesignation());
            return new ModelAndView("redirect:/beneficiary.htm", model);
         }
      } catch (Exception e)
      {
         log.info("investorindex not present");
      }
      
      BeneficiaryFormValidator.validateBeneficiarys(application, errors); // (application, errors);
      if (errors.hasErrors())
         return showForm(request, response, errors);

      if (application.getBeneficiary() != null)
      {
         getOpi().storeBeneficiary(application);
         application.setBeneficiary(null); // reset beneficiary
      }
      else
      {
         getOpi().storeApplication(application); // actually does a attachDirty
      }

      WebUtils.setSessionAttribute(request, "application", application); // clear session attribute
      log.info("Store in Session Application; id="+application.getStatus()+" status="+application.getStatus()+" accountdesignation="+application.getAccountdesignation());

      if (WebUtils.hasSubmitParameter(request, "save"))
         return new ModelAndView(this.getUserStartView(request));

      if (WebUtils.hasSubmitParameter(request, "addbeneficiary"))
      {
         model.put("newbeneficiary", true);
         return new ModelAndView("redirect:/beneficiary.htm", model);
      }

      return new ModelAndView(getSuccessView(), model);
	}

	protected ModelAndView handleInvalidSubmit(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return disallowDuplicateFormSubmission(request, response);
	}

}
