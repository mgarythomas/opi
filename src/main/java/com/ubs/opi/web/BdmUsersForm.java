package com.ubs.opi.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.ubs.opi.domain.Company;
import com.ubs.opi.domain.Individual;
import com.ubs.opi.service.BdmAdminServiceIF;
import com.ubs.opi.validation.BdmUsersValidator;

/**
 * Form controller for the BDM admin page.
 *
 * @author Paul McLachlan
 * @author Ana Velez
 */
public class BdmUsersForm extends AbstractOpiForm {
  //~ Constructors -------------------------------------------------------------

  public BdmUsersForm() {
    setCommandName("company");
    setSessionForm(true);
  }

  //~ Methods ------------------------------------------------------------------

  @Override
  protected Object formBackingObject(HttpServletRequest request)
                              throws ServletException {
    User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    Company provider = this.bdmAdminService.findProviderForBdmAdmin(user.getUsername());
      
    WebUtils.setSessionAttribute(request, "provider", provider);

    return provider;
  }

  @Override
  protected Map referenceData(HttpServletRequest request)
                       throws Exception {
    Map<String, Object> ref = new HashMap<String, Object>();
    
    Company provider = (Company) WebUtils.getSessionAttribute(request, "provider");
    
    List<Individual> bdms = this.bdmAdminService.findBdmsForProvider(provider);

    ref.put("bdms", bdms);

    return ref;
  }

  @Override
  protected ModelAndView onSubmit(HttpServletRequest request,
                                  HttpServletResponse response, Object command,
                                  BindException errors)
                           throws Exception {
    Company provider = (Company) command;

    WebUtils.setSessionAttribute(request, "provider", provider);
    
    if (BdmUsersValidator.validateBdmUsers(provider, errors).getFieldErrorCount() > 0)
      return showForm(request, response, errors);

    if (logger.isDebugEnabled()) {
      logger.debug("Saving BDM associations ...");
    }
    this.bdmAdminService.updateBdmRelationshipsForProvider(provider.getAdvisorproviders());

    if (WebUtils.hasSubmitParameter(request, "associate")) {
      return new ModelAndView(super.getSuccessView());
    } else if (WebUtils.hasSubmitParameter(request, "create")) {
      return new ModelAndView(this.bdmView, "operation", "create");
    } else {
      return new ModelAndView(this.bdmView, "operation", "edit");
    }
  }
  
  @Override
  protected ModelAndView handleInvalidSubmit(HttpServletRequest request,
                                             HttpServletResponse response)
                                      throws Exception {
    return disallowDuplicateFormSubmission(request, response);
  }

  public void setBdmView(String bdmView) {
    this.bdmView = bdmView;
  }
  
  public void setBdmAdminService(BdmAdminServiceIF bdmAdminService) {
    this.bdmAdminService = bdmAdminService;
  }

  //~ Static fields/initializers -----------------------------------------------

  private static final Log logger = LogFactory.getLog(BdmUsersForm.class);

  //~ Instance fields ----------------------------------------------------------

  private BdmAdminServiceIF bdmAdminService;
  private String bdmView;
}
