package com.ubs.opi.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;

import com.ubs.opi.domain.Advisor;
import com.ubs.opi.domain.Individual;
import com.ubs.opi.domain.Utils;

/**
 * JavaBean form controller that is used to add a new <code>Advisor</code> with Role.type "Advisor" to the system.
 *
 * @author Paul McLachlan
 */
public class AddAdvisorindividualForm extends AbstractOpiForm {

	public AddAdvisorindividualForm() {
		setCommandName("individual");
		// need a session to hold the formBackingObject
		setSessionForm(true);
	}

	/** Method creates a new <code>Individual</code> with the correct <code>Advisorfirm</code> info */
	protected Object formBackingObject(HttpServletRequest request) throws ServletException {
      Advisor advisor = getOpi().loadAdvisor(ServletRequestUtils.getRequiredLongParameter(request, "advisorId"));
      Individual individual = new Individual();
      //Advisorindividual advisorindividual = new Advisorindividual();
      //advisorindividual.setIndividual(individual);
      //advisor.addAdvisorindividual(advisorindividual);
      return individual;
	}

   /**
    * @see org.springframework.web.servlet.mvc.SimpleFormController#referenceData(javax.servlet.http.HttpServletRequest)
    */
   @Override
   protected Map referenceData(HttpServletRequest request) throws Exception {
       Map ref = new HashMap();
       ref.put("titles", Utils.getTitles());
       ref.put("states", Utils.getStates());
       ref.put("countries", Utils.getCountries());
       return ref;
   }

	/** Method inserts a new <code>Advisor</code>. */
	protected ModelAndView onSubmit(Object command) throws ServletException {
      Advisor advisor = (Advisor) command;
		// delegate the insert to the Business layer
		//getOpi().storeAdvisorindividual(advisor);
		return new ModelAndView(getSuccessView(), "advisorId", advisor.getId());
	}

	protected ModelAndView handleInvalidSubmit(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return disallowDuplicateFormSubmission(request, response);
	}

}
