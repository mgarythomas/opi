package com.ubs.opi.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.ubs.opi.domain.Company;
import com.ubs.opi.domain.Individual;
import com.ubs.opi.domain.Utils;

/**
 * JavaBean form controller that is used to add a new <code>Bdm</code> with Role.type "Bdm" to the system.
 *
 * @author Paul McLachlan
 */
public class BdmForm extends AbstractOpiForm {

   private static final Log log = LogFactory.getLog(BdmForm.class);

   public BdmForm() {
		setCommandName("individual");
		// need a session to hold the formBackingObject
		setSessionForm(true);
	}

	/** Method creates a new <code>Individual</code> with the correct <code>Advisorfirm</code> info */
	protected Object formBackingObject(HttpServletRequest request) throws ServletException {

      Company provider = (Company)WebUtils.getRequiredSessionAttribute(request, "provider");
      try
      {
         String operation = (String)ServletRequestUtils.getRequiredStringParameter(request, "operation");
         if (operation.equals("create")) {
            Individual individual = new Individual();
            individual.setOccupation("BDM");
            individual.setEmployer(provider.getName());
            return individual;
         } else { //
            return this.getOpi().loadIndividual(new Long(provider.getTransbdmid()));
         }
      } catch (Exception e) {
         log.error("Error instantiating an Individual", e);
      }
      
      return new Individual();
	}

   /**
    * @see org.springframework.web.servlet.mvc.SimpleFormController#referenceData(javax.servlet.http.HttpServletRequest)
    */
   @Override
   protected Map referenceData(HttpServletRequest request) throws Exception {
       Map<String, Object> ref = new HashMap<String, Object>();
       ref.put("titles", Utils.getTitles());
       ref.put("states", Utils.getStates());
       return ref;
   }

	/** Method inserts a new <code>Advisorfirm</code>. */
	protected ModelAndView onSubmit(Object command) throws ServletException {
    Individual bdm = (Individual) command;
    this.getOpi().storeBdm(bdm);
    
		return new ModelAndView(getSuccessView());
	}

	protected ModelAndView handleInvalidSubmit(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return disallowDuplicateFormSubmission(request, response);
	}

}
