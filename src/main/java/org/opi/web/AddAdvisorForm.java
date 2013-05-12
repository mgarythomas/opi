package org.opi.web;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.opi.domain.Advisor;
import org.opi.domain.Advisorfirm;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;


/**
 * JavaBean form controller that is used to add a new <code>Advisor</code> with Role.type "Advisor" to the system.
 *
 * @author Paul McLachlan
 */
public class AddAdvisorForm extends AbstractOpiForm {

	public AddAdvisorForm() {
		setCommandName("advisor");
		// need a session to hold the formBackingObject
		setSessionForm(true);
	}

	/** Method creates a new <code>Individual</code> with the correct <code>Advisorfirm</code> info */
	protected Object formBackingObject(HttpServletRequest request) throws ServletException {
      Advisorfirm advisorfirm = getOpi().loadAdvisorfirm(ServletRequestUtils.getRequiredLongParameter(request, "advisorfirmId"));
      Advisor advisor = new Advisor();
//      advisorfirm.getLogon().addIndividual(individual);
      //advisorfirm.getLogon().getRole().setRolename(Role.AdvisorRole);
      //advisorfirm.setLogon(individual.getLogon());
      return advisor;
	}

	/** Method inserts a new <code>Advisorfirm</code>. */
	protected ModelAndView onSubmit(Object command) throws ServletException {
      Advisor advisor = (Advisor) command;
		// delegate the insert to the Business layer
		//getClinic().storeAdvisor(advisor);
		return new ModelAndView(getSuccessView(), "dealergroupId", advisor.getAdvisorfirm().getDealergroup().getId());
	}

	protected ModelAndView handleInvalidSubmit(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return disallowDuplicateFormSubmission(request, response);
	}

}
