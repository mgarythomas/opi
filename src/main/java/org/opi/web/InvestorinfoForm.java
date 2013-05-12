package org.opi.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Advisor;
import org.opi.domain.Application;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;


/**
 * JavaBean form controller that is used to add a new <code>Financial Data</code> to the application.
 *
 * @author Paul McLachlan
 */
public class InvestorinfoForm extends AbstractOpiForm {

   private static final Log logger = LogFactory.getLog(InvestorinfoForm.class);

   public InvestorinfoForm() {
		setCommandName("application");
		// need a session to hold the formBackingObject
		setSessionForm(true);
	}

	/** Method creates a new <code>Application</code> for a particular <code>Advisor</code> info */
	protected Object formBackingObject(HttpServletRequest request) throws ServletException {

      return this.getApplication(request, false); //application;
   }
  
  protected Map referenceData(HttpServletRequest request) throws Exception {
    Map<String, Object> ref = new HashMap<String, Object>();
    
    ref.put("startpage", StringUtils.removeStart(super.getUserStartView(request), "redirect:/"));
    
    return ref;
  }

	/** Method inserts a new <code>Advisor</code>. */
   protected ModelAndView onSubmit(
         HttpServletRequest request, HttpServletResponse response, Object command, BindException errors)
         throws Exception {
      Application application = (Application) command;

      getOpi().storeApplicationDirty(application); // actually does a attachDirty

      if (WebUtils.hasSubmitParameter(request, "save"))
         return new ModelAndView(this.getUserStartView(request)); 

      Advisor advisor = this.getAdvisor(request, true); 

      String isdaapproved = this.getOpi().loadIsDaApproved(advisor); //advisor.getAdvisorfirm().getDealergroup().getIsdaapproved();

      WebUtils.setSessionAttribute(request, "application", application);

      Map<String, Object> model = new HashMap<String, Object>();
      
      model.put("isdaapproved", isdaapproved);

      return new ModelAndView(getSuccessView(), model);
   }

}
