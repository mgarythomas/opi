package org.opi.web;

//import java.util.HashMap;
//import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.opi.domain.Advisorfirm;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;


/**
 * JavaBean Form controller that is used to edit an existing <code>Advisorfirm</code>.
 *
 * @author Paul McLachlan
 */
public class EditAdvisorfirmForm extends AbstractOpiForm {

	public EditAdvisorfirmForm() {
		setCommandName("advisorfirm");
		// need a session to hold the formBackingObject
		setSessionForm(true);
		// initialize the form from the formBackingObject
		setBindOnNewForm(true);
	}

	protected Object formBackingObject(HttpServletRequest request) throws ServletException {
		// get the Pet referred to by id in the request
		return getOpi().loadAdvisorfirm(ServletRequestUtils.getRequiredLongParameter(request, "advisorfirmId"));
	}

	protected void onBind(HttpServletRequest request, Object command) throws ServletException {
      Advisorfirm advisorfirm = (Advisorfirm) command;
	}

	/** Method updates an existing Pet */
	protected ModelAndView onSubmit(Object command) throws ServletException {
      Advisorfirm advisorfirm = (Advisorfirm) command;
		return new ModelAndView(getSuccessView(), "dealergroupId", advisorfirm.getDealergroup().getId());
	}

}
