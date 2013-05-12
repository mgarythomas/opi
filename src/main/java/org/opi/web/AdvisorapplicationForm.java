package org.opi.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Advisor;
import org.opi.domain.Application;
import org.opi.domain.Utils;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;


/**
 * JavaBean form controller that is used to add a new <code>Advisor</code> with Role.type "Advisor" to the system.
 *
 * @author Paul McLachlan
 */
public class AdvisorapplicationForm extends AbstractOpiForm {

   private static final Log log = LogFactory.getLog(AdvisorapplicationForm.class);

   public AdvisorapplicationForm() {
		setCommandName("application");
		// need a session to hold the formBackingObject
		setSessionForm(true);
	}

	/** Method creates a new <code>Application</code> for a particular <code>Advisor</code> info */
	protected Object formBackingObject(HttpServletRequest request) throws ServletException {
      Application application = null;
      long advisorId;
      String applicationId = null;
      try
      {
         applicationId = ServletRequestUtils.getRequiredStringParameter(request, "applicationId");
      } catch (ServletRequestBindingException e)
      {
         log.info("applicationId=null - could have arrived from advsiorApplications");
      }
      if ( applicationId == null)
      {
         advisorId = ServletRequestUtils.getRequiredLongParameter(request, "advisorId");
         Advisor advisor = (Advisor)getOpi().loadAdvisor(advisorId);       
         String investorType = ServletRequestUtils.getStringParameter(request, "investorType");
      }
      else
      {
         log.info("has arrived from addAdvisorForm");
         application = getOpi().loadApplication(ServletRequestUtils.getRequiredLongParameter(request, "applicationId"));
      }
      return application;

   }

   /**
    * @see org.springframework.web.servlet.mvc.SimpleFormController#referenceData(javax.servlet.http.HttpServletRequest)
    */
   @Override
   protected Map referenceData(HttpServletRequest request) throws Exception {
       Map<String, Object> ref = new HashMap<String, Object>();
       ref.put("titles", Utils.getTitles());
       ref.put("states", Utils.getStates());
       ref.put("countries", Utils.getCountries());
       return ref;
   }

	/** Method inserts a new <code>Advisor</code>. */
	protected ModelAndView onSubmit(Object command) throws ServletException {
      Application application = (Application) command;
      if (application.isNew())
         // delegate the insert to the Business layer
         getOpi().storeApplication(application); 
      return new ModelAndView(getSuccessView(), "applicationId", application.getId());
	}

	protected ModelAndView handleInvalidSubmit(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return disallowDuplicateFormSubmission(request, response);
	}

}
