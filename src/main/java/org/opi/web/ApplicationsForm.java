package org.opi.web;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.opi.domain.Advisor;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;


/**
 * JavaBean form controller that is used to manage <code>Applications</code> in the system.
 *
 * @author Paul McLachlan
 */
public class ApplicationsForm extends AbstractOpiForm {

   private String previousView;

   public ApplicationsForm() {
		setCommandName("advisor");
		// need a session to hold the formBackingObject
		setSessionForm(true);
	}

	protected Object formBackingObject(HttpServletRequest request) throws ServletException {
      Advisor advisor = (Advisor)getOpi().loadAdvisor(ServletRequestUtils.getRequiredLongParameter(request, "advisorid"));
		return advisor;
	}

  protected ModelAndView onSubmit(HttpServletRequest request,
                                  HttpServletResponse response,
                                  Object command,
                                  BindException errors) throws Exception {

    Advisor advisor = (Advisor) command;

    return new ModelAndView(this.previousView, "advisorfirmid", advisor.getAdvisorfirm().getId());
  }

	protected ModelAndView handleInvalidSubmit(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return disallowDuplicateFormSubmission(request, response);
	}

  public void setPreviousView(String previousView) {
    this.previousView = previousView;
  }

}
