package org.opi.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Advisor;
import org.opi.domain.Application;
import org.opi.domain.Product;
import org.opi.service.AdvisorServiceIF;
import org.opi.validation.AdvisorapplicationsValidator;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

/**
 * JavaBean form controller that is used to add a new <code>Advisor</code> with Role.type "Advisor" to the system.
 *
 * @author Paul McLachlan
 */
public class AdvisorapplicationsForm extends AbstractOpiForm {
  
  public AdvisorapplicationsForm() {
    setCommandName("advisor");  // application
    setSessionForm(true);
  }

  private AdvisorServiceIF advisorService;
  
  private static final Log logger = LogFactory.getLog(AdvisorapplicationsForm.class);
  
  public void setAdvisorService(AdvisorServiceIF advisorService) {
    this.advisorService = advisorService;
  }

   protected Object formBackingObject(HttpServletRequest request) 
                               throws ServletException {
     WebUtils.setSessionAttribute(request, "productId", null);
     WebUtils.setSessionAttribute(request, "investorType", null);
     WebUtils.setSessionAttribute(request, "application", null);
     WebUtils.setSessionAttribute(request, "application2", null);
     return super.getAdvisorInSession(request);
   }

   /**
    * @see org.springframework.web.servlet.mvc.SimpleFormController#referenceData(javax.servlet.http.HttpServletRequest)
    */
   @Override
   protected Map referenceData(HttpServletRequest request) throws Exception {
       Map<String, Object> ref = new HashMap<String, Object>();
       
       Advisor advisor = super.getAdvisorInSession(request);
       
//       Advisor advisor1 = (Advisor)WebUtils.getSessionAttribute(request, "org.opi.web.AdvisorapplicationsForm.FORM.advisor");
       
       // filter out applications according to business logic:
       Set<Application> filteredApplications = this.advisorService.getApplicationsToDisplay(advisor);
       ref.put("filteredApplications", filteredApplications);
       
       Set<Application> filteredApplicationsUnique = this.advisorService.getApplicationsToDisplayUnique(advisor);
       ref.put("filteredApplicationsUnique", filteredApplicationsUnique);

       Map<Long, String> investors = getOpi().loadInvestors(advisor);
       ref.put("investors", investors);
       
       // advisors should only see the products that match the portal theme
       // they have logged in through.
       String theme = super.getSessionTheme(request);
       List<Product> products = this.advisorService.getProductsToDisplayForTheme(theme);
       ref.put("products", products);
       
       // used to determine whether to display calculator links on top.
       ref.put("sessionTheme", theme);
       
       return ref;
   }

   /** Method inserts a new <code>Advisor</code>. */
   protected ModelAndView onSubmit(
         HttpServletRequest request, HttpServletResponse response, Object command, BindException errors)
         throws Exception {
      Advisor advisor = (Advisor) command;

      Map<String,String> model = new HashMap<String,String>();
      
      // Need to do validation in Submit
      AdvisorapplicationsValidator.validateAdvisor(advisor, errors);
      if (errors.hasErrors())
          return showForm(request, response, errors);

      //model.put("applicationId", advisor.getId());
      String investortype = advisor.getTransinvestortype();

      WebUtils.setSessionAttribute(request, "productId", advisor.getTransproductname());
      WebUtils.setSessionAttribute(request, "investorType", investortype);

      logger.info("forwarding to "+this.getSuccessView());
      return new ModelAndView(getSuccessView(), model);
   }

   protected ModelAndView handleInvalidSubmit(HttpServletRequest request, HttpServletResponse response)
         throws Exception {
      return disallowDuplicateFormSubmission(request, response);
   }

}
