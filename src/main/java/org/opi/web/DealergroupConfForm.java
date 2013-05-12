package org.opi.web;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Advisor;
import org.opi.domain.Constants;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;


/**
 * JavaBean form controller that is used to add a new <code>Advisor</code> with Role.type "Advisor" to the system.
 *
 * @author Paul McLachlan
 */
public class DealergroupConfForm extends AbstractOpiForm {

   private static final Log log = LogFactory.getLog(DealergroupConfForm.class);

   private String changepasswordView;
   
   private String existingView;

   /**
    * Set the name of the view that should be used for existing display.
    */
   public void setExistingView(String existingView) {
      this.existingView = existingView;
   }

   public DealergroupConfForm() {
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
//      if (advisor.isAcceptedtermsofuse())
//         return new ModelAndView(getSuccessView()); 
      log.info("Traversing to "+getSuccessView()+" advisor id="+advisor.getId()+" status="+advisor.getId());
      //WebUtils.setSessionAttribute(request, "advisor", null); // clear session attribute
      
      // TODO Validate the Advisor in the dataBase. This can be moved somewhere else for further scrutiny
      advisor.setIsactivated(Constants.TRUE);
      if (advisor.isNew())
      {
         getOpi().storeAdvisorComplete(advisor);
         //getOpi().storeAdvisorValidated(advisor);
         // effectively boot the User out
         //SecurityContextHolder.clearContext();
         getOpi().myMailManager().sendUserNameandPassword(advisor);
         return new ModelAndView(getSuccessView());
      }
      else
      {
         getOpi().storeAdvisorSimple(advisor);
         //getOpi().myMailManager().sendUserNameandPassword(advisor);
         return new ModelAndView(this.changepasswordView);
      }
         
	}

	protected ModelAndView handleInvalidSubmit(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return disallowDuplicateFormSubmission(request, response);
	}

   public void setChangepasswordView(String changepasswordView)
   {
      this.changepasswordView = changepasswordView;
   }

}
