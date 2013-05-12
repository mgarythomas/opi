package org.opi.web.controller.application;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Application;
import org.opi.domain.Constants;
import org.opi.domain.Individual;
import org.opi.domain.Investorindividual;
import org.opi.domain.Utils;
import org.opi.service.OpiServiceIF;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.validation.BindException;
import org.springframework.validation.Errors;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractWizardFormController;


/**
 * Controller for the application form wizard pages.
 * 
 * @author Ana Velez
 */
public class ApplicationWizardFormController extends AbstractWizardFormController {
  public static final int PAGE_1_INVESTOR_DETAILS = 0;
  public static final int PAGE_2_BENEFICIARIES = 1;
  public static final int PAGE_3_INVESTMENT_DETAILS = 2;
  public static final int PAGE_4_FINANCIALS = 3;
  public static final int PAGE_5_DIRECT_DEBIT = 4;
  public static final int PAGE_6_INVESTOR_INFO = 5;
  public static final int PAGE_7_CONFIRMATION = 6;
  
  /**
   * Sets the wizard's backing application object.
   * 
   * @param request The HTTP request.
   * 
   * @return The application object we are working on.
   */
  @Override
  protected Object formBackingObject(HttpServletRequest request) throws Exception {
    Long applicationId = ServletRequestUtils.getLongParameter(request, "applicationId");
    
    Application application;
    if (applicationId != null) {
      // editing an application.
      application = this.opiService.getApplicationByIdForEditing(applicationId);
      
    } else {
      // creating new application.
      application = new Application(); // TODO : goto AddAdvisorapplicationForm.createApplication();
      logger.error("WARNING: this will not work yet.  STUB!!");
    }
    
    return application;
  }
  
  protected ModelAndView processFinish(HttpServletRequest request,
                                       HttpServletResponse response,
                                       Object command,
                                       BindException errors) throws Exception {
    logger.info("STUB to save application and FINISH.");
    
    return new ModelAndView("redirect:/advisormainpage.htm");
  }

  @Override
  protected ModelAndView processCancel(HttpServletRequest request,
                                       HttpServletResponse response,
                                       Object command,
                                       BindException errors) throws Exception {
    logger.info("STUB to CANCEL application.");
    
    return new ModelAndView("redirect:/advisormainpage.htm");
  }

  @Override
  protected void validatePage(Object command, Errors errors, int page) {
    logger.info("STUB to validate page.");
  }
  
  @Override
  protected void postProcessPage(HttpServletRequest request, Object command, Errors errors, int page)
    throws Exception {

    logger.info("STUB to save application so far.  page = " + page);
  }
  
  @Override
  protected int getTargetPage(HttpServletRequest request, Object command, Errors errors, int currentPage) {
    // if (true) return super.getTargetPage(request, command, errors, currentPage);
    
    Application application = (Application) command;
    
    int targetPage;
    
    switch (currentPage) {
    case PAGE_1_INVESTOR_DETAILS:
      String action = request.getParameter("action");
      if (StringUtils.equalsIgnoreCase(action, "addApplicant")) {
        addApplicant(application);
        targetPage = PAGE_1_INVESTOR_DETAILS;
      } else if ((application.getType() == Constants.CORPORATE_TYPE.longValue()) || 
          (application.getType() == Constants.CORPORATE_TRUST_TYPE.longValue())) {
        targetPage = PAGE_2_BENEFICIARIES;
      } else {
        targetPage = PAGE_3_INVESTMENT_DETAILS;
      }
      break;
    case PAGE_3_INVESTMENT_DETAILS:
      if (application.getIsborrowingfromubs().equals(Constants.TRUE)) {
        targetPage = PAGE_4_FINANCIALS;
      } else {
        targetPage = PAGE_5_DIRECT_DEBIT;
      }
      break;
    case PAGE_7_CONFIRMATION: // last page.  goto main page.
      throw new RuntimeException("Shouldn't have 'next' option for last page!!");
    default:
      targetPage = ++currentPage;
    }
    
    return targetPage;
  }
  
  /**
   * Place any collections needed for select boxes or any other related
   * data needed to render the front-end.
   * 
   * @param request The HTTP request.
   * @param page The page number.
   * 
   * @return The reference data.
   */
  @Override
  protected Map referenceData(HttpServletRequest request, int page) throws Exception {
    Map<String, Object> ref = new HashMap<String, Object>();
    
    switch (page) {
    case 0:
      ref.put("titles", Utils.getTitles());
      ref.put("states", Utils.getStates());
      //ref.put("defaultstates", Utils.getStates());
      ref.put("defaultcountries", Utils.getDefaultCountries());
      ref.put("countries", Utils.getCountries()); 
      ref.put("nationalities", Utils.getNationalities());
      break;
    }

    return ref;
  }
  
  /**
   * Registers custom front-end editors (such as date formatters, etc).
   */
  protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) {
    binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true, 10));
    binder.registerCustomEditor(String.class, new StringTrimmerEditor(false));
    binder.registerCustomEditor(Long.class, new CustomNumberEditor(Long.class, new DecimalFormat("###,###,###"), false));
    binder.registerCustomEditor(long.class, new CustomNumberEditor(Long.class, new DecimalFormat("###,###,###"), false));
  }
  
  /**
   * Adds an applicant to the given application.
   * 
   * @param application The application.
   */
  private static void addApplicant(Application application) {
    Investorindividual investorindividual = new Investorindividual();
    investorindividual.setIndividual(new Individual());
    String role = Constants.APPLICANT; 
    investorindividual.setIsapplicant(Constants.TRUE);
    if ((application.getType() == Constants.CORPORATE_TYPE) || (application.getType() == Constants.CORPORATE_TRUST_TYPE))
    {
       investorindividual.setIsdirector(Constants.TRUE);
       role = Constants.DIRECTOR;
    }
    else if (application.getType() == Constants.PRIVATE_TRUST_TYPE)
    {
       investorindividual.setIstrustee(Constants.TRUE);
       role = Constants.TRUSTEE;
    }
    
    investorindividual.setRole(role);
    investorindividual.setApplication(application);
    application.addInvestorindividual(investorindividual);
  }
  
  /**
   * @param opiService the opiService to set
   */
  public void setOpiService(OpiServiceIF opiService) {
    this.opiService = opiService;
  }

  private OpiServiceIF opiService;
  
  private static final Log logger = LogFactory
      .getLog(ApplicationWizardFormController.class);
  private static final SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
  static {
    dateFormat.setLenient(false);
  }

}
