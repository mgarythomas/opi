package org.opi.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.opi.domain.Dealergroup;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;


/**
 * JavaBean form controller that is used to manage <code>Advisorfirms</code> to the system.
 *
 * @author Paul McLachlan
 */
public class AdvisorfirmsForm extends AbstractOpiForm {

   private String existingView;
   private String previousView;

   public AdvisorfirmsForm() {
		setCommandName("dealergroup");
		// need a session to hold the formBackingObject
		setSessionForm(true);
	}

   public void setExistingView(String existingView) {
      this.existingView = existingView;
   }

	protected Object formBackingObject(HttpServletRequest request) throws ServletException {
//		Dealergroup dealergroup = (Dealergroup)getOpi().findDealergroups(ServletRequestUtils.getRequiredStringParameter(request, "afsl")).toArray()[0];
//      WebUtils.setSessionAttribute(request, "afsl", dealergroup.getAfsl());
      Dealergroup dealergroup = getOpi().loadDealergroup(ServletRequestUtils.getRequiredLongParameter(request, "dealergroupid"));
      WebUtils.setSessionAttribute(request, "dealergroupid", dealergroup.getId());
      return dealergroup;
	}

	/** Method inserts a new Advisorfirm */
   protected ModelAndView onSubmit(HttpServletRequest request, HttpServletResponse response, Object command, BindException errors) throws Exception 
   {
      Dealergroup dealergroup = (Dealergroup) command;

      if (WebUtils.hasSubmitParameter(request, "Back"))
         return new ModelAndView(this.previousView);
      
      String advisorfirmid = ServletRequestUtils.getStringParameter(request, "advisorfirmid");
      if (StringUtils.hasText(advisorfirmid)) {
         Map model = new HashMap<String,String>();
         model.put("advisorfirmid", advisorfirmid);
         return new ModelAndView(this.getSuccessView(), model);
      }

      // should never get here
      return new ModelAndView(this.existingView);
	}

	protected ModelAndView handleInvalidSubmit(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
      
		return disallowDuplicateFormSubmission(request, response);
	}

   public void setPreviousView(String previousView) {
      this.previousView = previousView;
   }

}
