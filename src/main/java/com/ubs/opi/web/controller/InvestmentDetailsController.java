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
import com.ubs.opi.domain.Constants;
import com.ubs.opi.domain.Utils;

/**
 * Controller for the Investment Details section of the application process.
 * 
 * @author Paul McLachlan
 * @author Ana Velez
 */
public class InvestmentDetailsController extends AbstractOpiController {
  protected Object formBackingObject(HttpServletRequest request)
      throws ServletException {
    Application application = super.getApplication(request);
    
    return application;
  }

  protected Map referenceData(HttpServletRequest request) throws Exception {
    Map<String, Object> ref = new HashMap<String, Object>();
    
    ref.put("startpage", StringUtils.removeStart(super.getStartView(request), "redirect:/"));
    
    return ref;
  }
  
  protected ModelAndView onSubmit(HttpServletRequest request,
                                  HttpServletResponse response,
                                  Object command,
                                  BindException errors) throws Exception {
    Application application = (Application) command;

    if (logger.isDebugEnabled()) {
      logger.debug("Marking application as updated ...");
    }

    super.applicationService.saveChanges(application, Utils.getUser());

    WebUtils.setSessionAttribute(request, "application", application);

    ModelAndView modelAndView;

    if (WebUtils.hasSubmitParameter(request, "save")) {
      modelAndView = new ModelAndView(super.getStartView(request));
    } else if (application.getIsborrowingfromubs().equals(Constants.TRUE)) {
      modelAndView = new ModelAndView(super.getSuccessView());
    } else {
      modelAndView = new ModelAndView(this.ownfundsView);
    }

    return modelAndView;
  }

  /**
   * Set the name of the view that should be used for beneficiary display.
   */
  public void setOwnfundsView(String ownfundsView) {
    this.ownfundsView = ownfundsView;
  }

  private String ownfundsView;

  private static final Log logger = LogFactory
      .getLog(InvestmentDetailsController.class);
}
