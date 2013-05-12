package org.opi.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Advisorfirm;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;


/**
 * JavaBean form controller that is used to manage <code>Advisors</code> in the system.
 *
 * @author Paul McLachlan
 */
public class AdvisorsForm extends AbstractOpiForm {

   private static final Log log = LogFactory.getLog(AdvisorsForm.class);

   private String startView;
   private String previousView;

   public AdvisorsForm() {
		setCommandName("advisorfirm");
		// need a session to hold the formBackingObject
		setSessionForm(true);
	}

   public void setStartView(String startView) {
      this.startView = startView;
   }

	protected Object formBackingObject(HttpServletRequest request) throws ServletException {
      Advisorfirm advisorfirm = (Advisorfirm)getOpi().loadAdvisorfirm(ServletRequestUtils.getRequiredLongParameter(request, "advisorfirmid"));
		return advisorfirm;
	}

	/** Method inserts a new Advisorfirm */
   protected ModelAndView onSubmit(
         HttpServletRequest request, HttpServletResponse response, Object command, BindException errors)
         throws Exception {

      Advisorfirm advisorfirm = (Advisorfirm) command;

      if (WebUtils.hasSubmitParameter(request, "Back"))
         try {
            return new ModelAndView(this.previousView, "dealergroupid", advisorfirm.getDealergroup().getId());
         } catch (RuntimeException e) {
            log.warn("Session Expired");
            return new ModelAndView(this.startView);
         }
      
      String advisorid = ServletRequestUtils.getStringParameter(request, "advisorid");
      if (StringUtils.hasText(advisorid)) {
         Map<String, Object> model = new HashMap<String, Object>();
         model.put("advisorid", advisorid);
         return new ModelAndView(this.getSuccessView(), model);
      }
      else
         return new ModelAndView(this.startView);
	}

	protected ModelAndView handleInvalidSubmit(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return disallowDuplicateFormSubmission(request, response);
	}

   public void setPreviousView(String previousView) {
      this.previousView = previousView;
   }

}
