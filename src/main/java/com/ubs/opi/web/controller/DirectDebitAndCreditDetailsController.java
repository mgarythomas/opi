package com.ubs.opi.web.controller;

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
import com.ubs.opi.domain.ApplicationDirectCreditDetails;
import com.ubs.opi.domain.Utils;
import com.ubs.opi.service.AdvisorServiceIF;

/**
 * Controller for the Direct Debit Direct Credit section of the application 
 * process.
 * 
 * @author Ana Velez
 */
public class DirectDebitAndCreditDetailsController extends AbstractOpiController {
  @Override
  protected Object formBackingObject(HttpServletRequest request) throws ServletException {
    Application applicationInSession = super.getApplication(request);
    
    if (applicationInSession.getDirectCreditDetails() == null) {
      applicationInSession.setDirectCreditDetails(new ApplicationDirectCreditDetails());
    }
    
    return applicationInSession;
  }

  @Override
  protected Map referenceData(HttpServletRequest request) throws Exception {
    Map<String, Object> ref = new HashMap<String, Object>();

    ref.put("states", Utils.getDefaultStates());
    ref.put("startpage", StringUtils.removeStart(super.getStartView(request), "redirect:/"));

    return ref;
  }

  @Override
  protected ModelAndView onSubmit(HttpServletRequest request,
                                  HttpServletResponse response,
                                  Object command,
                                  BindException errors) 
                           throws Exception {
    Application application = (Application) command;
    
    if (logger.isDebugEnabled()) {
      logger.debug("Saving changes ...");
    }
    
    super.applicationService.saveChanges(application, Utils.getUser());
    this.advisorService.updateDirectCreditDetails(application, application.getDirectCreditDetails());
    
    WebUtils.setSessionAttribute(request, "application", application);
    
    ModelAndView modelAndView;
    if (WebUtils.hasSubmitParameter(request, "save")) {
      modelAndView = new ModelAndView(super.getStartView(request));
    } else if (super.applicationService.isCitibankApplication(application)) {
      if (logger.isDebugEnabled()) {
        logger.debug("Citibank application.  Skipping investorinfo.htm page ...");
      }
      
      modelAndView = new ModelAndView("redirect:" + PAGE_CONFIRMATION);
    } else {
      modelAndView = new ModelAndView(super.getSuccessView()); 
    }
    
    return modelAndView; 
  }
  
  public void setAdvisorService(AdvisorServiceIF advisorService) {
    this.advisorService = advisorService;
  }
  
  private AdvisorServiceIF advisorService;
  
  private static final Log logger = LogFactory.getLog(DirectDebitAndCreditDetailsController.class);
}
