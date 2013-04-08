package com.ubs.opi.web.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.util.WebUtils;

import com.ubs.opi.domain.Application;
import com.ubs.opi.service.ApplicationServiceIF;

/**
 * Abstract controller for OPI base controllers. 
 * 
 * @author Ana Velez
 */
public abstract class AbstractOpiController extends SimpleFormController {
  protected static final String PAGE_CONFIRMATION = "/confirmation.htm";

  /**
   * Set binders for custom form elements such as dates, formatted number, etc.
   */
  protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) {
     binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true,10));
     binder.registerCustomEditor(String.class, new StringTrimmerEditor(false));
     binder.registerCustomEditor(Long.class, new CustomNumberEditor(Long.class, new DecimalFormat("###,###,###"), false));
     binder.registerCustomEditor(long.class, new CustomNumberEditor(Long.class, new DecimalFormat("###,###,###"), false));
  }
  
  /**
   * Reads the application in session.  If it doesn't exist it will attempt
   * to read it based on the applicationId parameter.
   * 
   * @param request The HTTP request.
   * 
   * @return The application in session.
   * 
   * @throws ServletException If the application doesn't exist in the session
   *         and an applicationId parameter isn't passed. 
   */
  protected Application getApplication(HttpServletRequest request) throws ServletException {
    Application application = (Application) WebUtils.getSessionAttribute(request, "application");
    
    // This is a hack till i figure out why the application gets removed
    // from the session when you refresh.
    Application application2 = (Application) WebUtils.getSessionAttribute(request, "application2");
    if (application != null) {
      request.getSession().setAttribute("application2", application);
    } else {
      application = application2;
    }
    
    return application;
  }
  
  /**
   * Gets the view for the start page depending on the user role.
   * 
   * @param request The HTTP request.
   * 
   * @return The start page.
   */
  public String getStartView(HttpServletRequest request) {
    WebUtils.setSessionAttribute(request, "application", null);
    
    String viewName;
    if (request.getSession().getAttribute("superusers") != null) {
      viewName = "redirect:/superusers.htm";
    } else {
      viewName = "redirect:/advisorapplications.htm";
    }
    
    return viewName;
  }
  
  @Override
  protected ModelAndView handleInvalidSubmit(HttpServletRequest request,
                                             HttpServletResponse response)
                                             throws Exception {
    BindException errors = getErrorsForNewForm(request);
    errors.reject("duplicateFormSubmission", "Duplicate form submission");
    return showForm(request, response, errors);
  }

  /**
   * @param applicationService the applicationService to set
   */
  public void setApplicationService(ApplicationServiceIF applicationService) {
    this.applicationService = applicationService;
  }
  
  protected ApplicationServiceIF applicationService;
  private static final SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
  static {
    dateFormat.setLenient(false);
  }
}
