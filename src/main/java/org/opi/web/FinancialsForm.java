package org.opi.web;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Application;
import org.opi.service.AdvisorServiceIF;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;


/**
 * Controller for the financials section.
 *
 * @author Paul McLachlan
 * @author Ana Velez
 */
public class FinancialsForm extends AbstractOpiForm {
  //~ Constructors -------------------------------------------------------------

  public FinancialsForm() {
    setCommandName("application");
    setSessionForm(true);
  }

  //~ Methods ------------------------------------------------------------------


  @Override
  protected Application formBackingObject(HttpServletRequest request)
                                   throws ServletException {
    return super.getApplication(request, false);
  }

  @Override
  protected ModelAndView onSubmit(HttpServletRequest request,
                                  HttpServletResponse response, Object command,
                                  BindException errors)
                           throws Exception {
    Application application = (Application) command;

    super.getOpi().storeApplicationDirty(application);
    WebUtils.setSessionAttribute(request, "application", application);

    ModelAndView modelAndView;

    if (WebUtils.hasSubmitParameter(request, "save")) {
      modelAndView = new ModelAndView(super.getUserStartView(request));
    } else if (request.getParameter("additionalGuarantors") != null) {
      if (logger.isDebugEnabled()) {
        logger.debug("Going to additional guarantors section ...");
      }
      modelAndView = new ModelAndView(this.additionalGuarantorsView);
    } else {
      if (application.isHasAdditionalGuarantor()) {
        this.advisorService.removeAdditionalGuarantor(application);
      }
      modelAndView = new ModelAndView(super.getSuccessView());
    }

    return modelAndView;
  }

  @Override
  protected Map referenceData(HttpServletRequest request)
                       throws Exception {
    Map<String, Object> ref = new HashMap<String, Object>();

    ref.put(
      "startpage",
      StringUtils.removeStart(super.getUserStartView(request), "redirect:/"));

    return ref;
  }

  @Override
  protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder)
  {
     SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
     dateFormat.setLenient(false);
     binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true,10));
     binder.registerCustomEditor(String.class, new StringTrimmerEditor(false));
     binder.registerCustomEditor(Long.class, new CustomNumberEditor(Long.class, new DecimalFormat("###,###,###"), false));
     binder.registerCustomEditor(long.class, new CustomNumberEditor(Long.class, new DecimalFormat("###,###,###"), false));
  }
  
  @Override
  protected ModelAndView handleInvalidSubmit(HttpServletRequest request,
                                             HttpServletResponse response)
                                      throws Exception {
    return disallowDuplicateFormSubmission(request, response);
  }

  /**
   * Sets the view to the additional guarantors page.
   * 
   * @param additionalGuarantorsView The additional guarantors page.
   */
  public void setAdditionalGuarantorsView(String additionalGuarantorsView) {
    this.additionalGuarantorsView = additionalGuarantorsView;
  }

  public void setAdvisorService(AdvisorServiceIF advisorService) {
    this.advisorService = advisorService;
  }
  
  //~ Static fields/initializers -----------------------------------------------

  private AdvisorServiceIF advisorService;
  private String additionalGuarantorsView;
  private static final Log logger = LogFactory.getLog(FinancialsForm.class);
}
