package com.ubs.opi.web;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;

import com.ubs.opi.domain.Advisor;
import com.ubs.opi.domain.Constants;

/**
 * JavaBean form controller that is used to add a new <code>Advisor</code> with Role.type "Advisor" to the system.
 *
 * @author Paul McLachlan
 */
public class ChangepasswordForm extends AbstractOpiForm {

   private static final Log log = LogFactory.getLog(ChangepasswordForm.class);

   public ChangepasswordForm() {
		setCommandName("advisor");
		// need a session to hold the formBackingObject
		setSessionForm(true);
	}

	/** Method creates a new <code>Application</code> for a particular <code>Advisor</code> info */
	protected Object formBackingObject(HttpServletRequest request) throws ServletException {

      Advisor advisor = this.getAdvisor(request, false);
      advisor.getIndividual().getUsers().setPassword("");
      advisor.getIndividual().getUsers().setCheckpassword("");
      return advisor;
   }

	/** Method inserts a new <code>Advisor</code>. */
   protected ModelAndView onSubmit(
         HttpServletRequest request, HttpServletResponse response, Object command, BindException errors)
         throws Exception {
      Advisor advisor = (Advisor) command;

      log.info("advisor.individual.password="+advisor.getIndividual().getUsers().getPassword()+" is Updated");

      advisor.getIndividual().getUsers().setPasswordconfirmed(Constants.TRUE);
      this.getOpi().storeUsers(advisor.getIndividual().getUsers());
      
      return new ModelAndView(getSuccessView());
	}

	protected ModelAndView handleInvalidSubmit(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return disallowDuplicateFormSubmission(request, response);
	}

}
