package org.opi.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opi.domain.Advisor;
import org.opi.domain.Application;
import org.opi.domain.ApplicationComp;
import org.opi.domain.BaseDomain;
import org.opi.domain.Product;
import org.opi.domain.Superusers;
import org.opi.domain.Utils;
import org.opi.service.SuperUserServiceIF;
import org.opi.validation.SuperusersValidator;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.validation.BindException;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;


/**
 * JavaBean form controller that is used to add a new <code>Advisor</code>
 * with Role.type "Advisor" to the system.
 * 
 * @author Paul McLachlan
 */
public class SuperusersForm extends AbstractOpiForm {

  private static final Log log = LogFactory.getLog(SuperusersForm.class);

  private String existingView;

  private String createadvisorView;

  private SuperUserServiceIF superUserService;

  public void setSuperUserService(SuperUserServiceIF superUserService) {
    this.superUserService = superUserService;
  }

  /**
	 * Set the name of the view that should be used for existing display.
	 */
	public void setExistingView(String existingView) {
		this.existingView = existingView;
	}

	public void setCreateadvisorView(String createadvisorView) {
		this.createadvisorView = createadvisorView;
	}

	public SuperusersForm() {
		setCommandName("superuser");
		// need a session to hold the formBackingObject
		setSessionForm(true);
	}

	/**
	 * Method creates a new <code>Application</code> with the correct
	 * <code>Advisor</code> info
	 */
	@Override
   protected Object formBackingObject(HttpServletRequest request) throws ServletException {
    WebUtils.setSessionAttribute(request, "productId", null);
    WebUtils.setSessionAttribute(request, "investorType", null);
    
		Superusers superusers = new Superusers();
      
    if (!BaseDomain.isSuperuser())
       return superusers;
      
		try {
			superusers = (Superusers) WebUtils.getSessionAttribute(request, "superusers");
			if ((superusers == null) || (superusers.getTransadvisor() == null)) {
				superusers = new Superusers();
				superusers.setUsers(Utils.getUser());
			} else {
				if (!superusers.getTransadvisorId().equals(new Long(1)))	{
					Advisor advisor = this.getOpi().loadAdvisor(superusers.getTransadvisorId());
					superusers.setTransadvisor(advisor);
				}
			}
		} catch (Exception e) {
			superusers = new Superusers(); 
			superusers.setUsers(Utils.getUser());
		}

      if (superusers.getTransadvisor() == null) 
          getOpi().loadAdvisors(superusers);

        //this.getOpi().load
      Map<Long, String> investors = new LinkedHashMap<Long, String>(Utils.getInvestors());
      
      if (!superusers.getTransadvisorId().equals(new Long(1L))) {
         Set<Application> applications = superusers.getTransadvisor().getApplications();
         
         Set<Application> sortedApps = new TreeSet<Application>(new ApplicationComp());
         sortedApps.addAll(applications);
         
         for (Application application : sortedApps) {
            investors.put(application.getId(), application.getAccountdesignation());
         }

      } else {
    	  
         superusers.setTransadvisor(new Advisor());
      }
      
      superusers.setInvestors(investors);

      WebUtils.setSessionAttribute(request, "superusers", superusers);
		return superusers;
	}

	@Override
   protected Map referenceData(HttpServletRequest request) throws Exception {
    Map<Object, Object> ref = new HashMap<Object, Object>();
    if (!BaseDomain.isSuperuser())
       return ref;

	  Superusers superusers = (Superusers) WebUtils.getSessionAttribute( request, "superusers");
    
    ref.put("filteredApplicationsUnique", new HashSet<Application>()); // 0 initially.
    ref.put("advisors", superusers.getAdvisors());
    ref.put("investors", superusers.getInvestors());
    // superusers can see all products.

    List<Product> products = this.superUserService.getProductsToDisplayForSuperusers();
    
    ref.put("products", products);
    
    String theme = super.getSessionTheme(request);
    ref.put("sessionTheme", theme);

		return ref;
	}

	/**
	 * Sets up a number of custom property editors; one for the application's
	 * date format, and another for empty fields.
	 */
	@Override
   protected void initBinder(HttpServletRequest request,
			ServletRequestDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor( dateFormat, true, 10));
		binder.registerCustomEditor(String.class, new StringTrimmerEditor(false));
	}

	/** Method inserts a new <code>Advisor</code>. */
	@Override
   protected ModelAndView onSubmit(HttpServletRequest request, HttpServletResponse response, Object command, BindException errors) throws Exception 
   {
		Superusers superusers = (Superusers) command;

		try {
			long applicationId = ServletRequestUtils.getRequiredLongParameter(request, "removeId");
			this.getOpi().removeApplication(applicationId);
			// this.formBackingObject(request);
			// return this.showForm(request, response, errors);
			return new ModelAndView(this.existingView);
		} catch (Exception e1) {
			log.info("We're not removing an application!");
			// return new Advisor();
		}

		WebUtils.setSessionAttribute(request, "superusers", superusers);

		try {
			boolean refresh = ServletRequestUtils.getRequiredBooleanParameter(request, "refresh");
			if (refresh) {
				return new ModelAndView(this.existingView); 
			}
		} catch (Exception e1) { 
			log.debug("Not refreshing the View.");
		}

    int investorindex = ServletRequestUtils.getIntParameter(request, "investorindex"); // investorkey
    if (investorindex != -1)
    {   
       Map<Long, String> investors = superusers.getInvestors();
       Set<Long> keyset = investors.keySet();
       Long key = (Long)keyset.toArray()[investorindex];      
       superusers.getTransadvisor().setTransinvestortype(key.toString());
    }
    
		if (superusers.getTransadvisorId() == 1) // New Advisor
		{
		      WebUtils.setSessionAttribute(request, "productId", superusers.getTransadvisor().getTransproductname());
		      WebUtils.setSessionAttribute(request, "investorType", superusers.getTransadvisor().getTransinvestortype());
			return new ModelAndView(this.createadvisorView);
		}

      if (SuperusersValidator.validateSuperusers(superusers,errors).getFieldErrorCount() > 0)
         return showForm(request, response, errors);
      // long investortype = -1;

		if (superusers.getTransadvisor().getTransinvestortype() != null)
		// try
		{
      WebUtils.setSessionAttribute(request, "productId", superusers.getTransadvisor().getTransproductname());
      WebUtils.setSessionAttribute(request, "investorType", superusers.getTransadvisor().getTransinvestortype());
			return new ModelAndView(this.getSuccessView());
		} else // catch (Exception e)
		{
			// model.put("refreshinvestors", true);
			// log.info("Investor Type not selected, refresh existing page");
			return new ModelAndView(this.existingView);
		}
	}

	@Override
   protected ModelAndView handleInvalidSubmit(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		return disallowDuplicateFormSubmission(request, response);
	}

}
