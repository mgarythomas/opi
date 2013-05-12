package org.opi.web;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.opi.domain.Dealergroup;
import org.springframework.web.servlet.ModelAndView;


/**
 * JavaBean form controller that is used to add a new <code>Dealergroup</code> to the system.
 *
 * @author Paul McLachlan
 */
public class AddDealergroupForm extends AbstractOpiForm {

	public AddDealergroupForm() {
		setCommandName("dealergroup");
		// OK to start with a blank command object
		setCommandClass(Dealergroup.class);
		// activate session form mode to allow for detection of duplicate submissions
		setSessionForm(true);
	}

	/** Method inserts a new <code>Dealergroup</code>. */
	protected ModelAndView onSubmit(Object command) throws ServletException {
      Dealergroup dealergroup = (Dealergroup) command;
		// delegate the insert to the Business layer
		getOpi().storeDealergroup(dealergroup);
      
      return new ModelAndView(getSuccessView(), "dealergroupId", dealergroup.getId());
	}

	protected ModelAndView handleInvalidSubmit(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return disallowDuplicateFormSubmission(request, response);
	}

}
