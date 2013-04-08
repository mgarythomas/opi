package com.ubs.opi.web;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;

import com.ubs.opi.domain.Dealergroup;

/**
 * JavaBean Form controller that is used to edit an existing <code>Dealergroup</code>.
 *
 * @author Paul McLachlan
 */
public class EditDealergroupForm extends AbstractOpiForm {

	public EditDealergroupForm() {
		setCommandName("dealergroup");
		// need a session to hold the formBackingObject
		setSessionForm(true);
		// initialize the form from the formBackingObject
		setBindOnNewForm(true);
	}

	/** Method forms a copy of an existing Dealergroup for editing */
	protected Object formBackingObject(HttpServletRequest request) throws ServletException {
		// get the Dealergroup referred to by id in the request
		return getOpi().loadDealergroup(ServletRequestUtils.getRequiredLongParameter(request, "dealergroupId"));
	}

	/** Method updates an existing Dealergroup. */
	protected ModelAndView onSubmit(Object command) throws ServletException {
		Dealergroup dealergroup = (Dealergroup) command;
		// delegate the update to the Business layer
		getOpi().storeDealergroup(dealergroup);

		return new ModelAndView(getSuccessView(), "dealergroupId", dealergroup.getId());
	}

}
