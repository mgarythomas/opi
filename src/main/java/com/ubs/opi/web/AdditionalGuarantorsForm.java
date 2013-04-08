package com.ubs.opi.web;

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
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.ubs.opi.domain.Application;
import com.ubs.opi.domain.Constants;
import com.ubs.opi.domain.FinancialInformation;
import com.ubs.opi.domain.Individual;
import com.ubs.opi.domain.Investorindividual;
import com.ubs.opi.domain.Utils;
import com.ubs.opi.service.AdvisorServiceIF;

/**
 * Controller for the additonal guarantors section.
 *
 * @author Paul McLachlan
 * @author Ana Velez
 */
public class AdditionalGuarantorsForm extends AbstractOpiForm {
  //~ Constructors -------------------------------------------------------------

  public AdditionalGuarantorsForm() {
    setCommandName("additionalGuarantor");
    setSessionForm(true);
  }

  //~ Methods ------------------------------------------------------------------

  @Override
  public Investorindividual formBackingObject(HttpServletRequest request)
                                   throws ServletException {
    Application application = super.getApplication(request, false);
    
    Investorindividual additionalGuarantor;
    
    if (application.getInternalGuarantor() != null) {
      additionalGuarantor = application.getInternalGuarantor();
    } else if (application.getExternalGuarantor() != null) {
      additionalGuarantor = application.getExternalGuarantor();
    } else {
      // Create new one.  In only link downwards here because that should be
      // all we need for the JSTL.
      
      additionalGuarantor = new Investorindividual();
      additionalGuarantor.setId(-1L);
      additionalGuarantor.setRole(Constants.GUARANTOR);
      additionalGuarantor.setApplication(application);
      additionalGuarantor.setIndividual(new Individual());
    }
    
    if (additionalGuarantor.getFinancialInformation() == null) {
      additionalGuarantor.setFinancialInformation(new FinancialInformation());
      additionalGuarantor.getFinancialInformation().setCash(0L);
      additionalGuarantor.getFinancialInformation().setShares(0L);
      additionalGuarantor.getFinancialInformation().setOtherLiquid(0L);
      additionalGuarantor.getFinancialInformation().setResidentialProperty(0L);
      additionalGuarantor.getFinancialInformation().setInvestmentProperty(0L);
      additionalGuarantor.getFinancialInformation().setOtherassets(0L);
      additionalGuarantor.getFinancialInformation().setOtherLoansSecured(0L);
      additionalGuarantor.getFinancialInformation().setLoansResProperty(0L);
      additionalGuarantor.getFinancialInformation().setLoansInvProperty(0L);
      additionalGuarantor.getFinancialInformation().setLoansPersonalUnse(0L);
      additionalGuarantor.getFinancialInformation().setGuaranteesGranted(0L);
      additionalGuarantor.getFinancialInformation().setOtherLiabilities(0L);
      additionalGuarantor.getFinancialInformation().setSalary(0L);
      additionalGuarantor.getFinancialInformation().setRentalAndDividend(0L);
      additionalGuarantor.getFinancialInformation().setOtherIncome(0L);
      additionalGuarantor.getFinancialInformation().setTaxPayable(0L);
      additionalGuarantor.getFinancialInformation().setIntSecuredLoans(0L);
      additionalGuarantor.getFinancialInformation().setIntUnsecuredLoans(0L);
      additionalGuarantor.getFinancialInformation().setLivingExpenses(0L);
      additionalGuarantor.getFinancialInformation().setOtherExpenses(0L);
    }
    
    return additionalGuarantor;
  }

  /**
   * Algorithm:
   * if investorid is different from existing one:
   *   delete existing link,  recreate new link
   * else
   *   update
   */
  @Override
  public ModelAndView onSubmit(HttpServletRequest request,
                                  HttpServletResponse response, Object command,
                                  BindException errors)
                           throws Exception {
    Application applicationInSession = super.getApplication(request, false);
    
    Application application = this.advisorService.findApplicationById(applicationInSession.getId());
    
    Investorindividual transientGuarantor = (Investorindividual) command;
    
    if (logger.isDebugEnabled()) {
      logger.debug("Saving associations ...");
    }
    this.advisorService.associateAsGuarantor(application, transientGuarantor, transientGuarantor.getIndividual(), transientGuarantor.getFinancialInformation());
    
    Application applicationWithDependencies = this.advisorService.loadApplicationForEditing(application.getId());
    
    WebUtils.setSessionAttribute(request, "application", applicationWithDependencies);
    WebUtils.setSessionAttribute(request, "application2", applicationWithDependencies);
    
    ModelAndView modelAndView;

    if (WebUtils.hasSubmitParameter(request, "save")) {
      modelAndView = new ModelAndView(super.getUserStartView(request));
    } else {
      modelAndView = new ModelAndView(super.getSuccessView());
    }

    return modelAndView;
  }

  @Override
  protected Map referenceData(HttpServletRequest request)
                       throws Exception {
    Map<String, Object> ref = new HashMap<String, Object>();
    Application application = super.getApplication(request, false);
    
    ref.put("startpage", StringUtils.removeStart(super.getUserStartView(request), "redirect:/"));
    ref.put("elegibleInvestorIndividuals", application.getElegibleAdditionalGuarantors());
    ref.put("hasExternalGuarantor", application.getExternalGuarantor() != null ? true : false);
    ref.put("application", application);
    ref.put("titles", Utils.getTitles());
    ref.put("states", Utils.getStates());
    ref.put("defaultcountries", Utils.getDefaultCountries());
    ref.put("countries", Utils.getCountries()); 
    ref.put("nationalities", Utils.getNationalities());

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

  public void setAdvisorService(AdvisorServiceIF advisorService) {
    this.advisorService = advisorService;
  }

  //~ Static fields/initializers -----------------------------------------------

  private static final Log logger = LogFactory.getLog(AdditionalGuarantorsForm.class);
  
  private AdvisorServiceIF advisorService;



}
