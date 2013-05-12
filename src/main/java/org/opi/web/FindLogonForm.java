package org.opi.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.opi.domain.Advisor;
import org.opi.domain.Individual;
import org.opi.domain.Users;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;


/**
 * JavaBean Form controller that is used to search for <code>Logon</code>s by last name.
 *
 * @author Paul McLachlan
 */
public class FindLogonForm extends AbstractOpiForm {

	private String failureView;

	/** Creates a new instance of LogonForm */
	public FindLogonForm() {
		setCommandName("users");
		// OK to start with a blank command object
		setCommandClass(Users.class);
	}

	/**
	 * Set the name of the view that should be used for selection display.
	 */
	public void setFailureView(String failureView) {
		this.failureView = failureView;
	}

	protected void initApplicationContext() {
		super.initApplicationContext();
		if (this.failureView == null) {
			throw new IllegalArgumentException("failureView isn't set");
		}
	}

	/**
	 * Method used to search for Logon renders View depending on how many are found.
	 */
	protected ModelAndView onSubmit(
			HttpServletRequest request, HttpServletResponse response, Object command, BindException errors)
			throws Exception {

   		Users users = (Users) command;
   
   		// find Dealergroups by last name
         Users result = getOpi().findUsers(users.getUsername(), users.getPassword());
         if (result == null) {
            return new ModelAndView(this.failureView, "message", "Invalid username or password.  Signon failed.");
         }
         Individual individual = users.getIndividuals().iterator().next();
         Advisor advisor = getOpi().findAdvisor(individual, 0);
   
   		return new ModelAndView(getSuccessView(), "advisorId", advisor.getId());
      }

}
