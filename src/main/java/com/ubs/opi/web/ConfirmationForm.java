package com.ubs.opi.web;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.ubs.opi.domain.Application;
import com.ubs.opi.domain.Constants;
import com.ubs.opi.domain.Utils;
import com.ubs.opi.service.OpiServiceIF;

/**
 * JavaBean form controller that is used to add a new <code>Advisor</code>
 * with Role.type "Advisor" to the system.
 * 
 * @author Paul McLachlan
 */
public class ConfirmationForm extends AbstractOpiForm {

	private static final Log log = LogFactory.getLog(ConfirmationForm.class);
  private OpiServiceIF opiService;

  public ConfirmationForm() {
		setCommandName("application");
		// need a session to hold the formBackingObject
		setSessionForm(true);
	}

	/**
	 * Method creates a new <code>Application</code> for a particular
	 * <code>Advisor</code> info
	 */
	protected Object formBackingObject(HttpServletRequest request)
			throws ServletException {

		return this.getApplication(request, false);
	}
  
  protected Map referenceData(HttpServletRequest request) throws Exception {
    Map<String, Object> ref = new HashMap<String, Object>();
    
    ref.put("startpage", StringUtils.removeStart(super.getUserStartView(request), "redirect:/"));
    ref.put("isdaapproved", this.opiService.isDaApproved(super.getAdvisor(request, false)));
    
    return ref;
  }

	/** Method inserts a new <code>Application</code>. */
	protected ModelAndView onSubmit(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
			throws Exception {
		Application application = (Application) command;
    Map<String, Object> model = new HashMap<String, Object>();

    if (WebUtils.hasSubmitParameter(request, "save")) {
			application.setStatus(Constants.DRAFT_STATUS.longValue());
		} else {
			if (!Utils.hasAuthority("ROLE_ADMINISTRATOR")) {
				if (!application.isDeclarationunderstood())
					errors.rejectValue("declarationunderstood", null, "Declaration confirmation required if Submitting application");

				if (!application.isApplicantidentified())
					errors.rejectValue("applicantidentified", null, "Applicant Identification confirmation required if Submitting application");

				if (errors.hasErrors())
					return showForm(request, response, errors);
			}

      application.setApplicationdate(new Date());
			application.setStatus(Constants.SUBMITTED_STATUS.longValue());

      model.put("showPdf", new Long(application.getId()));
    }

		getOpi().storeApplicationDirty(application);

		log.info("Traversing to " + getSuccessView() + " application id="
				+ application.getStatus() + " status="
				+ application.getStatus() + " accountdesignation="
				+ application.getAccountdesignation());
    
    return new ModelAndView(super.getUserStartView(request), model);
	}

	protected ModelAndView handleInvalidSubmit(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		return disallowDuplicateFormSubmission(request, response);
	}

  /**
   * @param opiService the opiService to set
   */
  public void setOpiService(OpiServiceIF opiService) {
    this.opiService = opiService;
  }
}
