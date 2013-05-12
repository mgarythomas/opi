package org.opi.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Advisor;
import org.opi.domain.Advisorfirm;
import org.opi.domain.Advisorprovider;
import org.opi.domain.Authorities;
import org.opi.domain.AuthoritiesId;
import org.opi.domain.Company;
import org.opi.domain.Constants;
import org.opi.domain.Dealergroup;
import org.opi.domain.Individual;
import org.opi.domain.Superusers;
import org.opi.domain.Users;
import org.opi.domain.Utils;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;


/**
 * JavaBean form controller that is used to add a new <code>Advisor</code> with Role.type "Advisor" to the system.
 *
 * @author Paul McLachlan
 */
public class AddAdvisorCompleteForm extends AbstractOpiForm {

   private static final Log log = LogFactory.getLog(AddAdvisorCompleteForm.class);

   private String superusersView;

  /**
    * Set the name of the view that should be used for existing display.
    */
   public void setSuperusersView(String superusersView) {
      this.superusersView = superusersView;
   }

	public AddAdvisorCompleteForm() {
		setCommandName("advisor");
		// need a session to hold the formBackingObject
		setSessionForm(true);
	}

   /**
    * @see org.springframework.web.servlet.mvc.SimpleFormController#referenceData(javax.servlet.http.HttpServletRequest)
    */
   @Override
   protected Map referenceData(HttpServletRequest request) throws Exception {
       Map<String, Object> ref = new HashMap<String, Object>();
       ref.put("titles", Utils.getTitles());
       ref.put("states", Utils.getDefaultStates());
       return ref;
   }


	/** Method creates a new <code>Individual</code> with the correct <code>Advisorfirm</code> info */
	@SuppressWarnings("unchecked")
  protected Object formBackingObject(HttpServletRequest request) throws ServletException {
      Dealergroup dealergroup;

      Boolean finder = (Boolean)WebUtils.getSessionAttribute(request, "finder");
      if (finder != null) {
         log.info("Trying to find a User");
         Individual individual = (Individual)WebUtils.getSessionAttribute(request, "individual");
         Advisor advisor = new Advisor(-1);
         if (individual != null) {
            advisor.setIndividual(individual);
            log.info("found advisor with advisor.individual.workemail="+advisor.getIndividual().getWorkemail());
            request.setAttribute("email", advisor.getIndividual().getWorkemail());
         } else {
            advisor.setId(-2);
         }
           
         return advisor;
      }
      
      try {
         long dealergroupId = ServletRequestUtils.getRequiredLongParameter(request, "dealergroupId");
         dealergroup = getOpi().loadDealergroup(dealergroupId);
      } catch (Exception e){
         dealergroup = new Dealergroup();
         //dealergroup.setAfsl(ServletRequestUtils.getRequiredStringParameter(request, "afsl"));
         Company company = new Company();
         //company.setDealergroup(dealergroup);
         dealergroup.setCompany(company);
      }
      
      Advisorfirm advisorfirm = new Advisorfirm();
      advisorfirm.setCompany(new Company());
      advisorfirm.setDealergroup(dealergroup);
      Advisor advisor = new Advisor();
      
      //Users users = Utils.getUser();
      Individual individual = new Individual(); 
      String providerTheme = getSessionTheme(request);
      Company provider = providerTheme != null ? getOpi().loadProviderSimple(providerTheme) : null; // 'dealer' must have a provider
      if (provider != null) {
         log.info("associating advisor with = " + providerTheme);
         Advisorprovider advisorprovider = new Advisorprovider();
         advisorprovider.setCompany(provider);
         advisorprovider.setAdvisor(advisor);
         advisor.addAdvisorproviders(advisorprovider);
      }
      else { // associate all Products with the new Advisor
         log.info("associating advisor with all Providers");
         List<Company> providers = getOpi().loadProviders();
         for (Company providerTmp : providers) {
            Advisorprovider advisorprovider = new Advisorprovider();
            advisorprovider.setCompany(providerTmp);
            advisorprovider.setAdvisor(advisor);
            advisor.addAdvisorproviders(advisorprovider);
         }
      }
      Users users = new Users();
      AuthoritiesId authoritiesId = new AuthoritiesId();
      authoritiesId.setAuthority(Constants.ADVISOR);
      Authorities authorities = new Authorities();
      authorities.setId(authoritiesId); 
      advisor.setAuthorities(authorities);
      individual.setUsers(users);
      advisor.setIndividual(individual);
      advisor.setAdvisorfirm(advisorfirm);

      return advisor;
	}

   /** Method inserts a new <code>Advisor</code>. */
   protected ModelAndView onSubmit(
         HttpServletRequest request, HttpServletResponse response, Object command, BindException errors)
         throws Exception {
      Advisor advisor = (Advisor) command;

      // check Advisor has not already registered
      Advisor result = this.getOpi().findByAbnAndFullname(advisor.getAdvisorfirm().getCompany().getAbn(), 
            advisor.getIndividual().getLastname(), advisor.getIndividual().getFirstname());
      if (!result.isNew()) {
         errors.rejectValue("id", null, "Advisor already registered. Logout to retrieve password");
            return showForm(request, response, errors);
      }

      Superusers superusers = null;
      try {
         superusers = (Superusers)WebUtils.getRequiredSessionAttribute(request, "superusers");
      } catch (Exception e) {
         log.info("This is not a Superuser");
      }
      
      // update the command object if the dg was pre-populated by Ajax
      Advisorfirm advisorfirm = (Advisorfirm)WebUtils.getSessionAttribute(request, "advisorfirm");
      if (advisorfirm != null)
         advisor.setAdvisorfirm(advisorfirm);
      
      Dealergroup dealergroup = (Dealergroup)WebUtils.getSessionAttribute(request, "dealergroup");
      if (dealergroup != null)
            advisor.getAdvisorfirm().setDealergroup(dealergroup);         
            
      if (superusers != null)
      {
         Map<String, Object> model = new HashMap<String, Object>();
         model.put("investorType", superusers.getTransadvisor().getTransinvestortype());
         model.put("productId", superusers.getTransadvisor().getTransproductname());

         advisor.setIsactivated(Constants.FALSE);

         getOpi().storeAdvisorComplete(advisor);
         
         getOpi().myMailManager().sendUserNameandPassword(advisor);

         this.getOpi().loadAdvisors(superusers);
         superusers.setTransadvisor(advisor);
         superusers.setTransadvisorId(advisor.getId());
         
         WebUtils.setSessionAttribute(request, "advisor", advisor);
         WebUtils.setSessionAttribute(request, "superusers", superusers);
         
         return new ModelAndView(superusersView, model);
      }
      
      WebUtils.setSessionAttribute(request, "advisor", advisor);
		return new ModelAndView(this.getSuccessView(), "dealergroupId", advisor.getAdvisorfirm().getDealergroup().getId());
	}

	protected ModelAndView handleInvalidSubmit(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return disallowDuplicateFormSubmission(request, response);
	}

}
