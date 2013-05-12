package org.opi.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.opi.domain.Individual;
import org.opi.domain.Utils;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;


/**
 * JavaBean Form controller that is used to edit an existing <code>Individual</code>.
 *
 * @author Paul McLachlan
 */
public class EditIndividualForm extends AbstractOpiForm {

	public EditIndividualForm() {
		setCommandName("individual");
		// need a session to hold the formBackingObject
		setSessionForm(true);
		// initialize the form from the formBackingObject
		setBindOnNewForm(true);
	}

   /**
    * @see org.springframework.web.servlet.mvc.SimpleFormController#referenceData(javax.servlet.http.HttpServletRequest)
    */
   @Override
   protected Map referenceData(HttpServletRequest request) throws Exception {
       Map<String, Object> ref = new HashMap<String, Object>();
       ref.put("titles", Utils.getTitles());
       ref.put("states", Utils.getStates());
       ref.put("countries", Utils.getCountries());
       return ref;
   }

	/** Method forms a copy of an existing Individual for editing */
	protected Object formBackingObject(HttpServletRequest request) throws ServletException {
		// get the Dealergroup referred to by id in the request
		return getOpi().loadIndividual(ServletRequestUtils.getRequiredLongParameter(request, "individualId"));
	}

	/** Method updates an existing Dealergroup. */
   protected ModelAndView onSubmit(
         HttpServletRequest request, HttpServletResponse response, Object command, BindException errors)
         throws Exception {
      //	protected ModelAndView onSubmit(Object command) throws ServletException {
		Individual individual = (Individual) command;
		// delegate the update to the Business layer
		getOpi().storeIndividual(individual);

      Map<String, Object> model = new HashMap<String, Object>(); 
      model.put("advisorId", ServletRequestUtils.getRequiredLongParameter(request, "advisorId"));
      model.put("investorType", ServletRequestUtils.getRequiredStringParameter(request, "investorType"));
      model.put("productName", ServletRequestUtils.getRequiredStringParameter(request, "productName"));
      model.put("applicationId", ServletRequestUtils.getRequiredLongParameter(request, "applicationId"));
      
      return new ModelAndView(getSuccessView(), model);

   }

}
