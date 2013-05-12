package org.opi.web;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Advisor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;


/**
 * JavaBean form controller that is used to add a new <code>Advisor</code> with Role.type "Advisor" to the system.
 *
 * @author Paul McLachlan
 */
public class EmailConfForm extends AbstractOpiForm {

   private static final Log log = LogFactory.getLog(EmailConfForm.class);

   public EmailConfForm() {
		setCommandName("advisor");
		// need a session to hold the formBackingObject
		setSessionForm(true);
	}
   
	/** Method creates a new <code>Application</code> for a particular <code>Advisor</code> info */
	protected Object formBackingObject(HttpServletRequest request) throws ServletException {

      return this.getAdvisor(request, false);
   }

	/** Method inserts a new <code>Application</code>. */
   protected ModelAndView onSubmit(
         HttpServletRequest request, HttpServletResponse response, Object command, BindException errors)
         throws Exception {
      Advisor advisor = (Advisor) command;
      WebUtils.setSessionAttribute(request, "advisor", null); // clear session attribute
      
      // effectively boot the User out
      SecurityContextHolder.clearContext();
      return new ModelAndView("/j_spring_security_logout");
	}

	protected ModelAndView handleInvalidSubmit(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return disallowDuplicateFormSubmission(request, response);
	}

}
